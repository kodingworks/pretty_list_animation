import 'package:flutter/material.dart';
import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:pretty_list_animation/src/list_element_at_or_null.dart';

/// Generic widget for rendering a list of items with optional infinite scroll and item animations.
class PrettyListAnimation<T> extends StatefulWidget {
  const PrettyListAnimation({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.reverse = false,
    this.primary,
    this.physics,
    this.controller,
    this.padding,
    this.isInfinite = false,
    required this.onRefresh,
  }) : super(key: key);

  /// The list of items to be displayed in the list.
  final List<T> items;

  /// Whether the list should shrink-wrap its contents or fill the available space.
  final bool shrinkWrap;

  /// Whether the list should be displayed in reverse order.
  final bool reverse;

  /// The scroll direction of the list.
  final Axis scrollDirection;

  /// Whether the list is the primary scrollable on the screen.
  final bool? primary;

  /// The physics of the scroll view.
  /// For example : [AlwaysScrollableScrollPhysics] , [BouncingScrollPhysics] and [NeverScrollableScrollPhysics].
  final ScrollPhysics? physics;

  /// The scroll controller of the list.
  final ScrollController? controller;

  /// The padding around the [AnimatedList].
  final EdgeInsetsGeometry? padding;

  /// Whether the list should display an "infinite scroll" indicator.
  /// If it is [true] then it will be displayed and if it is [false] then it will be removed
  final bool isInfinite;

  /// The builder function for rendering each item in the list.
  final Widget Function(BuildContext, T, int, Animation<double>) itemBuilder;
  final Future<void> Function() onRefresh;

  @override
  State<PrettyListAnimation<T>> createState() => _PrettyListAnimationState<T>();
}

/// The state of the PrettyListAnimation widget.
class _PrettyListAnimationState<T> extends State<PrettyListAnimation<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  /// Whether the list supports infinite scrolling.
  late bool _isInfinite = false;

  List<T> get _items => widget.items;

  @override
  void initState() {
    super.initState();
    _isInfinite = widget.isInfinite;
  }

  @override
  void didUpdateWidget(covariant PrettyListAnimation<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// If the infinite scroll property has changed, update the state.
    if (oldWidget.isInfinite != widget.isInfinite) {
      setState(() {
        _isInfinite = widget.isInfinite;
      });
    }

    /// Handle list updates.
    _handleListUpdated(oldWidget.items);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: Column(
        children: [
          if (widget.shrinkWrap)
            _buildItem()
          else
            Expanded(child: _buildItem()),

          /// If infinite scrolling is enabled, display a loading indicator.
          if (_isInfinite)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the main [AnimatedList] widget with the configured properties and
  /// parameters, using the [_items] list and the provided [itemBuilder] function
  /// to render the items.
  Widget _buildItem() {
    return AnimatedList(
      key: _listKey,
      controller: widget.controller,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      primary: widget.primary,
      physics: widget.physics,
      padding: widget.padding,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) => widget.itemBuilder(
        context,
        _items[index],
        index,
        animation,
      ),
    );
  }

  /// Compares the current [_items] list with a previous version of the list
  /// (the [oldList] parameter) and calculates the differences between them.
  /// The resulting [diffutil.DiffResult] is used to update the [AnimatedList]
  /// with the necessary changes to keep it in sync with the list data.
  void _handleListUpdated(List<T> oldList) {
    final listState = _listKey.currentState;
    if (listState == null) return;

    final newList = widget.items;
    final diffResult = diffutil.calculateListDiff<T>(oldList, newList);
    final updates = diffResult.getUpdates(batch: false);
    if (updates.isEmpty) return;
    for (final update in updates) {
      update.when(
        move: (from, to) {
          _handleRemoveItem(from);
          _handleInsertItem(to);
        },
        insert: (to, _) => _handleInsertItem(to),
        remove: (from, _) => _handleRemoveItem(from, useAnimation: false),
        change: (_, __) {},
      );
    }
  }

  /// Inserts a new item into the [AnimatedList] at the specified index [to],
  /// triggering an animation that renders the item in the list.
  void _handleInsertItem(int to) => _listKey.currentState?.insertItem(to);

  /// Removes an item from the [AnimatedList] at the specified index [from],
  /// optionally using an animation to remove the item from the UI.
  void _handleRemoveItem(
    int from, {
    bool useAnimation = true,
  }) =>
      _listKey.currentState?.removeItem(from, (context, animation) {
        final item = _items.elementAtOrNull(from);
        if (item == null || !useAnimation) return Container();
        return widget.itemBuilder(context, item, from, animation);
      });
}
