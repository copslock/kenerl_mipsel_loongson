Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2012 04:41:38 +0100 (CET)
Received: from netrider.rowland.org ([192.131.102.5]:59977 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1901167Ab2AVDla (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2012 04:41:30 +0100
Received: (qmail 32631 invoked by uid 500); 21 Jan 2012 22:41:26 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2012 22:41:26 -0500
Date:   Sat, 21 Jan 2012 22:41:26 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Hauke Mehrtens <hauke@hauke-m.de>
cc:     ralf@linux-mips.org, <linux-mips@linux-mips.org>,
        USB list <linux-usb@vger.kernel.org>, <zajec5@gmail.com>,
        <linux-wireless@vger.kernel.org>, <m@bues.ch>, <george@znau.edu.ua>
Subject: Re: [PATCH 4/7] USB: EHCI: Add a generic platform device driver
In-Reply-To: <1327184367-8824-5-git-send-email-hauke@hauke-m.de>
Message-ID: <Pine.LNX.4.44L0.1201212235050.32266-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, 21 Jan 2012, Hauke Mehrtens wrote:

> This adds a generic driver for platform devices. It works like the PCI
> driver and is based on it. This is for devices which do not have an own
> bus but their EHCI controller works like a PCI controller. It will be
> used for the Broadcom bcma and ssb USB EHCI controller.

Before adding a generic platform driver for EHCI, you should give some
to thought to how it might be generalized.  There are a lot of EHCI
platform drivers, all differing in various major or minor respects.  
It should be possible to replace a lot of them with the generic driver, 
but first it will need some way to cope with a few minor quirks.

Please consider this, and think about which of the existing drivers 
could be replaced.

> --- /dev/null
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -0,0 +1,211 @@
> +/*
> + * Generic platform ehci driver
> + *
> + * Copyright 2007 Steven Brown <sbrown@cortland.com>
> + * Copyright 2010-2011 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * Derived from the ohci-ssb driver
> + * Copyright 2007 Michael Buesch <m@bues.ch>
> + *
> + * Derived from the EHCI-PCI driver
> + * Copyright (c) 2000-2004 by David Brownell
> + *
> + * Derived from the ohci-pci driver
> + * Copyright 1999 Roman Weissgaerber
> + * Copyright 2000-2002 David Brownell
> + * Copyright 1999 Linus Torvalds
> + * Copyright 1999 Gregory P. Smith
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +#include <linux/platform_device.h>
> +
> +static int ehci_platform_reset(struct usb_hcd *hcd)
> +{
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	int retval;
> +
> +	ehci->caps = hcd->regs;
> +	ehci->regs = hcd->regs +
> +		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
> +
> +	dbg_hcs_params(ehci, "reset");
> +	dbg_hcc_params(ehci, "reset");
> +
> +	/* cache this readonly data; minimize chip reads */
> +	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
> +
> +	retval = ehci_halt(ehci);
> +	if (retval)
> +		return retval;
> +
> +	/* data structure init */
> +	retval = ehci_init(hcd);
> +	if (retval)
> +		return retval;
> +
> +	ehci_reset(ehci);
> +
> +	ehci_port_power(ehci, 1);
> +
> +	return retval;
> +}

Most of this routine should be replaced with a call to ehci_setup.

Alan Stern
