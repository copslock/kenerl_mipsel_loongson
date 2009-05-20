Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 21:21:06 +0100 (BST)
Received: from smtp23.services.sfr.fr ([93.17.128.20]:25486 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023099AbZETUU6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 21:20:58 +0100
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2326.sfr.fr (SMTP Server) with ESMTP id 0B223700008D;
	Wed, 20 May 2009 22:20:53 +0200 (CEST)
Received: from [192.168.1.101] (152.174.71-86.rev.gaoland.net [86.71.174.152])
	by msfrf2326.sfr.fr (SMTP Server) with ESMTP id 6182E700008B;
	Wed, 20 May 2009 22:20:52 +0200 (CEST)
X-SFR-UUID: 20090520202052399.6182E700008B@msfrf2326.sfr.fr
Subject: Re: Bigsur?
From:	Laurent GUERBY <laurent@guerby.net>
Reply-To: laurent@guerby.net
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Sharp <andy.sharp@onstor.com>,
	Jon Fraser <jfraser@broadcom.com>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20090520212243.0a023a22@scarran.roarinelk.net>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com>
	 <1242663215.18301.26.camel@chaos.ne.broadcom.com>
	 <20090518222334.GD16847@linux-mips.org>
	 <alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org>
	 <1242735440.6098.101.camel@localhost>
	 <20090519125310.GA17733@linux-mips.org>
	 <20090520110105.6fb81573@ripper.onstor.net>
	 <20090520191618.GA32295@linux-mips.org>
	 <20090520212243.0a023a22@scarran.roarinelk.net>
Content-Type: text/plain
Date:	Wed, 20 May 2009 22:21:09 +0200
Message-Id: <1242850869.6098.140.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <laurent@guerby.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurent@guerby.net
Precedence: bulk
X-list: linux-mips

On Wed, 2009-05-20 at 21:22 +0200, Manuel Lauss wrote:
> On Wed, 20 May 2009 20:16:18 +0100
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > On Wed, May 20, 2009 at 11:01:05AM -0700, Andrew Sharp wrote:
> > 
> > > Question: are machines that must be NFS-root and tftp booted acceptable
> > > or not acceptable for such work?  The machines in question would 750MHz
> > > Sibyte 1250s, so 3 Gigabit ports natively, and 2 serial consoles.
> > 
> > For many uses that will be decent but there are still a few things out
> > there that don't quite work the same way on NFS that they do on other
> > filesystems and that tends to break some software and autoconf-like
> > things.  I'd probably give such a config a 90% score - good for most stuff.
> 
> I rebuilt a whole Gentoo system from scratch natively over an NFSroot--
> it was actually very painless; add distcc and the time to wait is a
> lot shorter.

One of the farm machine is a Marvell sheevaplug with root over NFS
(gentoo based with marvell.git kernel) and it does multi user
compilations all day long with no issue so far.

Laurent
