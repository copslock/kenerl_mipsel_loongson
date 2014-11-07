Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 13:28:00 +0100 (CET)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18262 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012759AbaKGM16OElbm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 13:27:58 +0100
Received: from pool-96-249-243-124.nrflva.fios.verizon.net ([96.249.243.124] helo=titan)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1Xmido-000FmV-Ly; Fri, 07 Nov 2014 12:27:49 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id A0F8261441E;
        Fri,  7 Nov 2014 07:27:45 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 96.249.243.124
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18wTS5nWzr9sPEpRgKSG1ncszjNPJnR5RQ=
X-DKIM: OpenDKIM Filter v2.0.1 titan A0F8261441E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1415363265;
        bh=Vew62N8Vdvcz0NN4jUjtUhzPshpnxAqfDpu/SV/SGHo=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=s7TqcsSrVettb6yQftjCXGyB0ztzfxtLaEixgMHceKnBFk78JVg9fW1DPvXfmTwIS
         hHcAZx3c/jb2G4ogV5pHGOL1MkYhGeXUg5ZS2vAZZdGRKFVewaO2JFMGQdXBbzTfGn
         5QLWYUQkFNH1hqYDRHGOmMSsDdcIo+gr2YLX4rA06iTRo3pQBYfYCiohUKwLslaj2f
         O6KlrE78dpLaUjvhRaw7YZhhPpcZOsYkaRYHxwiv6B1rP01PmOS1YolGPT2N0bYwOg
         BEXtGffDhXGvzuWFshbQBjIGKz7cqMDBqnwz4Y1HgzIKfS4wiTy9XW1NvIqMPoWS7w
         4qJZqG+1bLR9g==
Date:   Fri, 7 Nov 2014 07:27:45 -0500
From:   Jason Cooper <jason@lakedaemon.net>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     tglx@linutronix.de, linux-sh@vger.kernel.org, arnd@arndb.de,
        f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V4 00/14] genirq endian fixes; bcm7120/brcmstb IRQ
 updates
Message-ID: <20141107122745.GJ3698@titan.lakedaemon.net>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Thomas,

On Thu, Nov 06, 2014 at 10:44:15PM -0800, Kevin Cernekee wrote:
> V3->V4:
> 
>  - Fix buildbot bisectability warning on patch 02/14 (missing include)

Dammit.  :(  Even if I had created a topic branch for this series, I
still would have put the genirq changes in /core, then based a brcm
branch off of that.

I'm inclined to think I should just drop v3 and apply v4, as a revert
commit wouldn't solve the bisectability issue.

thoughts?

thx,

Jason.

> 
>  - Add kernel-doc text for the new reg_{readl,writel} struct members and
>    IRQ_GC_BE_IO flag
> 
> 
> Kevin Cernekee (14):
>   sh: Eliminate unused irq_reg_{readl,writel} accessors
>   genirq: Generic chip: Change irq_reg_{readl,writel} arguments
>   genirq: Generic chip: Allow irqchip drivers to override
>     irq_reg_{readl,writel}
>   genirq: Generic chip: Add big endian I/O accessors
>   irqchip: brcmstb-l2: Eliminate dependency on ARM code
>   irqchip: bcm7120-l2: Eliminate bad IRQ check
>   irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
>   irqchip: bcm7120-l2: Make sure all register accesses use base+offset
>   irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
>   irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume
>     functions
>   irqchip: bcm7120-l2: Extend driver to support 64+ bit controllers
>   irqchip: bcm7120-l2: Decouple driver from brcmstb-l2
>   irqchip: bcm7120-l2: Convert driver to use irq_reg_{readl,writel}
>   irqchip: brcmstb-l2: Convert driver to use irq_reg_{readl,writel}
> 
>  .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  26 ++-
>  arch/arm/mach-bcm/Kconfig                          |   1 +
>  arch/sh/boards/mach-se/7343/irq.c                  |   3 -
>  arch/sh/boards/mach-se/7722/irq.c                  |   3 -
>  drivers/irqchip/Kconfig                            |   6 +-
>  drivers/irqchip/Makefile                           |   4 +-
>  drivers/irqchip/irq-atmel-aic.c                    |  40 ++---
>  drivers/irqchip/irq-atmel-aic5.c                   |  65 ++++----
>  drivers/irqchip/irq-bcm7120-l2.c                   | 174 +++++++++++++--------
>  drivers/irqchip/irq-brcmstb-l2.c                   |  41 +++--
>  drivers/irqchip/irq-sunxi-nmi.c                    |   4 +-
>  drivers/irqchip/irq-tb10x.c                        |   4 +-
>  include/linux/irq.h                                |  32 +++-
>  kernel/irq/generic-chip.c                          |  36 +++--
>  14 files changed, 263 insertions(+), 176 deletions(-)
> 
> -- 
> 2.1.1
> 
