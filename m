Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2003 20:38:19 +0000 (GMT)
Received: from p508B5A9E.dip.t-dialin.net ([IPv6:::ffff:80.139.90.158]:15510
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225467AbTKLUh5>; Wed, 12 Nov 2003 20:37:57 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hACKbrA0018468;
	Wed, 12 Nov 2003 21:37:53 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hACKboxF018467;
	Wed, 12 Nov 2003 21:37:50 +0100
Date: Wed, 12 Nov 2003 21:37:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Wolfgang Denk <wd@denx.de>
Cc: David Kesselring <dkesselr@mmc.atmel.com>,
	linux-mips@linux-mips.org
Subject: Re: snapgear and uClinux
Message-ID: <20031112203750.GD18124@linux-mips.org>
References: <Pine.GSO.4.44.0311121132480.5676-100000@ares.mmc.atmel.com> <20031112164810.355ECC5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112164810.355ECC5F59@atlas.denx.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 12, 2003 at 05:48:05PM +0100, Wolfgang Denk wrote:

> > processor? Did you have any unexpected suprises? Do these tools help get
> > the footprint smaller or is it easier to do something with the linux-mips
> > tree?

> If you have a MMU on your chip you should always go for the "real" Linux.
> 
> Reducing the memory footprint is not so much a kernel issue  but  one
> of  the application level - using standard tools linked against glibc
> vs. busybox with uClibc for example.

Certain mechanism such as copy on write are only possible with an MMU and
can achieve dramatic memory savings.  The common believe that memory
protection results in significant overhead isn't true anymore, so
Wolfgang ist certainly right here.

  Ralf
