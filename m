Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PHqlnC003748
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 10:52:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PHqlMl003747
	for linux-mips-outgoing; Sat, 25 May 2002 10:52:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PHqcnC003736
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 10:52:38 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17BfjS-0004pl-00; Sat, 25 May 2002 12:53:34 -0500
Message-ID: <3CEFCF86.5060401@realitydiluted.com>
Date: Sat, 25 May 2002 12:53:10 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
MIME-Version: 1.0
To: Kunihiko IMAI <kimai@laser5.co.jp>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: fail to boot with MTD root fs
References: <m3off5drab.wl@kimai.laser5.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kunihiko IMAI wrote:
> Hi,
> 
> I'm using Pb1500 evaluation board and met somewhat serious problem.
> The problem is that failing to mount FlashROM filesystem as root fs
> and go into infinite loop without any message.  Does anyone have a
> good (or better) solution?
> 
> I'm using SGI kernel source tree, linux-2.4.18 of linux_2_4 branch.
> 
> When booting with nfs root, and using MTD FlashROM fs, it works well.
> 
There was a bug in 2.4.18 with respect to the MTD code and using flash
as a root filesystem. It had to do with the MTD block devices. Make
the changes below and things will work again.

-Steve

Index: mtdblock.c
===================================================================
RCS file: /data/cvs/settop/drivers/mtd/mtdblock.c,v
retrieving revision 1.6
diff -u -r1.6 mtdblock.c
--- mtdblock.c  9 May 2002 13:35:40 -0000       1.6
+++ mtdblock.c  25 May 2002 16:52:14 -0000
@@ -371,8 +371,6 @@
         if (inode == NULL)
                 release_return(-ENODEV);

-       invalidate_device(inode->i_rdev, 1);
-
         dev = MINOR(inode->i_rdev);
         mtdblk = mtdblks[dev];

Index: mtdblock_ro.c
===================================================================
RCS file: /data/cvs/settop/drivers/mtd/mtdblock_ro.c,v
retrieving revision 1.2
diff -u -r1.2 mtdblock_ro.c
--- mtdblock_ro.c       3 Jan 2002 17:19:58 -0000       1.2
+++ mtdblock_ro.c       25 May 2002 16:53:01 -0000
@@ -79,8 +79,6 @@
         if (inode == NULL)
                 release_return(-ENODEV);

-       invalidate_device(inode->i_rdev, 1);
-
         dev = MINOR(inode->i_rdev);
         mtd = __get_mtd_device(NULL, dev);
