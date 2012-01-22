Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2012 16:02:31 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47220 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1901171Ab2AVPCY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2012 16:02:24 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 1AA968F61;
        Sun, 22 Jan 2012 16:02:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NKy-1YhTLkH2; Sun, 22 Jan 2012 16:02:14 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 446388F60;
        Sun, 22 Jan 2012 16:02:14 +0100 (CET)
Message-ID: <4F1C24F5.2020506@hauke-m.de>
Date:   Sun, 22 Jan 2012 16:02:13 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
MIME-Version: 1.0
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        USB list <linux-usb@vger.kernel.org>, zajec5@gmail.com,
        linux-wireless@vger.kernel.org, m@bues.ch, george@znau.edu.ua
Subject: Re: [PATCH 4/7] USB: EHCI: Add a generic platform device driver
References: <Pine.LNX.4.44L0.1201212235050.32266-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1201212235050.32266-100000@netrider.rowland.org>
X-Enigmail-Version: 1.4a1pre
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/22/2012 04:41 AM, Alan Stern wrote:
> On Sat, 21 Jan 2012, Hauke Mehrtens wrote:
> 
>> This adds a generic driver for platform devices. It works like the PCI
>> driver and is based on it. This is for devices which do not have an own
>> bus but their EHCI controller works like a PCI controller. It will be
>> used for the Broadcom bcma and ssb USB EHCI controller.
> 
> Before adding a generic platform driver for EHCI, you should give some
> to thought to how it might be generalized.  There are a lot of EHCI
> platform drivers, all differing in various major or minor respects.  
> It should be possible to replace a lot of them with the generic driver, 
> but first it will need some way to cope with a few minor quirks.
> 
> Please consider this, and think about which of the existing drivers 
> could be replaced.

For now I just build this for bcma and ssb based SoCs. Yes there are
some drivers which could be replaced with this one, but most (all ??) of
them do something special in the device probing and this have to be
moved to somewhere else e.g. where the platform device is created.
I could rename it so it would not be generic any more, but I think it is
the wrong approach. ;-)
I am not able and do not have the time to convert all EHCI platform
drivers, where it is possible  to this generic platform driver, as I do
not have the devices to test this and time is limited.

If someone else wants to improve something on these "generic" platform
drivers to make them work with an other device I am totally fine with it.
> 
>> --- /dev/null
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -0,0 +1,211 @@
>> +/*
>> + * Generic platform ehci driver
>> + *
>> + * Copyright 2007 Steven Brown <sbrown@cortland.com>
>> + * Copyright 2010-2011 Hauke Mehrtens <hauke@hauke-m.de>
>> + *
>> + * Derived from the ohci-ssb driver
>> + * Copyright 2007 Michael Buesch <m@bues.ch>
>> + *
>> + * Derived from the EHCI-PCI driver
>> + * Copyright (c) 2000-2004 by David Brownell
>> + *
>> + * Derived from the ohci-pci driver
>> + * Copyright 1999 Roman Weissgaerber
>> + * Copyright 2000-2002 David Brownell
>> + * Copyright 1999 Linus Torvalds
>> + * Copyright 1999 Gregory P. Smith
>> + *
>> + * Licensed under the GNU/GPL. See COPYING for details.
>> + */
>> +#include <linux/platform_device.h>
>> +
>> +static int ehci_platform_reset(struct usb_hcd *hcd)
>> +{
>> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
>> +	int retval;
>> +
>> +	ehci->caps = hcd->regs;
>> +	ehci->regs = hcd->regs +
>> +		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
>> +
>> +	dbg_hcs_params(ehci, "reset");
>> +	dbg_hcc_params(ehci, "reset");
>> +
>> +	/* cache this readonly data; minimize chip reads */
>> +	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
>> +
>> +	retval = ehci_halt(ehci);
>> +	if (retval)
>> +		return retval;
>> +
>> +	/* data structure init */
>> +	retval = ehci_init(hcd);
>> +	if (retval)
>> +		return retval;
>> +
>> +	ehci_reset(ehci);
>> +
>> +	ehci_port_power(ehci, 1);
>> +
>> +	return retval;
>> +}
> 
> Most of this routine should be replaced with a call to ehci_setup.
Thanks for the info, this is changed.
> 
> Alan Stern
> 

Hauke
