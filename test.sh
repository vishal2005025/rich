#!/usr/bin/env bash

set -e

OUTPUT_PATH=""
MODE=""

while [ $# -gt 0 ]; do
    case "$1" in
        --output_path)
            OUTPUT_PATH="$2"
            shift 2
            ;;
        base|new)
            MODE="$1"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

if [ -z "$MODE" ]; then
    echo "Usage: test.sh [--output_path output.xml] base|new" >&2
    exit 1
fi

if [ "$MODE" = "base" ]; then
    if [ -n "$OUTPUT_PATH" ]; then
        exec python -m pytest tests/test_pretty.py \
            -k "not (test_pretty_repr_does_not_mutate_tuple_subclass or test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object)" \
            --junitxml="$OUTPUT_PATH"
    else
        exec python -m pytest tests/test_pretty.py \
            -k "not (test_pretty_repr_does_not_mutate_tuple_subclass or test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object)"
    fi
else
    if [ -n "$OUTPUT_PATH" ]; then
        exec python -m pytest tests/test_pretty.py \
            -k "test_pretty_repr_does_not_mutate_tuple_subclass or test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object" \
            --junitxml="$OUTPUT_PATH"
    else
        exec python -m pytest tests/test_pretty.py \
            -k "test_pretty_repr_does_not_mutate_tuple_subclass or test_pretty_repr_does_not_leave_probe_attributes_on_auto_vivifying_object"
    fi
fi