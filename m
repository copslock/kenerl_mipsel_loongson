Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2004 18:36:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:14094 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225248AbUI3Rgv>; Thu, 30 Sep 2004 18:36:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 91551F5DC1; Thu, 30 Sep 2004 19:36:44 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02933-04; Thu, 30 Sep 2004 19:36:44 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2EB47F5DB7; Thu, 30 Sep 2004 19:36:44 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i8UHavl6020798;
	Thu, 30 Sep 2004 19:36:58 +0200
Date: Thu, 30 Sep 2004 18:36:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] 64-bit on Broadcom SWARM
In-Reply-To: <415C3ABA.6080601@mvista.com>
Message-ID: <Pine.LNX.4.58L.0409301823290.25286@blysk.ds.pg.gda.pl>
References: <415C3ABA.6080601@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Sep 2004, Manish Lachwani wrote:

> Attached patch gets the 64-bit to work on the Broadcom SWARM.

 Inline, please!

> --- arch/mips/Makefile.orig	2004-09-30 09:49:45.000000000 -0700
> +++ arch/mips/Makefile	2004-09-30 09:50:27.000000000 -0700
> @@ -35,7 +35,7 @@
>  endif
>  ifdef CONFIG_MIPS64
>  gcc-abi			= 64
> -gas-abi			= 32
> +gas-abi			= 64
>  tool-prefix		= $(64bit-tool-prefix)
>  UTS_MACHINE		:= mips64
>  endif

 I won't particularly mind having this change in, but there are apparently
people who want to have the current setting preserved.  So I doubt this
part is going to be accepted.  Please use `make "gas-abi=64" <whatever>'
instead.

 Alternatively, please let me check if I can get some time to implement 
one of my to-do list goals, that is having it configurable.

> @@ -580,7 +580,11 @@
>  libs-$(CONFIG_SIBYTE_SENTOSA)	+= arch/mips/sibyte/swarm/
>  load-$(CONFIG_SIBYTE_SENTOSA)	:= 0x80100000
>  libs-$(CONFIG_SIBYTE_SWARM)	+= arch/mips/sibyte/swarm/
> +ifdef CONFIG_MIPS64
> +load-$(CONFIG_SIBYTE_SWARM)	:= 0xffffffff80100000
> +else
>  load-$(CONFIG_SIBYTE_SWARM)	:= 0x80100000
> +endif
>  
>  #
>  # SNI RM200 PCI

 I think 32-bit tools may be able to cope with 0xffffffff80100000, so you 
wouldn't need this conditional.  Actually some 32-bit can't really cope 
with something like 0x80100000, grr...  Cf. objdump.

> @@ -651,7 +655,11 @@
>  AFLAGS		+= $(cflags-y)
>  CFLAGS		+= $(cflags-y)
>  
> +ifdef CONFIG_MIPS64
> +LDFLAGS			+= --oformat $(64bit-bfd)
> +else
>  LDFLAGS			+= --oformat $(32bit-bfd)
> +endif
>  
>  head-y := arch/mips/kernel/head.o arch/mips/kernel/init_task.o
>  

 See the comment about gas-abi -- you can override 32bit-bfd. ;-)

> --- arch/mips/Kconfig.orig	2004-09-30 09:49:51.000000000 -0700
> +++ arch/mips/Kconfig	2004-09-30 09:50:34.000000000 -0700
> @@ -1076,7 +1076,7 @@
>  
>  config BOOT_ELF64
>  	bool
> -	depends on SGI_IP27
> +	depends on SGI_IP27 || SIBYTE_SB1xxx_SOC
>  	default y
>  

 And this is another part to be configurable in general.  E.g. I use
64-bit ELF for 64-bit DECstations, too, but others may prefer 32-bit
binaries.

  Maciej
