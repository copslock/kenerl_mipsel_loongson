Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA124314 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Mar 1998 08:50:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id IAA1215842 for linux-list; Fri, 6 Mar 1998 08:50:32 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA1150420 for <linux@cthulhu.engr.sgi.com>; Fri, 6 Mar 1998 08:50:31 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA06849
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Mar 1998 08:50:29 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id RAA07679
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Mar 1998 17:50:27 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id PAA24406;
	Fri, 6 Mar 1998 15:24:42 +0100
Message-ID: <19980306152442.52448@uni-koblenz.de>
Date: Fri, 6 Mar 1998 15:24:42 +0100
To: Oliver Frommel <oliver@aec.at>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: xcompiler
References: <19980304082704.28878@uni-koblenz.de> <Pine.LNX.3.96.980306123820.17468A-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980306123820.17468A-100000@web.aec.at>; from Oliver Frommel on Fri, Mar 06, 1998 at 12:44:27PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Mar 06, 1998 at 12:44:27PM +0100, Oliver Frommel wrote:

> after mirroring the CVS archive on ftp.linux.sgi.com i tried to crosscompile
> the kernel (on an irix host, btw). Unfortunately the CVS version seems to be
> a bit out of date/inconsistent. E.g. fs/nfs/nfsroot.c uses the obsolete
> struct device ..
> I finally managed to compile it with CONFIG_ROOT_NFS by replacing fs/super.c
> by the one from the main kernel source and changing fs/nfs/nfsroot.c accordingly
> (just replacing fs/nfs/nfsroot.c won't work) ..
> 
> Is anyone going to clean/merge this part of the kernel on sgi.com to be in sync
> with the main kernel tree??

The state of the nfsroot stuff is whatever is was when 2.1.73 on which the
current CVS kernel is based, was current.  I didn't take a closer look if
later kernel versions have already fixed that problem, but I hope so.

  Ralf
