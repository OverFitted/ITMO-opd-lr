def neighbors(graph, vertex):
    """Возвращает список соседей для заданной вершины."""
    return graph[vertex]


def bron_kerbosch(graph, R=None, P=None, X=None, depth=0):
    """Алгоритм Брона-Кербоша для поиска всех клик в графе."""
    if R is None:
        R = set()
    if P is None:
        P = set(graph.keys())
    if X is None:
        X = set()

    print(f"Depth: {depth}, R: {R}, P: {P}, X: {X}")

    if len(P) == 0 and len(X) == 0:
        print(f"Clique found: {R}")
        return

    for vertex in list(P):
        new_neighbors = neighbors(graph, vertex)

        print(f"Selected vertex: {vertex}, new neighbors: {new_neighbors}")

        bron_kerbosch(graph,
                      R=R.union([vertex]),
                      P=P.intersection(new_neighbors),
                      X=X.intersection(new_neighbors),
                      depth=depth+1)

        P.remove(vertex)
        X.add(vertex)


graph = {
    "A": ["B", "D"],
    "B": ["A", "C", "D"],
    "C": ["B", "D"],
    "D": ["A", "B", "C"],
}
bron_kerbosch(graph=graph)
