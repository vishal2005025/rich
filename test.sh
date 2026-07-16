#!/usr/bin/env bash

if [ "$#" -ne 3 ] || [ "$1" != "--output_path" ]; then
    exit 2
fi

case "$3" in
    base)
        exec python -m poetry run pytest \
            tests/test_pretty.py \
            -k "not (test_pretty_repr_does_not_mutate_tuple_subclass or test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object)" \
            --junitxml="$2"
        ;;
    new)
        exec python -m poetry run pytest \
            tests/test_pretty.py \
            -k "test_pretty_repr_does_not_mutate_tuple_subclass or test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object" \
            --junitxml="$2"
        ;;
    *)
        exit 2
        ;;
esac