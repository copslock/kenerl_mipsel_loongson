Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 17:57:04 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4364 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038547AbXA3R47 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jan 2007 17:56:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 793D6E1CB2;
	Tue, 30 Jan 2007 18:56:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p8ZA8gc5M9XQ; Tue, 30 Jan 2007 18:56:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 20068E1CA8;
	Tue, 30 Jan 2007 18:56:12 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l0UHuQH1026885;
	Tue, 30 Jan 2007 18:56:26 +0100
Date:	Tue, 30 Jan 2007 17:56:19 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	vagabon.xyz@gmail.com, dan@debian.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
In-Reply-To: <20070131.014133.75185230.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0701301735470.9231@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
 <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
 <cda58cb80701290827i1892e74dlb60651847982f77f@mail.gmail.com>
 <20070131.014133.75185230.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2505/Tue Jan 30 11:40:21 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 31 Jan 2007, Atsushi Nemoto wrote:

> I compiled ip27 kernel and really confused...
> 
> head.S:
> 	PTR_LA		t0, __bss_start		# clear .bss
> 	LONG_S		zero, (t0)
> 
> System.map:
> a8000000003b6000 A __bss_start
> 
> vmlinux:
> a800000000385058:	3c0c003b 	lui	t0,0x3b
> a80000000038505c:	658c6000 	daddiu	t0,t0,24576
> a800000000385060:	fd800000 	sd	zero,0(t0)
> 
> vmlinux.32:
> 80385058:	3c0c003b 	lui	t4,0x3b
> 8038505c:	658c6000 	daddiu	t4,t4,24576
> 80385060:	fd800000 	sd	zero,0(t4)
> 
> How does this code work?  Isn't address 0x3b6000 in user space?

 Well, the default config for this machine specifies -msym32 with the load 
address of 0xa80000000001c000.  No wonder it does not work.

 I suppose the setup for this platform should be more or less like this:

ifdef CONFIG_BUILD_ELF64
ifdef CONFIG_MAPPED_KERNEL
load-$(CONFIG_SGI_IP27)		+= 0xc00000004001c000
dataoffset-$(CONFIG_SGI_IP27)	+= 0x01000000
else
load-$(CONFIG_SGI_IP27)		+= 0xa80000000001c000
endif
else
ifdef CONFIG_MAPPED_KERNEL
load-$(CONFIG_SGI_IP27)		+= 0xffffffffc001c000
OBJCOPYFLAGS			:= --change-addresses=0xc000000080000000
dataoffset-$(CONFIG_SGI_IP27)	+= 0x01000000
else
load-$(CONFIG_SGI_IP27)		+= 0xffffffff8001c000
OBJCOPYFLAGS			:= --change-addresses=0xa800000080000000
endif
endif

 I can cook a patch if some SGI expert steps in and comments whether this 
makes sense from the platform point of view or not.

  Maciej
