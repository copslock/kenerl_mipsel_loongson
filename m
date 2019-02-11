Return-Path: <SRS0=yT8e=QS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2AC169C4
	for <linux-mips@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B95218A6
	for <linux-mips@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfBKNV7 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:21:59 -0500
Received: from verein.lst.de ([213.95.11.211]:56708 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfBKNV6 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 11 Feb 2019 08:21:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 388C868DD6; Mon, 11 Feb 2019 14:21:56 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:21:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: add config symbols for arch_{setup,teardown}_dma_ops
Message-ID: <20190211132156.GA22265@lst.de>
References: <20190204081420.15083-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204081420.15083-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Any chance to get a quick review on this small series?

On Mon, Feb 04, 2019 at 09:14:18AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds kconfig symbols to indicate that the architecture
> provides the arch_setup_dma_ops and arch_teardown_dma_ops hooks.
> 
> This avoids polluting dma-mapping.h which is included by just about
> every driver with implementation details, and also removes some
> clutter.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
