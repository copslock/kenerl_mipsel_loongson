Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2003 00:22:19 +0000 (GMT)
Received: from palrel11.hp.com ([IPv6:::ffff:156.153.255.246]:21407 "EHLO
	palrel11.hp.com") by linux-mips.org with ESMTP id <S8225385AbTLJAWS>;
	Wed, 10 Dec 2003 00:22:18 +0000
Received: from tomil.hpl.hp.com (tomil.hpl.hp.com [15.0.152.100])
	by palrel11.hp.com (Postfix) with ESMTP
	id 81F771C001EF; Tue,  9 Dec 2003 16:22:15 -0800 (PST)
Received: from bougret.hpl.hp.com (bougret.hpl.hp.com [15.4.92.227])
	by tomil.hpl.hp.com (8.9.3 (PHNE_28810+JAGae91741+JAGae92668)/8.9.3 HPLabs Timeshare Server) with ESMTP id QAA00525;
	Tue, 9 Dec 2003 16:22:14 -0800 (PST)
Received: from jt by bougret.hpl.hp.com with local (Exim 3.35 #1 (Debian))
	id 1ATs7K-0003CA-00; Tue, 09 Dec 2003 16:22:14 -0800
Date: Tue, 9 Dec 2003 16:22:14 -0800
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@gnu.org>,
	linux-mips@linux-mips.org, irda-users@sourceforge.net
Subject: Re: [PATCH] au1k_ir - fix for 2.6
Message-ID: <20031210002214.GA12272@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031209155440.2615b9cc.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209155440.2615b9cc.shemminger@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Return-Path: <jt@bougret.hpl.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jt@bougret.hpl.hp.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 09, 2003 at 03:54:40PM -0800, Stephen Hemminger wrote:
> This fixes some of the issues with the Alchemy irda driver for MIPS on
> 2.6.0-test11.  Tested with cross compile.  This driver is probably obsolete
> but it is one of the two remaining users of dev_alloc
> 
> Changes:
> 	* irqreturn_t for irq routine
> 	* alloc_irdadev instead of dev_alloc
> 	* should work as non module
> 
> Some mips build notes:
> 	* no way to enable the device at present since drivers/net/irda/Kconfig
> 	  expects MIPS_A1000 and arch/mips/Kconfig defines SOC_AU1000!
> 	* include/asm-mips/timex.h does not define CLOCK_TICK_RATE for this
> 	  that type.  Code should probably be:
> 
> #ifdef CONFIG_SGI_IP22
> #define CLOCK_TICK_RATE		1000000
> #else
> #define CLOCK_TICK_RATE		1193182
> #endif

	I don't have the hardware and I'm not familiar with MIPS, so
if the authors doesn't answer, we will merge your patch as is.
	Thanks...

	Jean
