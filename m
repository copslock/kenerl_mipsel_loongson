Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA46865 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 06:21:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA20009
	for linux-list;
	Sun, 19 Jul 1998 06:21:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA01144
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 06:21:14 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA26378
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 06:21:12 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id PAA26985
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 15:20:55 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id PAA00747;
	Sun, 19 Jul 1998 15:20:50 +0200
Message-ID: <19980719152050.B415@uni-koblenz.de>
Date: Sun, 19 Jul 1998 15:20:50 +0200
To: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>,
        linux@cthulhu.engr.sgi.com
Subject: Re: utmp.h
References: <19980719184144.26798@life.nthu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980719184144.26798@life.nthu.edu.tw>; from Francis M.J. Hsieh on Sun, Jul 19, 1998 at 06:41:44PM +0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 19, 1998 at 06:41:44PM +0800, Francis M.J. Hsieh wrote:

> Well, FYI, I found that the utmp.h is very different from that in x86
> linux or IRIX ...

It's that way because changing the structure to what the other architectures
are using would break the binary compatibility for not that much benefit.
I did so because glibc has already been the only libc for MIPS when other
architectures were still relying only on H.J. Lu's Linux Libc aka libc 5.

It's on the to do list for libc 7 and I think we've got still quite some
time before we take that step.

  Ralf
