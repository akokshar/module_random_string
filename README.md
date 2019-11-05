terraform fails if for_each is filtering out resources dependent on random_string. random_string cant yeild a result before it is applies - this causing plan to throw.

woks fine when for_each is applied to all resources set.