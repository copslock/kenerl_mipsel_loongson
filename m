Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 02:54:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:22281 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224929AbUJCByf>; Sun, 3 Oct 2004 02:54:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D70D4E1CDB; Sun,  3 Oct 2004 03:54:26 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03094-01; Sun,  3 Oct 2004 03:54:26 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 913C0E1C78; Sun,  3 Oct 2004 03:54:26 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i931sjn1026385;
	Sun, 3 Oct 2004 03:54:49 +0200
Date: Sun, 3 Oct 2004 02:54:30 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Christian Hecimovic <checimovic@sutus.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Building 2.6 cvs head on db1550
In-Reply-To: <200410011054.39764.checimovic@sutus.com>
Message-ID: <Pine.LNX.4.58L.0410030246560.22545@blysk.ds.pg.gda.pl>
References: <200410011054.39764.checimovic@sutus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Oct 2004, Christian Hecimovic wrote:

> I'm having problems building 2.6 head from the linux-mips cvs. There were a 
> number of build errors with the /arch/mips/config/db1550-defconfig file. 
> Eventually, it built with a number of fixes. Here's the diff:
> 
> Index: arch/mips/Kconfig
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/Kconfig,v
> retrieving revision 1.96
> diff -r1.96 Kconfig
> 583a584
> > 	select DMA_NONCOHERENT

 Read Documentation/SubmittingPatches (diff -up), please!

> Index: arch/mips/Makefile
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/Makefile,v
> retrieving revision 1.176
> diff -r1.176 Makefile
> 19c19
> < 32bit-tool-prefix	= mipsel-linux-
> ---
> > 32bit-tool-prefix	= mipsel-unknown-linux-gnu-

 This is specific to your setup -- most people use the shorter form for 
whatever reason (less typing, less disk space, etc.).  You may invoke 
`make "CROSS_COMPILE=mipsel-unknown-linux-gnu-" <whatever>' for an 
override.

 The rest is system-specific; I can't comment.

  Maciej
