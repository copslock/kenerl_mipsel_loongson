Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA30942 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Feb 1999 03:33:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA62917
	for linux-list;
	Wed, 3 Feb 1999 03:32:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA37118
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 Feb 1999 03:32:24 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA09373
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 03:32:18 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id MAA18024
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 12:32:12 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id EAA04815;
	Wed, 3 Feb 1999 04:39:51 +0100
Message-ID: <19990203043951.D3920@uni-koblenz.de>
Date: Wed, 3 Feb 1999 04:39:51 +0100
From: ralf@uni-koblenz.de
To: Alexander Graefe <nachtfalke@usa.net>, linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <19990202155147.A1565@ganymede>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990202155147.A1565@ganymede>; from Alexander Graefe on Tue, Feb 02, 1999 at 03:51:47PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Feb 02, 1999 at 03:51:47PM +0100, Alexander Graefe wrote:

> I got as far as booting Linux via bootp on my Indy, but after the
> remote root-fs is mounted, the kernel dies with an "Aieee" and
> something about irq request handler.

Ouch.  It was actually supposed to work on Indys, regardless of the processor
type.  Since it's no longer working things must somewhow got broken again.
I'll try to fix it but it's going to be hairy since I don't have an R4400SC
processor module.

> I tried booting with the 2.1.131-Kernel from ftp.linux.sgi.com, but
> that one doesn't try to mount the root-fs via NFS.
> 
> What kernel should I use to actually see a prompt on my Indy ?

Can you send me:

 - the exact screen output.  Especially the register dump following the
   Aiee message is important.
 - the output of the hinv command.  Hinv is an IRIX command.

> Quidquid latine dictum sit, altum viditur.

In nomeni patrii et filiae et spiritus pinguini ;-)

  Ralf
