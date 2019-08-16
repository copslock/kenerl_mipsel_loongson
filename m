Return-Path: <SRS0=3e6j=WM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71479C3A59D
	for <linux-mips@archiver.kernel.org>; Fri, 16 Aug 2019 18:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1ED206C1
	for <linux-mips@archiver.kernel.org>; Fri, 16 Aug 2019 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565978729;
	bh=ATa8fe0CxhAbQASCjl6IYhzQjKdSYeQNhdmBcA2ZRlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=URs5X4geDyFLS2vC5kaHwUiGmHMgRi9gUAghvPWm/OpRTARFFacrG/2rjunkIH25p
	 6zF2W3XUxP54vaGBzT0DUHuF8JHySKW1D2xlpcbLDhnjYAcfPoU65S3Mdx///p/e4Q
	 omxj0eV8tgaChtAzoIGZxAqTrKkOh0+lFjbtuELU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfHPSF3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfHPSF2 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 16 Aug 2019 14:05:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7830C20665;
        Fri, 16 Aug 2019 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565978727;
        bh=ATa8fe0CxhAbQASCjl6IYhzQjKdSYeQNhdmBcA2ZRlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yclaVWCYpQyvh9OaGQPrYfiMYsvcW/o5PkOIV7eQUmhstIzpx2ZZ0sSjiKcxqnMgv
         7z+Jikxzq4/ZIHpHnEO2nuFXbcvpn1v46HdwXjYNwayNZxp8x1aicBOflxg1CSeLTk
         vayH5O/ix+LVeWKI9G785+H8RXwq5z7rEAqzMsfo=
Date:   Fri, 16 Aug 2019 19:05:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, Guan Xuetao <gxt@pku.edu.cn>,
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
Message-ID: <20190816180522.gocqeayajlbu4gzp@willie-the-truck>
References: <20190816070754.15653-1-hch@lst.de>
 <20190816070754.15653-7-hch@lst.de>
 <20190816173118.4rbbzuogfamfa554@willie-the-truck>
 <20190816175942.GA4879@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816175942.GA4879@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Aug 16, 2019 at 07:59:42PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 16, 2019 at 06:31:18PM +0100, Will Deacon wrote:
> > Mind if I tweak the second sentence to be:
> > 
> >   This is different from "Device-nGnR[nE]" memory which is intended for MMIO
> >   and thus forbids speculation, preserves access size, requires strict
> >   alignment and can also force write responses to come from the endpoint.
> > 
> > ? It's a small change, but it better fits with the arm64 terminology
> > ("strongly ordered" is no longer used in the architecture).
> > 
> > If you're happy with that, I can make the change and queue this patch
> > for 5.4.
> 
> I'm fine with the change, but you really need this series as base,
> as there is no pgprot_dmacoherent before the series.  So I think I'll
> have to queue it up if we want it for 5.4, and I'll need a few more
> reviews for the other patches in this series first.

Ah, I didn't think about the contextual stuff. In which case, with my
change in wording:

Acked-by: Will Deacon <will@kernel.org>

and feel free to route it with the rest.

Thanks,

Will
