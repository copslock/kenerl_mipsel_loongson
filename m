Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 20:22:53 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:48168 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025072AbZETTWp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 20:22:45 +0100
Received: (qmail 17286 invoked from network); 20 May 2009 21:22:44 +0200
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 20 May 2009 21:22:44 +0200
Date:	Wed, 20 May 2009 21:22:43 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Andrew Sharp <andy.sharp@onstor.com>,
	Laurent GUERBY <laurent@guerby.net>,
	Jon Fraser <jfraser@broadcom.com>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Bigsur?
Message-ID: <20090520212243.0a023a22@scarran.roarinelk.net>
In-Reply-To: <20090520191618.GA32295@linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com>
	<1242663215.18301.26.camel@chaos.ne.broadcom.com>
	<20090518222334.GD16847@linux-mips.org>
	<alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org>
	<1242735440.6098.101.camel@localhost>
	<20090519125310.GA17733@linux-mips.org>
	<20090520110105.6fb81573@ripper.onstor.net>
	<20090520191618.GA32295@linux-mips.org>
Organization: Private
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.16.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, 20 May 2009 20:16:18 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, May 20, 2009 at 11:01:05AM -0700, Andrew Sharp wrote:
> 
> > Question: are machines that must be NFS-root and tftp booted acceptable
> > or not acceptable for such work?  The machines in question would 750MHz
> > Sibyte 1250s, so 3 Gigabit ports natively, and 2 serial consoles.
> 
> For many uses that will be decent but there are still a few things out
> there that don't quite work the same way on NFS that they do on other
> filesystems and that tends to break some software and autoconf-like
> things.  I'd probably give such a config a 90% score - good for most stuff.

I rebuilt a whole Gentoo system from scratch natively over an NFSroot--
it was actually very painless; add distcc and the time to wait is a
lot shorter.

	Manuel Lauss
