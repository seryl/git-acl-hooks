Git ACL Hooks
=============

Sets access control restrictions for updates.

Example acl
===========
    # Everything is read-only by default
    # This sets up read-write access to a specific file
    match = ^blehk.txt
    access = read-write
    users = jtoft

    # This sets up read-write access to a folder
    match = ^lib
    access = read-write
    users = jtoft

