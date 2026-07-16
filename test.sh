#!/usr/bin/env bash

if [ "$#" -ne 3 ] || [ "$1" != "--output_path" ]; then
    exit 2
fi

case "$3" in
    base)
        exec poetry run pytest tests/test_pretty.py -vv --junitxml="$2" \
            --deselect=tests/test_pretty.py::test_pretty_repr_does_not_mutate_tuple_subclass \
            --deselect=tests/test_pretty.py::test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object
        ;;
    new)
        exec poetry run pytest -vv --junitxml="$2" \
            tests/test_pretty.py::test_pretty_repr_does_not_mutate_tuple_subclass \
            tests/test_pretty.py::test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object
        ;;
    *)
        exit 2
        ;;
esac
