Received:  by oss.sgi.com id <S553679AbQJVWyx>;
	Sun, 22 Oct 2000 15:54:53 -0700
Received: from skynet.csn.ul.ie ([136.201.105.2]:30481 "EHLO skynet.csn.ul.ie")
	by oss.sgi.com with ESMTP id <S553660AbQJVWyg>;
	Sun, 22 Oct 2000 15:54:36 -0700
Received: from localhost (airlied@localhost)
	by skynet.csn.ul.ie (8.9.3/8.9.3) with ESMTP id XAA26444;
	Sun, 22 Oct 2000 23:53:06 +0100
Date:   Sun, 22 Oct 2000 23:53:06 +0100 (IST)
From:   Dave Airlie <airlied@csn.ul.ie>
To:     Linux/MIPS list <linux-mips@oss.sgi.com>,
        "Linux MIPS fnet.fr" <linux-mips@fnet.fr>
Subject: quicky patch for dz.c
Message-ID: <Pine.LNX.4.10.10010222351240.13056-100000@skynet.csn.ul.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,

Just read Karel's site about dz.c not working ...

not sure if this helps (haven't had time to test it ... VAX is plugged
in.. need to get time to setup the DS5000 again..)

info->magic is never used, anyways.

Dave.

Index: dz.c
===================================================================
RCS file: /cvs/linux/drivers/char/dz.c,v
retrieving revision 1.11
diff -u -r1.11 dz.c
--- dz.c	2000/10/03 11:49:16	1.11
+++ dz.c	2000/10/22 22:51:57
@@ -1350,7 +1350,6 @@
     {
       info = &multi[i]; 
       lines[i] = info;
-    info->magic = SERIAL_MAGIC;
 
       if ((mips_machtype == MACH_DS23100) || (mips_machtype ==
MACH_DS5100)) 
       info->port = (unsigned long) KN01_DZ11_BASE;



-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
