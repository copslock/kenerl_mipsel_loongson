Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 18:22:52 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:60610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013142AbbLCRWug0hXP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Dec 2015 18:22:50 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE6BD3A8;
        Thu,  3 Dec 2015 09:22:23 -0800 (PST)
Received: from [10.1.209.24] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065A43F21A;
        Thu,  3 Dec 2015 09:22:40 -0800 (PST)
Message-ID: <56607A5F.6090708@arm.com>
Date:   Thu, 03 Dec 2015 17:22:39 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Simon Arlott <simon@fire.lp0.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 02/11] MIPS: bmips: Add bcm6345-l2-timer interrupt controller
References: <565D9A40.60409@simon.arlott.org.uk> <565D9A73.3000500@simon.arlott.org.uk>
In-Reply-To: <565D9A73.3000500@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 01/12/15 13:02, Simon Arlott wrote:
> Add the BCM6345/BCM6318 timer as an interrupt controller so that it can be
> used by the watchdog to warn that its timer will expire soon.
> 
> Support for clocksource/clockevents is not implemented as the timer
> interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
> better. This could be added later if required without changing the device
> tree binding.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>  drivers/irqchip/Kconfig                |   5 +
>  drivers/irqchip/Makefile               |   1 +
>  drivers/irqchip/irq-bcm6345-l2-timer.c | 386 +++++++++++++++++++++++++++++++++
>  3 files changed, 392 insertions(+)
>  create mode 100644 drivers/irqchip/irq-bcm6345-l2-timer.c

I'm not sure how useful it is to have a bunch of timers that are just
turned off, but from an irqchip PoV:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
