Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA67483 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 14:22:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA05410
	for linux-list;
	Sun, 19 Jul 1998 14:22:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA46968
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 14:22:04 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from ms21.hinet.net (ms21.hinet.net [168.95.4.21]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08494
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 14:22:03 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1])
	by ms21.hinet.net (8.8.8/8.8.8) with ESMTP id FAA29148
	for <linux%cthulhu.engr.sgi.com@ms21.hinet.net>; Mon, 20 Jul 1998 05:21:54 +0800 (CST)
Received: from uni-koblenz.de (ralf@pmport-15.uni-koblenz.de [141.26.249.15])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA26730
	for <linux%cthulhu.engr.sgi.com@ms21.hinet.net>; Sun, 19 Jul 1998 23:21:30 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA00960;
	Sun, 19 Jul 1998 23:20:54 +0200
Message-ID: <19980719232054.A956@uni-koblenz.de>
Date: Sun, 19 Jul 1998 23:20:54 +0200
To: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>,
        Linux <linux%cthulhu.engr.sgi.com@ms21.hinet.net>
Subject: Re: [Q] How to reboot automatically?
References: <19980718164741.A868@life.nthu.edu.tw> <19980719041810.G489@uni-koblenz.de> <19980720041815.A298@helix.life.nthu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980720041815.A298@helix.life.nthu.edu.tw>; from Francis M. J. Hsieh on Mon, Jul 20, 1998 at 04:18:15AM +0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 20, 1998 at 04:18:15AM +0800, Francis M. J. Hsieh wrote:

> On Sun, Jul 19, 1998 at 04:18:10AM +0200, ralf@uni-koblenz.de wrote:
> > On Sat, Jul 18, 1998 at 04:47:41PM +0800, Francis M. J. Hsieh wrote:
> > > Can the bios remeber to reboot as "boot /vmlinux root=/dev/sdb1" ?
> > Try the ARC environment variable OsLoadOptions.  See also the IRIX manpages
> > about the firmware.
> 
> Well, OSLoadOptions saves only 12 character. Maybe I was at the wrong way,
> there is few document about firmware. neither the manpages nor the online
> books contain helpful information.

12 Characters?

!@#%%$!##,

  Ralf
