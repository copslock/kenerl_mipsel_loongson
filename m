Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA88820 for <linux-archive@neteng.engr.sgi.com>; Sat, 27 Jun 1998 06:10:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA07346
	for linux-list;
	Sat, 27 Jun 1998 06:09:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA57043
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 27 Jun 1998 06:09:26 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA22056
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 Jun 1998 06:09:24 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id PAA00492
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 Jun 1998 15:09:22 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id PAA02023;
	Sat, 27 Jun 1998 15:09:17 +0200
Message-ID: <19980627150916.B484@uni-koblenz.de>
Date: Sat, 27 Jun 1998 15:09:16 +0200
To: Oliver Frommel <oliver@aec.at>, linux@cthulhu.engr.sgi.com
Subject: Re: fs full on linus?
References: <Pine.LNX.3.96.980626175710.17397B-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980626175710.17397B-100000@web.aec.at>; from Oliver Frommel on Fri, Jun 26, 1998 at 05:58:51PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 26, 1998 at 05:58:51PM +0200, Oliver Frommel wrote:

> while trying to check out the kernel from linus.linux.sgi.com i got the 
> following message:
> 
> [oliver@baal sgi]$ cvs -z 9 -d oliver@linus.linux.sgi.com:/src/cvs update linux
> Enter passphrase for RSA key 'oliver@zero': 
> cvs [server aborted]: cannot open /tmp/cvs-serv13160/linux/drivers/sbus/CVS: No
>  space left on device

I zapped a collection of old logfile and moved my home to /work, so we now
have about 76mb free again.

  Ralf
