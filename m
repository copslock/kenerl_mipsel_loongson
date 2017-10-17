Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 10:24:25 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:47564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdJQIYR7c90c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 10:24:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O0B3cEvbEJNvcTWsPWZY1HCdu/h5Q+e1F7ccz0HPZQU=; b=kwrigdNCtUX6bGKhX22+vfaur
        sKCWKeNr9kdXzNDLhfg2H3ybF2oIamKwDgo5fZrv5VwPyaBgaJ0mnMrdXYhovzAqyHVRlgSO1twyh
        khTZORSaJyq8D60M8Rm6NTjCxoBpkHTCY+YRjFHb+ot5DJi/T1olZtc5sdtwYykq/35h14A7FVs4w
        y5ElcWYihMWa6wzBqeEo2kBy80NdLOvgDdxccHHReQCIO3FRARNbP44/jk6NCoBZ0ueunj6u6VX49
        wVG/4eBCh0EHCJXII5Y8v8Th9cTwFxf4saoimisU3Vix971YbZEtcOh0Kld/WkDT7i8cQkz48OPqo
        dycrCXkEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1e4NAb-0000Ou-A7; Tue, 17 Oct 2017 08:24:13 +0000
Date:   Tue, 17 Oct 2017 01:24:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 1/9] SOC: brcmstb: add memory API
Message-ID: <20171017082413.GA10574@infradead.org>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+60eda6e2277543397899+5168+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
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

> +/* Macros to help extract property data */
> +#define U8TOU32(b, offs) \
> +	((((u32)b[0 + offs] << 0)  & 0x000000ff) | \
> +	 (((u32)b[1 + offs] << 8)  & 0x0000ff00) | \
> +	 (((u32)b[2 + offs] << 16) & 0x00ff0000) | \
> +	 (((u32)b[3 + offs] << 24) & 0xff000000))

Please us helpers like get_unaligned_le32 instead opencoding them.

> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(U8TOU32(b, offs)))

And together with this it looks really whacky.  So you're converting
from le to native first and then do another conversion from be to cpu?

Something doesn't work out here.

> +/* -------------------- Functions -------------------- */

Please remove pointless comments like this one.

> +
> +/*
> + * If the DT nodes are handy, determine which MEMC holds the specified
> + * physical address.
> + */
> +#ifdef CONFIG_ARCH_BRCMSTB
> +int __brcmstb_memory_phys_addr_to_memc(phys_addr_t pa, void __iomem *base)

Please move this into the arm arch code.

> +#elif defined(CONFIG_MIPS)

And this into the mips arch code.

> +EXPORT_SYMBOL(brcmstb_memory_phys_addr_to_memc);

> +EXPORT_SYMBOL(brcmstb_memory_memc_size);

Why is this exported?
