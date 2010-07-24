Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 05:58:35 +0200 (CEST)
Received: from pfepa.post.tele.dk ([195.41.46.235]:60128 "EHLO
        pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491124Ab0GXD6b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 05:58:31 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepa.post.tele.dk (Postfix) with ESMTP id 03431A50014;
        Sat, 24 Jul 2010 05:58:24 +0200 (CEST)
Date:   Sat, 24 Jul 2010 05:58:26 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, wim@iguana.be,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@misterjones.org>,
        Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 7/7] watchdog: Add watchdog driver for OCTEON SOCs.
Message-ID: <20100724035826.GA27516@merkur.ravnborg.org>
References: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com> <1279935707-3997-8-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279935707-3997-8-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

Hi David.

In general a very nicely commented piece of code!

A few nits...

> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 72f3e20..4e7179b 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -114,6 +114,8 @@ obj-$(CONFIG_PNX833X_WDT) += pnx833x_wdt.o
>  obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
>  obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
>  obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
> +obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
> +octeon-wdt-objs := octeon-wdt-main.o octeon-wdt-nmi.o

The use of foo-objs := ... is considered old-school.
Use:

    octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o

It is the same functionality.

> +
> +#include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/smp.h>
> +#include <linux/string.h>
> +#include <linux/watchdog.h>

People have started to use the "inverse christmas tree" for
include files.

But you sort is alphabetically which is also good.

The "inverse christmas tree" would look like this:

#include <linux/miscdevice.h>
#include <linux/interrupt.h>
#include <linux/watchdog.h>
#include <linux/cpumask.h>
#include <linux/bitops.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/delay.h>
#include <linux/cpu.h>
#include <linux/smp.h>
#include <linux/fs.h>

Both styles are fine so pick what you like.

> +module_param(heartbeat, int, 0444);
module_param(heartbeat, int, S_IRUSR | S_IRGRP | S_IROTH);

or even the shorter:
module_param(heartbeat, int, S_IRUGO);


This is a bit more descriptive - but still the same functionality.


> +module_param(nowayout, int, 0444);
ditto.


> +void octeon_wdt_nmi_stage3(uint64_t reg[32])
> +{
> +	uint64_t i;

The kernel version of this type is "u64".
We usually say that the stdint types belongs to userspace.
But it is used in many places so no big deal.

Note: you use stdint types in several places,
but there is no need to repeat the comment.

	Sam
