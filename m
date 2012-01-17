Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2012 16:23:04 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:46564 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903622Ab2AQPW5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2012 16:22:57 +0100
Received: (qmail 2151 invoked by uid 2102); 17 Jan 2012 10:22:51 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jan 2012 10:22:51 -0500
Date:   Tue, 17 Jan 2012 10:22:50 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kelvin Cheung <keguang.zhang@gmail.com>
cc:     ralf@linux-mips.org, <linux-mips@linux-mips.org>,
        <linux-usb@vger.kernel.org>, <gregkh@suse.de>,
        <zhzhl555@gmail.com>, <peppe.cavallaro@st.com>,
        <wuzhangjin@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 4/5] USB: Add EHCI bus glue for Loongson1x SoCs
In-Reply-To: <1326777160-9930-5-git-send-email-keguang.zhang@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1201171021320.1818-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 17 Jan 2012, Kelvin Cheung wrote:

> The Loongson1x SoCs have a built-in EHCI controller.
> This patch adds the necessary glue code to make the generic EHCI
> driver usable for them.

> --- /dev/null
> +++ b/drivers/usb/host/ehci-ls1x.c
> @@ -0,0 +1,170 @@
> +/*
> + *  Bus Glue for Loongson LS1X built-in EHCI controller.
> + *
> + *  Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + */
> +
> +
> +#include <linux/platform_device.h>
> +
> +static int ehci_ls1x_setup(struct usb_hcd *hcd)
> +{
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	int ret;
> +
> +	ehci->caps = hcd->regs;
> +	ehci->regs = hcd->regs +
> +		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
> +	dbg_hcs_params(ehci, "reset");
> +	dbg_hcc_params(ehci, "reset");
> +
> +	/* cache this readonly data; minimize chip reads */
> +	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
> +	ehci->sbrn = 0x20;
> +
> +	ehci_reset(ehci);
> +
> +	/* data structure init */
> +	ret = ehci_init(hcd);
> +	if (ret)
> +		return ret;
> +
> +	ehci_port_power(ehci, 0);
> +
> +	return 0;
> +}

Most of this routine should be replaced with a call to ehci_setup().

Alan Stern
