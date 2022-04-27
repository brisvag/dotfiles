try:
    from rich import pretty, inspect as insp, print

    pretty.install()
except ImportError:
    print('rich is not installed.')
