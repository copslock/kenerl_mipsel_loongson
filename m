Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA122502 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 03:45:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id DAA1129020 for linux-list; Fri, 6 Mar 1998 03:44:42 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA1131505 for <linux@cthulhu.engr.sgi.com>; Fri, 6 Mar 1998 03:44:39 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id DAA10524
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Mar 1998 03:44:37 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id MAA17718 for <linux@cthulhu.engr.sgi.com>; Fri, 6 Mar 1998 12:44:28 +0100
Date: Fri, 6 Mar 1998 12:44:27 +0100 (MET)
From: Oliver Frommel <oliver@aec.at>
Reply-To: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: Re: xcompiler
In-Reply-To: <19980304082704.28878@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980306123820.17468A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hi,

after mirroring the CVS archive on ftp.linux.sgi.com i tried to crosscompile
the kernel (on an irix host, btw). Unfortunately the CVS version seems to be
a bit out of date/inconsistent. E.g. fs/nfs/nfsroot.c uses the obsolete
struct device ..
I finally managed to compile it with CONFIG_ROOT_NFS by replacing fs/super.c
by the one from the main kernel source and changing fs/nfs/nfsroot.c accordingly
(just replacing fs/nfs/nfsroot.c won't work) ..

Is anyone going to clean/merge this part of the kernel on sgi.com to be in sync
with the main kernel tree??

oliver
