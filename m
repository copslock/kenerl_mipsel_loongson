Return-Path: <SRS0=3e6j=WM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69CFC3A59D
	for <linux-mips@archiver.kernel.org>; Fri, 16 Aug 2019 17:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FF220665
	for <linux-mips@archiver.kernel.org>; Fri, 16 Aug 2019 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfHPR7r (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:59:47 -0400
Received: from verein.lst.de ([213.95.11.211]:57164 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfHPR7r (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 16 Aug 2019 13:59:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94E9A68B05; Fri, 16 Aug 2019 19:59:42 +0200 (CEST)
Date:   Fri, 16 Aug 2019 19:59:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Guan Xuetao <gxt@pku.edu.cn>,
        Shawn Anastasio <shawn@anastas.io>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: document the choice of page attributes for
 pgprot_dmacoherent
Message-ID: <20190816175942.GA4879@lst.de>
References: <20190816070754.15653-1-hch@lst.de> <20190816070754.15653-7-hch@lst.de> <20190816173118.4rbbzuogfamfa554@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816173118.4rbbzuogfamfa554@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Aug 16, 2019 at 06:31:18PM +0100, Will Deacon wrote:
> Mind if I tweak the second sentence to be:
> 
>   This is different from "Device-nGnR[nE]" memory which is intended for MMIO
>   and thus forbids speculation, preserves access size, requires strict
>   alignment and can also force write responses to come from the endpoint.
> 
> ? It's a small change, but it better fits with the arm64 terminology
> ("strongly ordered" is no longer used in the architecture).
> 
> If you're happy with that, I can make the change and queue this patch
> for 5.4.

I'm fine with the change, but you really need this series as base,
as there is no pgprot_dmacoherent before the series.  So I think I'll
have to queue it up if we want it for 5.4, and I'll need a few more
reviews for the other patches in this series first.
