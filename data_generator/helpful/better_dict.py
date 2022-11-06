
class dotdict(dict):
    """dot.notation access to dictionary attributes"""
    __getattr__ = dict.get
    __setattr__ = dict.__setitem__
    __delattr__ = dict.__delitem__


class listdict(dotdict):
    def __init__(self, keys, init_value=list):
        super().__init__()
        for key in keys:
            self[key] = init_value()
