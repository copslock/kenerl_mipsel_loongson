Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Nov 2002 18:37:02 +0100 (CET)
Received: from p508B7523.dip.t-dialin.net ([80.139.117.35]:6318 "EHLO
	p508B7523.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122109AbSKCRhC>; Sun, 3 Nov 2002 18:37:02 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S867025AbSKCRgu>; Sun, 3 Nov 2002 18:36:50 +0100
Date: Sun, 3 Nov 2002 18:36:50 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: fixed the problem about build of vr41xx on linux-2.5.45
Message-ID: <20021103183650.A23232@bacchus.dhis.org>
References: <20021103235224.2d7a4814.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021103235224.2d7a4814.yuasa@hh.iij4u.or.jp>; from yuasa@hh.iij4u.or.jp on Sun, Nov 03, 2002 at 11:52:24PM +0900
X-Accept-Language: de,en,fr
Return-Path: <ralf@uni-koblenz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@uni-koblenz.de
Precedence: bulk
X-list: linux-mips

On Sun, Nov 03, 2002 at 11:52:24PM +0900, Yoichi Yuasa wrote:

> Hello Ralf,
> 
> I fixed the problem about build of vr41xx on linux-2.5.45.
> Here is a patch.

I applied the patch although quite heavily modified.  Here the bad bits:

>  config SERIAL
>  	tristate
> -	depends on NEC_OSPREY || IBM_WORKPAD || CASIO_E55
> +	depends on ZAO_CAPCELLA || NEC_EAGLE || NEC_OSPREY || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55
>  	default y
>  	---help---
>  	  This selects whether you want to include the driver for the standard

This misses the problem.  There is no more CONFIG_SERIAL option and as such
I removed all CONFIG_SERIAL* stuff entirely.

> @@ -553,9 +553,9 @@
>  	depends on MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000
>  	default y
>  
> -config CONFIG_VR41XX_COMMON
> +config VR41XX_COMMON
>  	bool
> -	depends on CONFIG_NEC_EAGLE || CONFIG_ZAO_CAPCELLA || CONFIG_VICTOR_MPC30X || CONFIG_IBM_WORKPAD || CONFIG_CASIO_E55
> +	depends on NEC_EAGLE || ZAO_CAPCELLA || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55
>  	default y

And this one entirely misses the code of the problem.  There were a whole
bunch of options which accidently still had the CONFIG_ prefix.

> diff -aruN linux.orig/arch/mips/defconfig-workpad linux/arch/mips/defconfig-workpad
> --- linux.orig/arch/mips/defconfig-workpad	Sun Nov  3 20:43:06 2002
> +++ linux/arch/mips/defconfig-workpad	Sun Nov  3 23:36:58 2002
> @@ -22,7 +22,7 @@
>  # Loadable module support
>  #
>  CONFIG_MODULES=y
> -CONFIG_MODVERSIONS=y
> +# CONFIG_MODVERSIONS is not set

It's your call - but as this help to avoid accidents it's a bad idea to
disable CONFIG_MODVERSIONS.

> diff -aruN linux.orig/include/asm-mips/ide.h linux/include/asm-mips/ide.h
> --- linux.orig/include/asm-mips/ide.h	Thu Oct 31 22:50:01 2002
> +++ linux/include/asm-mips/ide.h	Sun Nov  3 22:33:12 2002
> @@ -202,8 +202,6 @@
>  
>  #else /* defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)  */
>  
> -#define ide_fix_driveid(id)		do {} while (0)
> -

Again this entirely misses the scope of the problem.  There should be no
more definition of ide_fix_driveid() in this file at all and there's
quite a bit more of obsoleted junk left in that file.

  Ralf
