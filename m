Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA1170383 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Mar 1998 22:23:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id WAA4118993 for linux-list; Thu, 12 Mar 1998 22:23:01 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA4128234 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Mar 1998 22:22:59 -0800 (PST)
Received: from sparc.life.nthu.edu.tw (life.nthu.edu.tw [140.114.98.21]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id WAA01514
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Mar 1998 22:19:21 -0800 (PST)
	mail_from (tonywu@life.nthu.edu.tw)
Received: from localhost (tonywu@localhost)
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) with SMTP id NAA26313;
	Fri, 13 Mar 1998 13:22:02 +0800 (CST)
Date: Fri, 13 Mar 1998 13:22:01 +0800 (CST)
From: "Tony C. Wu" <tonywu@life.nthu.edu.tw>
X-Sender: tonywu@sparc
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Getting Started ..... NOT
In-Reply-To: <m0yDFLA-000V5iC@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.980313130741.26170A-100000@sparc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Ok. done that. I can successfully remount the / rw, but still, wont go any
further. I tested fsck manually, no matter what device I specified, it
always printed the same error and exited immediately. If I comment fsck
part, and boot directly, still wont go. So I think the root-be-0.03-cpio
is somehow broken. Can anyone provide another working mini-set of root ?

Thanks,

--
Tony C. Wu 
System administrator            Email: tonywu@life.nthu.edu.tw
Dept. of Life Sciences          Voice: +886-3-574-2772
NTHU, Hsin-Chu, Taiwan            Fax: +886-3-571-5934

On Thu, 12 Mar 1998, Alan Cox wrote:

> > 2.1.72_NOSL: put me in repair fs mode, but i can't change anything.
> >              It said it couldn't read superblock on /dev/sdb
> 
> Ok. The disk image expects to be /dev/sdb
> do
> 
> 
> mount -n -o remount,rw /dev/sdb1  /
> 
> vi /etc/fstab
> 
> change /dev/sdb to /dev/sdb1
> 
> exit
> 
> 
> Best of luck
> 
