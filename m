Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA06050 for <linux-archive@neteng.engr.sgi.com>; Mon, 20 Jul 1998 09:41:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA91769
	for linux-list;
	Mon, 20 Jul 1998 09:40:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA68154
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Jul 1998 09:40:30 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: from ms21.hinet.net (ms21.hinet.net [168.95.4.21]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA05877
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Jul 1998 09:40:26 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: from sgi.sgi.com (SGI.COM [192.48.153.1])
	by ms21.hinet.net (8.8.8/8.8.8) with ESMTP id AAA20725
	for <linux%cthulhu.engr.sgi.com@ms21.hinet.net>; Tue, 21 Jul 1998 00:40:20 +0800 (CST)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA05746; Mon, 20 Jul 1998 09:40:07 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA58963;
	Mon, 20 Jul 1998 09:13:04 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA28042; Mon, 20 Jul 1998 09:10:34 -0700
Date: Mon, 20 Jul 1998 09:10:34 -0700
Message-Id: <199807201610.JAA28042@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>
Cc: Linux <linux%cthulhu.engr.sgi.com@ms21.hinet.net>
Subject: Re: [Q] How to reboot automatically?
In-Reply-To: <19980720202548.A526@helix.life.nthu.edu.tw>
References: <19980718164741.A868@life.nthu.edu.tw>
	<19980719041810.G489@uni-koblenz.de>
	<19980720041815.A298@helix.life.nthu.edu.tw>
	<19980719232054.A956@uni-koblenz.de>
	<19980720202548.A526@helix.life.nthu.edu.tw>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Francis M. J. Hsieh writes:
 > On Sun, Jul 19, 1998 at 11:20:54PM +0200, ralf@uni-koblenz.de wrote:
 > > On Mon, Jul 20, 1998 at 04:18:15AM +0800, Francis M. J. Hsieh wrote:
 > > > Well, OSLoadOptions saves only 12 character. Maybe I was at the wrong way,
 > > > there is few document about firmware. neither the manpages nor the online
 > > > books contain helpful information.
 > > 
 > > 12 Characters?
 > > 
 > > !@#%%$!##,
 > 
 > any idea? the sash would not read root variable...... so setenv root won't
 > work...

    To boot IRIX from an alternate partition, we usually
set

	OSLoadPartition=scsi(0)disk(4)rdisk(0)partition(0)
	OSLoader=sash
	OSLoadFilename=/unix
	root=dks0d4s0

sash is fetched from

	SystemPartition=scsi(0)disk(4)rdisk(0)partition(8)

These can be set in the NVRAM using

	setenv -p SymbolName SymbolValue

IRIX looks at the environment when booting.  That is, it finds
argc, argv, and envp in $a0, $a1, and $a2.  It copies them to
private storage before starting up, since they are in memory
which will be overlaid by dynamic memory allocation.  All of the
NVRAM and temporary environment variables are passed via envp.
IRIX looks for root= on the command line (in argv) first, and then
in the environment, before falling back on a default.  linux could
do the same.
