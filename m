Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA07579 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Jan 1998 20:10:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA06205 for linux-list; Fri, 9 Jan 1998 20:05:46 -0800
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [192.26.72.25]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA06200 for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 20:05:44 -0800
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id UAA02549 for <linux@cthulhu>; Fri, 9 Jan 1998 20:05:07 -0800 (PST)
Date: Fri, 9 Jan 1998 20:04:57 -0800 (PST)
From: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
To: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: something not really right ..
Message-ID: <Pine.SGI.3.94.980109200218.2493B-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I tried to compile the latest sources for an Indigo R4k .. with minimal
functionality .. i.e. most of the newer stuff has been left out.

after the compilation, trying to bring the machine up by serving the
kernel via NFS/BOOTP gets me this message 

sash
"unable to execute bootp()tantrik:/usr/local/boot/vmlinux: Not enough
space"
"unable to load bootp()tantrik:/usr/local/boot/vmlinux: Not enough space"
sash

any ideas, anyone ??

--
--------------------------------------------------------------------------
Shrijeet Mukherjee,    			Member of Technical Staff (MTS)
					Advanced Graphics Division 
                     			Silicon Graphics Computer Systems

http://reality.sgi.com/shm_engr     	phone: 650-933-5312
email: shm@engr.sgi.com, shm@sgi.com, shm@cs.uoregon.edu
--------------------------------------------------------------------------
Life is a comedy to those that think, a tragedy to those that feel.
