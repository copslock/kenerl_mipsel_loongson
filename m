Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 00:12:03 +0000 (GMT)
Received: from p508B6DCE.dip.t-dialin.net ([IPv6:::ffff:80.139.109.206]:14490
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225304AbSLRAMD>; Wed, 18 Dec 2002 00:12:03 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBI0C0C02117;
	Wed, 18 Dec 2002 01:12:00 +0100
Date: Wed, 18 Dec 2002 01:11:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Julian Scheel <jscheel@activevb.de>
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS64 kernel cross-compiling
Message-ID: <20021218011159.B1532@linux-mips.org>
References: <200212172100.27296.jscheel@activevb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212172100.27296.jscheel@activevb.de>; from jscheel@activevb.de on Tue, Dec 17, 2002 at 09:00:27PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 09:00:27PM +0100, Julian Scheel wrote:
> From:	Julian Scheel <jscheel@activevb.de>
> To:	linux-mips@linux-mips.org
> Subject: MIPS64 kernel cross-compiling
> Date:	Tue, 17 Dec 2002 21:00:27 +0100
> Content-Type: text/plain;
>   charset="iso-8859-15"
> 
> Hi,
> 
> we're trying to compile a kernel for an embedded system with a 
> MIPS64-processor on it.
> We tried first with your CVS-sources, but there we get this error:
> 
> -----
>   Generating include/linux/version.h (unchanged)
> make[1]: Nothing to be done for `__build'.
>   SPLIT  include/linux/autoconf.h -> include/config/*
> make -f scripts/Makefile.build obj=arch/mips64/kernel 
> arch/mips64/kernel/offset.s
> make[1]: `arch/mips64/kernel/offset.s' is up to date.
> /bin/sh: arch/mips64/kernel/offset.s: Datei oder Verzeichnis nicht gefunden
> -----

2.5.  Don't dream about using it current.  Use the linux_2_4 branch.

  Ralf
