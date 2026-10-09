# case-unit-economics — task runner

.PHONY: data run test lint type all

setup:
	uv sync --all-groups

# Scripts live in scripts/; utils/ stays at repo root, so both roots go on PYTHONPATH.
PY := PYTHONPATH=.:scripts uv run python

# Regenerate the synthetic dataset (seeded, reproducible)
data:
	$(PY) scripts/generate_unit_economics_data.py

# Run the analysis
run:
	$(PY) scripts/volta_unit_economics.py

test:
	uv run pytest

lint:
	uv run ruff check .

type:
	uv run mypy

all: data test lint type
	@echo "All checks passed."
