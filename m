Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2016 15:12:40 +0100 (CET)
Received: from Galois.linutronix.de ([146.0.238.70]:46486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992209AbcKROMeX1AER (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2016 15:12:34 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1c7jrj-0007fo-8s; Fri, 18 Nov 2016 15:10:07 +0100
Date:   Fri, 18 Nov 2016 15:09:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, cernekee@gmail.com,
        jaedon.shin@gmail.com, justinpopo6@gmail.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MIPS: BMIPS: Fix interrupt affinity migration
In-Reply-To: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.20.1611181509250.3615@nanos>
References: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Mon, 31 Oct 2016, Florian Fainelli wrote:

> Hi,
> 
> These two patches are against Thomas' irq/core branch as of today:
> 
> 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let ksoftirqd do its job")
> 
> Patches can be taken indepdently or together, your call.
> 
> Florian Fainelli (2):
>   irqchip/bcm7038-l1: Implement irq_cpu_offline

I took that one through tip

>   MIPS: BMIPS: Migrate interrupts during bmips_cpu_disable

This one should probably go through MIPS

Thanks,

	tglx
