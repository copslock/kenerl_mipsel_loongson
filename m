Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 06:00:21 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43887 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006516AbaKGFAUkGG59 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 06:00:20 +0100
Received: from pool-96-249-243-124.nrflva.fios.verizon.net ([96.249.243.124] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1Xmbee-0001YD-UO; Fri, 07 Nov 2014 05:00:13 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id B8590614035;
        Fri,  7 Nov 2014 00:00:09 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 96.249.243.124
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19QfMO2roM4AJ+pb3AcN6O5Ox5Qg4gUKyA=
X-DKIM: OpenDKIM Filter v2.0.1 titan B8590614035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1415336409;
        bh=3qGJ7mf+wJOt7GziCadMsgThryr7KQCmuMAZnNnEIkY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=cLxWK6iS5aD0Xnb9RRnYhos6u+eEW8W9m/JVGQRJQxZRaNuDWwAGpKL1n0PytPffD
         iJmptVs9y9sR5rNfXE6wFfanbAwMo8KHgrwEoqOegxyf24ecQDXVdtzcOp3g1R3RIe
         nQXB15f3r0+Sv+RcdEPDn7s1wKbsof50WfKuGInO0W2T7qOm9OI4XCa/iFP9iXfy18
         ks5NjVBw9Yqux9FfIX7CPxZBE0AGeqoRPiAqc4axCFI0XAMpQYaRdajF09Oih3CzGU
         NeVftP5CPACLB1l/f4XNkvxkL9w0nBXdHy0+exz7jEwaWTysWK4HSSr3LltLJSr5tW
         JFeFSpK7QVxXw==
Date:   Fri, 7 Nov 2014 00:00:09 -0500
From:   Jason Cooper <jason@lakedaemon.net>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        ralf@linux-mips.org, linux-sh@vger.kernel.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V3 00/14] genirq endian fixes; bcm7120/brcmstb IRQ
 updates
Message-ID: <20141107050009.GI3698@titan.lakedaemon.net>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43892
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

Kevin,

On Sat, Nov 01, 2014 at 06:03:47PM -0700, Kevin Cernekee wrote:
...
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

Patches 2, 3, and 4 applied to irqchip/core with Thomas' and Arnd's Acks
added.  Patches 5-$ added to irqchip/core with Arnd's Ack added where it
was missing.

I've left patch #1 for the sh maintainers.

thx,

Jason.
