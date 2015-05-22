Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:27:08 +0200 (CEST)
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:43185 "HELO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S27006684AbbEVR1Gflicj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:27:06 +0200
Received: from io (unknown [72.84.113.125])
        by outbound2.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Fri, 22 May 2015 17:27:20 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id E510F80128;
        Fri, 22 May 2015 17:27:02 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io E510F80128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1432315622;
        bh=FngXok4CgRKvCF4lvhfda3uOB3wu1dGOv+27fIbw5rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aMTfhcWXBVYC2exuT+gHj7Y/BRw324ih9ko/4mpdLwY2OV3aWEkniuiVRwnmkyuFG
         2gUgOHBGb9HiIFIHrGxa1MabCsczkKvIO0o0V4Xx8xV0h5C7XrBQNwiQHSppENQDeb
         fiYXFvTFvhJ+BgkS+IrjEYf2bO2hJXfivEn2G7UIiawonu7XhUdJYNsojjYMtUCkfc
         qdNEIJ9cjlLjXJeInwaRl0Oks43+PbjGclO5nM/kUdyR7qSP+9VmG8nBItpEveH320
         7u/UBSAmCyB6auMBuPn7GfO5ivdA7ol93d6cvwiv7oeAfxhNvZ2ull+1yIC+0yTh+3
         wLpRI7lmwiecg==
Date:   Fri, 22 May 2015 17:27:02 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] irqchip: mips-gic: register IRQ domain with
 MIPS_GIC_IRQ_BASE
Message-ID: <20150522172702.GC19834@io.lakedaemon.net>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
 <1432309875-9712-6-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432309875-9712-6-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47579
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

On Fri, May 22, 2015 at 04:51:04PM +0100, Paul Burton wrote:
> On Malta, some IRQs are still referenced by hardcoded numbers relative
> to MIPS_GIC_IRQ_BASE. When gic_init is called to register the GIC
> without using device tree the irqbase argument allows this base to be
> used. When the GIC is probed using device tree however the base is not
> specified. This leads to conflicts between the GIC interrupts and other
> interrupt controllers.
> 
> TODO: convert Malta (& SEAD3) to drop the hardcoded numbers instead

This will never be seen again. :-P  Why not just go ahead and do it as separate
patch(es) in this series?

thx,

Jason.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  drivers/irqchip/irq-mips-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 57f09cb..697f340 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -858,7 +858,7 @@ static int __init gic_of_init(struct device_node *node,
>  		write_gcr_gic_base(gic_base | CM_GCR_GIC_BASE_GICEN_MSK);
>  	gic_present = true;
>  
> -	__gic_init(gic_base, gic_len, cpu_vec, 0, node);
> +	__gic_init(gic_base, gic_len, cpu_vec, MIPS_GIC_IRQ_BASE, node);
>  
>  	return 0;
>  }
> -- 
> 2.4.1
> 
