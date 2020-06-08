FROM governmentpaas/awscli:848d890e2aa7ffb049801c23dc85f981b49e491a
COPY assume-role /

CMD ["/assume-role"]
