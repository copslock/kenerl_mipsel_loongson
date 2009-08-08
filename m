Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2009 13:59:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35870 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492961AbZHHL7b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Aug 2009 13:59:31 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n78C08LQ029878;
	Sat, 8 Aug 2009 13:00:08 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n78C08cI029877;
	Sat, 8 Aug 2009 13:00:08 +0100
Date:	Sat, 8 Aug 2009 13:00:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/8] bcm63xx: add infrastructure for MPI-connected VoIP
	DSP
Message-ID: <20090808120008.GB14596@linux-mips.org>
References: <200908072346.21785.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908072346.21785.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 07, 2009 at 11:46:21PM +0200, Florian Fainelli wrote:

> This patch adds the required infrastructure to register
> a MPI and GPIO connected VoIP DSP. We will register
> devices in a subsequent patch.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
> index 92d07f0..70ba038 100644
> --- a/arch/mips/bcm63xx/Makefile
> +++ b/arch/mips/bcm63xx/Makefile
> @@ -4,6 +4,7 @@ obj-y		+= dev-pcmcia.o
>  obj-y		+= dev-usb-ohci.o
>  obj-y		+= dev-usb-ehci.o
>  obj-y		+= dev-enet.o
> +obj-y		+= dev-dsp.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  
>  obj-y		+= boards/
> diff --git a/arch/mips/bcm63xx/dev-dsp.c b/arch/mips/bcm63xx/dev-dsp.c
> new file mode 100644
> index 0000000..08a2f75
> --- /dev/null
> +++ b/arch/mips/bcm63xx/dev-dsp.c
> @@ -0,0 +1,56 @@
> +/*
> + * Broadcom BCM63xx VoIP DSP registration
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2009 Florian Fainelli <florian@openwrt.org> 
                                                              ^^^

You *wham* shall *wham* not *wham* sumbit *wham* trailing *wham* whitespace :-)

I cleaned that but it's really YOUR job to do that.

   Ralf
