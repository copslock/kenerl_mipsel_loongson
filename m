Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 16:06:12 +0000 (GMT)
Received: from p508B7DF8.dip.t-dialin.net ([IPv6:::ffff:80.139.125.248]:31413
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225344AbTJ0QGJ>; Mon, 27 Oct 2003 16:06:09 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9RG66NK023430;
	Mon, 27 Oct 2003 17:06:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9RG6455023429;
	Mon, 27 Oct 2003 17:06:04 +0100
Date: Mon, 27 Oct 2003 17:06:04 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: David Kesselring <dkesselr@mmc.atmel.com>,
	linux-mips@linux-mips.org
Subject: Re: Relocation errors
Message-ID: <20031027160604.GA23292@linux-mips.org>
References: <20031027145803.GA26911@nevyn.them.org> <Pine.GSO.4.44.0310271002480.19642-100000@ares.mmc.atmel.com> <20031027151421.GA27279@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027151421.GA27279@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2003 at 10:14:21AM -0500, Daniel Jacobowitz wrote:
> Date: Mon, 27 Oct 2003 10:14:21 -0500
> From: Daniel Jacobowitz <dan@debian.org>
> To: David Kesselring <dkesselr@mmc.atmel.com>
> Cc: linux-mips@linux-mips.org
> Subject: Re: Relocation errors
> Content-Type: text/plain; charset=us-ascii
> 
> Take a look at /usr/include/elf.h:
> #define R_MIPS_LITERAL          8       /* 16 bit literal entry */
> 
> In this case it's not very informative.  But the problem is probably
> mismatched CFLAGS.  Take another look at the options the kernel is
> built with - you lost -G 0.  See if that does it.

My gcc patches used to set this to zero because the -G optimization doesn't
work on Linux; I think HJ Lu's (?) gcc patches lost this.

  Ralf
