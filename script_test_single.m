   %       c   l   e   a   r       a   l   l      
   %       c   l   o   s   e       a   l   l      
   g   l   v   s   ;      
   %   %       A   u   x   i   l   i   a   r   y       v   a   r   i   a   b   l   e   s       f   o   r       d   e   b   u   g   g   i   n   g      
   o   r   d   e   r       =       '   z   x   y   '   ;      
   %       s   t   i   l   l   _   t   i   m   e       =   2   0   0   ;       %       w   o   u   l   d       b   e       a   u   t   o   m   a   t   i   c       d   e   t   e   r   m   i   n   e   d       i   n       t   h   e       l   o   o   p      
   l   i   n   e   c   o   l   o   r       =       '   m   '   ;       %                       l   i   n   e   c   o   l   o   r       =       c   o   l   o   r   l   i   s   t   (   '   r   a   n   d   o   m   '   )   ;      
   a   t   t   f   i   g       =       1   4   0   0   ;       p   o   s   f   i   g       =       1   5   0   0   ;       m   a   g   f   i   g       =       1   3   0   0   ;      
   p   l   o   t   a   t   t       =       1   ;       p   l   o   t   p   o   s       =       1   ;       p   l   o   t   m   a   g       =       1   ;      
   c   a   l   i   b   r   a   t   e   m   a   g       =       0   ;      
   i   n   i   y   a   w   i   s       =       0   ;       %   '   m   a   g   '      
      
   w   h   e   r   e   i   m   u       =       '   f   o   o   t   '   ;      
      
   %   %       d   a   t   a       l   o   a   d   i   n   g      
   %       -   -   -   -   -   -   -   -       l   o   a   d       d   a   t   a       a   n   d       f   o   r   m   a   t       i   t       t   o       a       s   t   r   u   c   t   u   r   e       -   -   -   -   -   -   -   -      
   %       #   #   #       d   a   t   a       a   r   e       c   o   n   v   e   r   t   e   d       t   o       r   i   g   h   t   -   f   r   o   n   t   -   u   p       f   r   a   m   e   ,       i   n       m   /   s   ^   2       r   a   d   /   s       n   T      
   [   d   a   t   a   ,   p   a   t   h   N   a   m   e   ]       =       s   e   l   e   c   t   F   i   l   e   b   y   D   l   g   (   g   l   v   )   ;      
   d   i   s   p   (   p   a   t   h   N   a   m   e   )   ;      
   i   f       c   o   n   t   a   i   n   s   (   p   a   t   h   N   a   m   e   ,   '   V   N   1   0   0   '   )   ,   s   e   n   s   o   r   _   t   y   p   e       =       '   V   N   1   0   0   '   ;      
   e   l   s   e   i   f       c   o   n   t   a   i   n   s   (   p   a   t   h   N   a   m   e   ,   '   X   s   e   n   s   '   )   ,   s   e   n   s   o   r   _   t   y   p   e       =       '   X   s   e   n   s   '   ;      
   e   n   d      
   i   m   u   0       =       d   a   t   a   F   o   r   m   a   t   (   d   a   t   a   ,   s   e   n   s   o   r   _   t   y   p   e   ,   w   h   e   r   e   i   m   u   )   ;      
      
   %       -   -   -   -   -   -   -   -       D   e   t   e   r   m   i   n   i   n   g       t   h   e       d   u   r   a   t   i   o   n       o   f       r   e   s   t       b   e   f   o   r   e       m   o   v   e   m   e   n   t       -   -   -   -   -   -   -   -      
   %       #   #   #       w   a   l   k   i   n   g       d   a   t   a       s   e   l   e   c   t       t   h   i   s      
   %       [   g   a   i   t   _   t   i   m   e   ,   ~   ,   ~   ,   ~   ,   ~   ]       =       g   a   i   t   D   i   v   i   d   e   (   i   m   u   0   ,   g   l   v   .   g   0   ,   '   n   o   f   i   g   '   )   ;      
      
   %       #   #   #       m   a   g   n   e   t   i   c       f   i   e   l   d       d   a   t   a       s   e   l   e   c   t       s   t   a   t   i   c   D   e   t   e   c   t   o   r      
       [   g   a   i   t   _   t   i   m   e   ,   ~   ,   ~   ,   ~   ]       =       s   t   a   t   i   c   D   e   t   e   c   t   o   r   (   i   m   u   ,   '   f   i   g   '   )   ;      
      
   s   t   i   l   l   _   t   i   m   e       =       g   a   i   t   _   t   i   m   e   (   1   ,   1   )   -   1   /   i   m   u   0   .   t   s   ;          
   i   f       s   t   i   l   l   _   t   i   m   e   <   =   0      
                   s   t   i   l   l   _   t   i   m   e       =       1   0   ;      
   e   n   d      
      
   %   %       c   a   l   i   b   r   a   t   i   o   n      
                   %       -   -   -   -   -   -   -       m   a   g   n   e   t   o   m   e   t   e   r       -   -   -   -   -   -   -   -   -   -      
   i   f       s   t   r   c   m   p   (   s   e   n   s   o   r   _   t   y   p   e   ,   '   V   N   1   0   0   '   )      
                   %       V   N   1   0   0   ,       o   u   t   d   o   o   r   ,       i   n       u   T      
                   s   c   a   l   e   _   m   a   g       =       [   1   .   0   0   0   1   5   6   2   3   4   4   3   7   6   3   ,   -   0   .   0   0   0   6   1   4   5   9   4   0   8   8   2   5   6   6   7   6   ,   0   .   0   0   0   3   3   3   1   9   8   8   1   7   7   2   2   4   2   4   ;   -   0   .   0   0   0   6   1   4   5   9   4   0   8   8   2   5   6   6   7   6   ,   0   .   9   9   9   4   5   3   1   3   7   7   8   1   5   6   2   ,   6   .   0   8   7   3   0   6   6   9   9   4   9   4   0   3   e   -   0   5   ;   0   .   0   0   0   3   3   3   1   9   8   8   1   7   7   2   2   4   2   4   ,   6   .   0   8   7   3   0   6   6   9   9   4   9   4   0   3   e   -   0   5   ,   1   .   0   0   0   3   9   1   3   5   8   6   9   4   0   3   ]   ;      
                   b   i   a   s   0   _   m   a   g       =       [   1   4   .   0   6   7   6   8   5   2   3   4   9   5   7   7   ,   1   7   .   2   3   6   3   9   1   0   0   1   9   5   4   8   ,   6   7   .   2   2   8   0   9   8   6   4   3   0   7   6   6   ]   ;      
   %                       %       V   N   1   0   0   ,       i   n   d   o   o   r   ,       i   n       u   T      
   %                       s   c   a   l   e   _   m   a   g       =       [   0   .   9   9   9   6   1   9   1   6   6   0   5   0   6   7   3   ,   -   0   .   0   0   3   9   1   4   7   0   3   0   0   4   9   3   8   2   6   ,   -   0   .   0   0   0   5   7   5   7   8   1   9   4   9   6   9   8   6   6   3   ;   -   0   .   0   0   3   9   1   4   7   0   3   0   0   4   9   3   8   2   6   ,   0   .   9   9   9   4   8   7   6   4   0   9   9   0   8   4   4   ,   -   0   .   0   0   0   5   0   3   4   9   3   8   6   4   5   3   8   7   3   3   ;   -   0   .   0   0   0   5   7   5   7   8   1   9   4   9   6   9   8   6   6   3   ,   -   0   .   0   0   0   5   0   3   4   9   3   8   6   4   5   3   8   7   3   3   ,   1   .   0   0   0   9   0   9   7   3   6   1   0   2   6   6   ]   ;      
   %                       b   i   a   s   0   _   m   a   g       =       [   1   4   .   9   6   5   1   8   0   2   6   2   4   1   7   8   ,   1   6   .   9   3   6   5   7   3   1   6   3   6   4   4   0   ,   6   6   .   4   6   1   4   2   0   7   5   9   7   3   6   4   ]   ;      
   e   l   s   e   i   f       s   t   r   c   m   p   (   s   e   n   s   o   r   _   t   y   p   e   ,   '   X   s   e   n   s   '   )      
                   %       #   #   #       X   i   a   o   f   e   n   g       o   u   t       d   a   t   a       s   e   t       d   o       n   o   t       n   e   e   d       t   h   i   s       c   a   l   i   b   r   a   t   i   o   n   ,          
                   %       #   #   #       H   a   r   i   s   h       o   u   t   /   r   e   c   /   8   s   h   a   p   e       a   n   d       X   i   a   o   f   e   n   g       r   e   c   /   8   s   h   a   p   e       n   e   e   d      
                   s   c   a   l   e   _   m   a   g       =       e   y   e   (   3   )   ;      
                   b   i   a   s   0   _   m   a   g       =       1   .   0   e   +   0   4   *   [   1   .   0   5   2   6       1   .   3   9   6   2       0   .   8   7   5   3   ]   ;      
      
                   %       F   O   R       X   I   A   O   F   E   N   G       S   P   O   R   T   S   P   A   R   K      
                   s   c   a   l   e   _   m   a   g       =       e   y   e   (   3   )   ;      
   %                       b   i   a   s   0   _   m   a   g       =       1   .   0   e   +   0   4       *   [   -   3   .   8   5   6   2               -   4   .   6   9   6   4               -   4   .   7   1   5   9   ]   ;       %   B      
                   b   i   a   s   0   _   m   a   g       =       [   1   9   .   2   7   5   7       -   1   6   6   .   0   5   2   0           1   0   6   .   4   6   5   1   ]   ;   %   A      
      
                   %       F   O   R       H   A   R   I   S   H       S   P   O   R   T   S   P   A   R   K      
                   s   c   a   l   e   _   m   a   g       =       e   y   e   (   3   )   ;      
                   i   f       c   o   n   t   a   i   n   s   (   p   a   t   h   N   a   m   e   ,   '   A   '   )      
                   b   i   a   s   0   _   m   a   g       =       1   .   0   e   +   0   4       *       [   0   .   3   6   7   7                   2   .   0   2   1   3                   0   .   7   7   0   6   ]   ;       %   A      
                   e   l   s   e   i   f       c   o   n   t   a   i   n   s   (   p   a   t   h   N   a   m   e   ,   '   B   '   )      
                   b   i   a   s   0   _   m   a   g       =       1   .   0   e   +   0   3       *       [   -   1   .   6   7   6   2               -   3   .   8   1   2   4               -   5   .   3   5   0   1   ]   ;       %   B      
                   e   l   s   e   ,       e   r   r   o   r   (   '   m   a   g       c   a   l   i   b   r   a   t   i   o   n       w   r   o   n   g   '   )   ;      
                   e   n   d      
      
   e   l   s   e      
   e   n   d      
   i   f       c   a   l   i   b   r   a   t   e   m   a   g      
                   i   m   u   0   .   m   a   g       =       (   i   m   u   0   .   m   a   g   -   b   i   a   s   0   _   m   a   g   )   *   s   c   a   l   e   _   m   a   g   ;          
   e   n   d      
                   %       -   -   -   -   -   -   -       a   c   c   e   l   e   r   o   m   e   t   e   r       -   -   -   -   -   -   -   -   -   -      
                   %       c   a   l   c   u   l   a   t   e       b   i   a   s       a   n   d       s   c   a   l   e       m   a   t   r   i   x       o   f       a   c   c   e   l   e   r   o   m   e   t   e   r       u   s   i   n   g       S   i   x       P   o   i   n   t       M   e   t   h   o   d      
                   %       s   e   e       s   c   r   i   p   t   _   I   M   U   c   a   l   i   b   P   a   r   a   C   a   l   c   .   m      
   i   f       s   t   r   c   m   p   (   s   e   n   s   o   r   _   t   y   p   e   ,   '   V   N   1   0   0   '   )      
                   s   c   a   l   e   _   a   c   c       =       [   1   .   0   0   0   7                   0   .   0   1   8   6               -   0   .   0   0   3   1   ;      
                               -   0   .   0   0   5   8                   1   .   0   0   0   9               -   0   .   0   0   0   5   ;                      
                                   0   .   0   1   7   9               -   0   .   0   0   1   5                   1   .   0   0   1   0   ]   ;                      
                   b   i   a   s   0   _   a   c   c       =       [   -   0   .   0   4   9   8   ;   0   .   0   1   2   9   ;   0   .   4   8   9   1   ]   ;      
   e   l   s   e   i   f       s   t   r   c   m   p   (   s   e   n   s   o   r   _   t   y   p   e   ,   '   X   s   e   n   s   '   )      
                   i   f       c   o   n   t   a   i   n   s   (   p   a   t   h   N   a   m   e   ,   '   A   '   )      
                   s   c   a   l   e   _   a   c   c       =       [   1   .   0   0   1   0   5   9   5   7   0   9   4   3   2   2   	   0   .   0   1   8   2   1   8   8   4   4   1   3   7   8   8   9   2   	   -   0   .   0   0   1   2   1   7   7   3   5   3   9   1   5   8   3   6   8   ;      
                                                                   -   0   .   0   1   6   6   0   8   3   5   1   2   5   9   0   0   5   0   	   0   .   9   9   9   5   3   7   3   2   0   1   9   4   1   5   3   	   -   0   .   0   2   1   7   8   6   0   5   3   3   7   3   0   2   1   4   ;      
                                                                   0   .   0   0   2   4   5   2   0   0   5   9   4   1   3   1   3   6   4   	   0   .   0   0   2   2   3   7   2   2   8   6   7   2   3   0   4   9   5   	   1   .   0   0   0   5   8   8   0   6   3   5   9   8   5   6   ]   ;      
                   b   i   a   s   0   _   a   c   c       =       [   0   .   1   1   6   9   5   4   6   0   9   8   1   5   1   5   8   ;   0   .   0   2   6   3   8   9   9   1   5   4   9   8   1   0   4   9   ;   -   0   .   0   2   8   3   8   3   4   0   9   6   9   7   6   5   8   7   ]   ;      
                   e   l   s   e   i   f       c   o   n   t   a   i   n   s   (   p   a   t   h   N   a   m   e   ,   '   B   '   )      
                   s   c   a   l   e   _   a   c   c       =       [   0   .   9   9   9   9   7   8   1   6   1   9   4   5   6   5   2   	   0   .   0   0   2   9   9   4   1   5   3   5   8   9   3   8   6   6   3   	   -   0   .   0   0   4   4   4   6   3   6   8   5   2   7   2   8   3   5   9   ;      
                                   -   0   .   0   0   7   4   3   3   7   6   2   4   6   9   2   7   7   6   1   	   0   .   9   9   8   5   9   8   7   2   0   9   6   3   2   6   4   	   -   0   .   0   0   8   1   1   7   5   0   8   1   8   6   4   3   7   5   7   ;      
                                   -   0   .   0   0   0   6   9   8   0   2   1   2   4   8   7   9   7   7   4   0   	   -   0   .   0   0   1   9   1   8   6   8   7   2   7   0   7   2   9   6   0   	   1   .   0   0   1   0   9   0   4   5   6   1   7   9   6   7   ]   ;   	      
   	   b   i   a   s   0   _   a   c   c       =       [   0   .   0   8   6   6   8   3   6   9   0   4   0   3   5   0   7   8   ;   -   0   .   0   7   5   2   7   3   4   4   2   3   8   3   6   1   6   1   ;   -   0   .   1   6   8   3   7   0   8   3   1   5   7   8   2   2   3   ]   ;      
                   e   l   s   e   ,       e   r   r   o   r   (   '   a   c   c       c   a   l   i   b   r   a   t   i   o   n       w   r   o   n   g   '   )   ;      
                   e   n   d      
   e   l   s   e   ,   e   r   r   o   r   (   '   c   h   o   o   s   e       s   e   n   s   o   r   '   )   ;      
   e   n   d      
                   i   m   u   0   .   a   c   c       =       (   i   n   v   (   s   c   a   l   e   _   a   c   c   )   *   (   i   m   u   0   .   a   c   c   '   -   b   i   a   s   0   _   a   c   c   )   )   '   ;          
      
                   %       -   -   -   -   -   -   -       g   y   r   o   s   c   o   p   e       -   -   -   -   -   -   -   -   -   -      
                   %       C   a   l   c   u   l   a   t   e       g   y   r   o       b   i   a   s       u   s   i   n   g       t   h   e       s   t   a   t   i   c       i   n   t   e   r   v   a   l       b   e   f   o   r   e       w   a   l   k   i   n   g      
                   b   i   a   s   0   _   g   y   r   o       =       m   e   a   n   (   i   m   u   0   .   g   y   r   o   s   (   1   :   s   t   i   l   l   _   t   i   m   e   ,   :   )   )   ;      
                   i   m   u   0   .   g   y   r   o   s       =       i   m   u   0   .   g   y   r   o   s       -       b   i   a   s   0   _   g   y   r   o   ;      
   %   %       i   n   i   t   i   a   l       a   l   i   g   n   m   e   n   t      
                   i   m   u   1       =       i   m   u   0   ;      
      
                   %       #   #   #       c   a   l   c   u   l   a   t   e       i   n   i   t   i   a   l       a   t   t   i   t   u   d   e       a   n   g   l   e   s       a   n   d       q   u   a   t   e   r   n   i   o   n       u   s   i   n   g       a   c   c   (   &       m   a   g   )      
   i   f       s   t   r   c   m   p   (   i   n   i   y   a   w   i   s   ,   '   m   a   g   '   )      
                   [   q   0   ,   a   t   t   0   ]       =       a   l   i   g   n   b   y   A   c   c   M   a   g   a   t   S   t   a   t   i   c   (   i   m   u   1   .   a   c   c   (   1   :   s   t   i   l   l   _   t   i   m   e   ,   :   )   ,   i   m   u   1   .   m   a   g   (   1   :   s   t   i   l   l   _   t   i   m   e   ,   :   )   ,   o   r   d   e   r   )   ;      
   e   l   s   e      
                   [   q   0   ,   a   t   t   0   ]       =       a   l   i   g   n   b   y   A   c   c   M   a   g   a   t   S   t   a   t   i   c   (   i   m   u   1   .   a   c   c   (   1   :   s   t   i   l   l   _   t   i   m   e   ,   :   )   ,   [   ]   ,   o   r   d   e   r   )   ;      
   e   n   d      
                   d   i   s   p   (   [   '   -   -   -   -   -           i   n   i   t   i   a   l       a   t   t   i   t   u   d   e  �   d   e   g   /   s  �	  �   '   ,   n   u   m   2   s   t   r   (   (   a   t   t   0   *   g   l   v   .   d   e   g   )   '   )   ,   '           -   -   -   -   -   '   ]   )   ;      
      
                   %       #   #   #       r   e   m   o   v   e       t   h   e       s   t   a   t   i   c       s   e   c   t   i   o   n       a   t       t   h   e       b   e   g   i   n   n   i   n   g      
                   i   m   u   1   .   a   c   c       =       i   m   u   1   .   a   c   c   (   s   t   i   l   l   _   t   i   m   e   +   1   :   e   n   d   ,   :   )   ;      
                   i   m   u   1   .   g   y   r   o   s       =       i   m   u   1   .   g   y   r   o   s   (   s   t   i   l   l   _   t   i   m   e   +   1   :   e   n   d   ,   :   )   ;      
                   i   m   u   1   .   m   a   g       =       i   m   u   1   .   m   a   g   (   s   t   i   l   l   _   t   i   m   e   +   1   :   e   n   d   ,   :   )   ;      
                   i   f       i   s   f   i   e   l   d   (   i   m   u   1   ,   '   q   u   a   '   )      
                                   i   m   u   1   .   q   u   a       =       i   m   u   1   .   q   u   a   (   s   t   i   l   l   _   t   i   m   e   +   1   :   e   n   d   ,   :   )   ;      
                   e   n   d      
      
   %                       q   0       =       a   t   t   2   q   u   a   (   [   a   t   t   0   (   1   :   2   )   ;   -   1   7   8   .   5   3   *   g   l   v   .   r   a   d   ]   ,   o   r   d   e   r   )   ;       %   -   1   7   7   .   4   0   4   1       -   1   7   8   .   5   3      
   %       q   0       =       a   t   t   2   q   u   a   (   [   a   t   t   0   (   1   :   2   )   ;   9   0   *   g   l   v   .   r   a   d   ]   ,   o   r   d   e   r   )   ;          
   %   %       a   t   t   i   t   u   d   e       e   s   t   i   m   a   t   i   n   g      
                   %       -   -   -   -   -   -   -       i   n   i   t   i   a   l       s   e   t   t   i   n   g       -   -   -   -   -   -   -   -   -   -      
                   i   m   u       =       i   m   u   1   ;      
                   q   u   a   0       =       q   0   ;      
      
                   X   _   t   y   p   e       =       '   q   '   ;       %           b   A      
                   o   b   s   _   t   y   p   e       =       '   g   n   '   ;       o   b   s       =       i   m   u   .   a   c   c   ;       p   a   r   a       =       [   0   ;   0   ;   g   l   v   .   g   0   ]   ;      
                   [   m   ,   P   ,   Q   ,   R   ]       =       f   i   l   t   e   r   I   n   i   t   i   a   l   (   X   _   t   y   p   e   ,   o   b   s   _   t   y   p   e   ,   q   u   a   0   )   ;       %       c   h   a   n   g   e       R       i   n       t   h   i   s       f   u   n   c   t   i   o   n       a   n   d       c   h   a   n   g   e       Q       i   n       E   K   F   q       i   f       n   e   e   d   e   d      
      
                   %       -   -   -   -   -   -   -       z   e   r   o       v   e   l   o   c   i   y       d   e   t   e   c   t   i   o   n       -   -   -   -   -   -   -   -   -   -      
                   %       #   #   #       w   a   l   k   i   n   g       d   a   t   a       s   e   l   e   c   t       t   h   i   s      
   %                       [   g   a   i   t   _   t   i   m   e   ,   ~   ,   ~   ,   z   v   d   ,   ~   ]       =       g   a   i   t   D   i   v   i   d   e   (   i   m   u   ,   g   l   v   .   g   0   ,   '   n   o   f   i   g   '   )   ;      
      
   %               M   F       m   a   p   p   i   n   g       d   a   t   a       s   e   l   e   c   t       t   h   i   s      
                   [   g   a   i   t   _   t   i   m   e   ,   ~   ,   ~   ,   ~   ]       =       s   t   a   t   i   c   D   e   t   e   c   t   o   r   (   i   m   u   ,   '   f   i   g   '   )   ;      
      
                   %       -   -   -   -   -   -   -       f   i   l   t   e   r   i   n   g       /       n   u   m   e   r   i   c   a   l       i   n   t   e   g   r   a   t   i   n   g       f   o   r       q   u   a   t   e   r   n   i   o   n       -   -   -   -   -   -   -   -   -   -      
                   %       #   #   #       c   h   o   s   e       E   K   F       o   r       n   u   m   e   r   i   c   a   l       i   n   t   e   g   r   a   t   i   o   n      
   %                       E   K   F   q      
                   n   u   m   I   n   t   e   g   r   a   Q   u   a      
   %                       M   a   d   g   w   i   c   k   Q   u   a      
   %                       M   a   h   o   n   y   Q   u   a      
      
   i   f       p   l   o   t   a   t   t      
                   f   i   g   u   r   e   (   a   t   t   f   i   g   )   ;   h   o   l   d       o   n   ;   t   i   t   l   e   (   '   y   a   w   '   )      
                   p   l   o   t   (   a   t   t   (   :   ,   3   )   *   g   l   v   .   d   e   g   ,   '   C   o   l   o   r   '   ,   '   g   '   )      
   %                       f   i   g   u   r   e   (   a   t   t   f   i   g   +   1   )   ;   h   o   l   d       o   n   ;   t   i   t   l   e   (   '   p   i   t   c   h   '   )      
   %                       p   l   o   t   (   a   t   t   (   :   ,   1   )   *   g   l   v   .   d   e   g   ,   l   i   n   e   c   o   l   o   r   ,   '   C   o   l   o   r   '   ,   '   r   '   )      
   %                       f   i   g   u   r   e   (   a   t   t   f   i   g   +   2   )   ;   h   o   l   d       o   n   ;   t   i   t   l   e   (   '   r   o   l   l   '   )      
   %                       p   l   o   t   (   a   t   t   (   :   ,   2   )   *   g   l   v   .   d   e   g   ,   l   i   n   e   c   o   l   o   r   ,   '   C   o   l   o   r   '   ,   '   b   '   )      
      
   %                       f   i   g   u   r   e   (   a   t   t   f   i   g   +   3   )   ;   h   o   l   d       o   n      
   %                       p   l   o   t   (   q   )      
   e   n   d      
      
   %   %       p   o   s   i   t   i   o   n       e   s   t   i   m   a   t   i   n   g      
   i   f       p   l   o   t   p   o   s      
                   %       -   -   -   -   -   -   -       c   o   n   v   e   r   t       s   p   e   c   i   f   i   c       f   o   r   c   e       t   o       a   c   c   ^   n       -   -   -   -   -   -   -   -   -   -      
                   N       =       l   e   n   g   t   h   (   q   )   ;      
                   a   c   c   n       =       z   e   r   o   s   (   N   ,   3   )   ;      
                   f   o   r       i       =       1   :   N      
                                   i   f       s   t   r   c   m   p   (   X   _   t   y   p   e   ,   '   q       b   G       b   A   '   )      
                                                   %       n   o   t       f   i   n   i   s   h   e   d      
                                   e   l   s   e      
                                                   a   c   c   n   (   i   ,   :   )       =       (   q   u   a   2   d   c   m   (   q   (   i   ,   :   )   ,   '   C   n   b   '   )   *   i   m   u   .   a   c   c   (   i   ,   :   )   '       -       [   0   ;   0   ;   g   l   v   .   g   0   ]   )   '   ;      
   %                                                       a   c   c   n   (   i   ,   :   )       =       (   a   t   t   2   d   c   m   (   a   t   t   (   i   ,   :   )   ,   o   r   d   e   r   )   *   i   m   u   .   a   c   c   (   i   ,   :   )   '       -       [   0   ;   0   ;   g   l   v   .   g   0   ]   )   '   ;      
                                   e   n   d      
                   e   n   d      
      
                   %       -   -   -   -   -   -   -       c   a   l   c   u   l   a   t   i   n   g       p   o   s   i   t   i   o   n       u   s   i   n   g       a   c   c   ^   n       -   -   -   -   -   -   -   -   -   -      
                   [   p   o   s   ,   ~   ]   =   p   o   s   C   a   l   c   u   l   a   t   e   W   i   t   h   G   a   i   t   (   a   c   c   n   '   ,   g   a   i   t   _   t   i   m   e   ,   i   m   u   .   t   s   ,   0   .   5   ,   '   f   i   g   '   )   ;      
   %                       [   p   o   s   ,   V   ]   =   p   o   s   C   a   l   c   u   l   a   t   e   (   i   m   u   ,   q   )   ;      
      
                   f   i   g   u   r   e   (   p   o   s   f   i   g   )   ;   h   o   l   d       o   n   ;   t   i   t   l   e   (   '   t   r   a   j   e   c   t   o   r   y   '   )      
                   p   l   o   t   (   p   o   s   (   :   ,   1   )   ,   p   o   s   (   :   ,   2   )   ,   '   C   o   l   o   r   '   ,   l   i   n   e   c   o   l   o   r   )      
   e   n   d      
      
   f   i   g   u   r   e   (   p   o   s   f   i   g   )   ;   h   o   l   d       o   n   ;   x   l   a   b   e   l   (   '   X       (   m   )   '   )   ;   y   l   a   b   e   l   (   '   Y       (   m   )   '   )   ;   b   o   x       o   n      
   a   x   i   s       e   q   u   a   l      
      
   %       f   i   g   u   r   e      
   %       p   l   o   t   3   (   p   o   s   (   :   ,   1   )   ,   p   o   s   (   :   ,   2   )   ,   p   o   s   (   :   ,   3   )   )      
   %   %       p   l   o   t       m   a   g   n   e   t   i   c       f   i   e   l   d      
   i   f       p   l   o   t   m   a   g      
   %                       m   a   g   n       =       z   e   r   o   s   (   N   ,   3   )   ;      
   %                                       f   o   r       i       =       1   :   N      
   %                                                       m   a   g   n   (   i   ,   :   )       =       (   q   u   a   2   d   c   m   (   q   (   i   ,   :   )   ,   '   C   n   b   '   )   *   i   m   u   .   m   a   g   (   i   ,   :   )   '   )   '   ;      
   %                                       e   n   d                      
   %                       f   i   g   u   r   e   ;   h   o   l   d       o   n   ;      
   %                       p   l   o   t   (   m   a   g   n   )   ;      
   %                       p   l   o   t   (   v   e   c   n   o   r   m   (   m   a   g   n   ,   2   ,   2   )   )   ;      
   %                       l   e   g   e   n   d   (   {   '   m   a   g   _   x   ^   n   '   ,   '   m   a   g   _   y   ^   n   '   ,   '   m   a   g   _   z   ^   n   '   ,   '   m   a   g   _   {   n   o   r   m   }   '   }   )   ;      
   %                       x   l   a   b   e   l   (   '   T   i   m   e   '   )      
   %                       y   l   a   b   e   l   (   '   M   a   g   n   e   t   i   c       f   i   e   l   d       s   t   r   e   n   g   t   h       (   n   T   )   '   )      
      
                   f   i   g   u   r   e   (   m   a   g   f   i   g   )   ;   h   o   l   d       o   n   ;   t   i   t   l   e   (   '   m   a   g       n   o   r   m   '   )      
   %                       p   l   o   t   (   i   m   u   .   m   a   g   )   ;      
                   p   l   o   t   (   v   e   c   n   o   r   m   (   i   m   u   .   m   a   g   ,   2   ,   2   )   /   4   9   /   1   0   0   0   ,   '   C   o   l   o   r   '   ,   l   i   n   e   c   o   l   o   r   )   ;      
      
   %                       l   e   g   e   n   d   (   {   '   m   a   g   _   x   ^   b   '   ,   '   m   a   g   _   y   ^   b   '   ,   '   m   a   g   _   z   ^   b   '   ,   '   m   a   g   _   {   n   o   r   m   }   '   }   )   ;      
   %                       x   l   a   b   e   l   (   '   T   i   m   e   '   )      
   %                       y   l   a   b   e   l   (   '   M   a   g   n   e   t   i   c       f   i   e   l   d       s   t   r   e   n   g   t   h       (   n   T   )   '   )      
      
                   f   i   g   u   r   e   (   m   a   g   f   i   g   +   1   )   ;   h   o   l   d       o   n   ;   t   i   t   l   e   (   '   M   F   '   )      
                   s   c   a   t   t   e   r   (   p   o   s   (   :   ,   1   )   ,   p   o   s   (   :   ,   2   )   ,   1   0   ,   v   e   c   n   o   r   m   (   i   m   u   .   m   a   g   ,   2   ,   2   )   /   4   9   /   1   0   0   0   ,   '   f   i   l   l   e   d   '   )      
                   a   x   i   s       e   q   u   a   l      
                   c   o   l   o   r   b   a   r   ;      
   %                       h       =       c   o   l   o   r   b   a   r   ;      
   %                       s   e   t   (   g   e   t   (   h   ,   '   l   a   b   e   l   '   )   ,   '   s   t   r   i   n   g   '   ,   '   m   a   g   n   e   t   i   c       f   i   e   l   d       s   t   r   e   n   g   t   h       (   n   T   )   '   )   ;      
   %                       a   x   i   s       e   q   u   a   l      
   %          
   %                       f   i   g   u   r   e      
   %                       s   c   a   t   t   e   r   3   (   p   o   s   (   :   ,   1   )   ,   p   o   s   (   :   ,   2   )   ,   p   o   s   (   :   ,   3   )   ,   1   0   ,   v   e   c   n   o   r   m   (   i   m   u   .   m   a   g   ,   2   ,   2   )   ,   '   f   i   l   l   e   d   '   )      
   %                       h       =       c   o   l   o   r   b   a   r   ;      
   %                       s   e   t   (   g   e   t   (   h   ,   '   l   a   b   e   l   '   )   ,   '   s   t   r   i   n   g   '   ,   '   m   a   g   n   e   t   i   c       f   i   e   l   d       s   t   r   e   n   g   t   h       (   n   T   )   '   )   ;      
   %                       a   x   i   s       e   q   u   a   l      
   e   n   d      
      
      
      
      
