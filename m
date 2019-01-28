Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96985C282C8
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 13:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685122147A
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 13:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uybvqRG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfA1NcT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:32:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NcT (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 28 Jan 2019 08:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4ZjZnOAgjiXuKywopYQDLkYsV0TGR9HGtqPzaU9bP+k=; b=uybvqRG3vAjaT5cw0GX+QrkCx
        Lj2StEdZXvz/Lx+iCR4YXbHjaO1bI0eVp8MzlczGUuBRaXlQelY1A0l/x6cR7ONePT7g2QypckQEs
        gVZ1l0driMN2bexY8/1YNf81GoRzrVGZdHuvGQzHHkj78bchix/Lzzji2vW+WRsty6dnstmImyGXP
        epJrTVxjOUMGN+a/pyxiis8OwcDfBERTpfFXC34xceQJ/dRug4gi+/v3sQzruRZRE6UUuRAhZ4kv0
        VlG/LMEzJdIrWoxhcUJTZFckYJ/5GPDseGEczBMfYBBd0+z1lpy+R8Vqo94D+eoD+8d5ZggoVopl8
        TGb0xeMsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go71L-0001Iy-5f; Mon, 28 Jan 2019 13:32:15 +0000
Date:   Mon, 28 Jan 2019 05:32:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: SGI-IP27: use generic PCI driver
Message-ID: <20190128133215.GC744@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-7-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124174728.28812-7-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Jan 24, 2019 at 06:47:27PM +0100, Thomas Bogendoerfer wrote:
> Converted bridge code to a platform driver using the PCI generic driver
> framework and use adding platform devices during xtalk scan. This allows
> easier sharing bridge drvier for other SGI platforms like IP30 (Octane) and

Typo: s/drvier/driver/.

In theory this would also have allowed sharing the code with ia64/SN,
except that instead of porting the old mess to Linux 2.6 and cleaning it
up SGI moved the support into the firmware hidden behind PAL calls :(

> +#ifdef CONFIG_NUMA
> +int pcibus_to_node(struct pci_bus *bus)
> +{
> +	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
> +
> +	return bc->nasid;
> +}
> +EXPORT_SYMBOL(pcibus_to_node);
> +#endif /* CONFIG_NUMA */

From an abstraction point of view this doesn't really belong into
a bridge driver as it is a global exported function.  I guess we can
keep it here with a fixme comment, but we should probably move this
into a method call instead.

> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
> +
> +	return bc->baddr + paddr;
> +}
> +
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> +{
> +	return dma_addr & ~(0xffUL << 56);
> +}

Similarly here - these are global platform-wide hooks, so having them
in a pci bridge driver is not the proper abstraction level.

Note that we could probably fix these by just switching IP27 and
other users of the bridge chip to use the dma_pfn_offset field
in struct device and stop overriding these functions.
