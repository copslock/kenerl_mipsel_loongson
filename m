Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2003 20:02:21 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17149 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225318AbTLKUCV>;
	Thu, 11 Dec 2003 20:02:21 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA28160;
	Thu, 11 Dec 2003 12:00:06 -0800
Subject: Re: [PATCH] au1k_ir - fix for 2.6
From: Pete Popov <ppopov@mvista.com>
To: jt@hpl.hp.com
Cc: Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@gnu.org>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>,
	irda-users@sourceforge.net
In-Reply-To: <20031210002214.GA12272@bougret.hpl.hp.com>
References: <20031209155440.2615b9cc.shemminger@osdl.org>
	 <20031210002214.GA12272@bougret.hpl.hp.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1071173167.8789.83.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Dec 2003 12:06:07 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-12-09 at 16:22, Jean Tourrilhes wrote:
> On Tue, Dec 09, 2003 at 03:54:40PM -0800, Stephen Hemminger wrote:
> > This fixes some of the issues with the Alchemy irda driver for MIPS on
> > 2.6.0-test11.  Tested with cross compile.  This driver is probably obsolete
> > but it is one of the two remaining users of dev_alloc
> > 
> > Changes:
> > 	* irqreturn_t for irq routine
> > 	* alloc_irdadev instead of dev_alloc
> > 	* should work as non module
> > 
> > Some mips build notes:
> > 	* no way to enable the device at present since drivers/net/irda/Kconfig
> > 	  expects MIPS_A1000 and arch/mips/Kconfig defines SOC_AU1000!
> > 	* include/asm-mips/timex.h does not define CLOCK_TICK_RATE for this
> > 	  that type.  Code should probably be:
> > 
> > #ifdef CONFIG_SGI_IP22
> > #define CLOCK_TICK_RATE		1000000
> > #else
> > #define CLOCK_TICK_RATE		1193182
> > #endif
> 
> 	I don't have the hardware and I'm not familiar with MIPS, so
> if the authors doesn't answer, we will merge your patch as is.

Go ahead.

Pete
