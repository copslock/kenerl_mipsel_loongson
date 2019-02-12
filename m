Return-Path: <SRS0=yn1R=QT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDB4C282CA
	for <linux-mips@archiver.kernel.org>; Tue, 12 Feb 2019 07:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF926206BA
	for <linux-mips@archiver.kernel.org>; Tue, 12 Feb 2019 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549957755;
	bh=O2k9bmmdFTZg7BuUpD/Q9NQyAfuud66qHKCVn7dB/lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=othU83oJwd3yoi1mMk+QcXYT6FaebBFZC7B3v1cjEcHzQZMuv2T2B/NWNn9oP9rjb
	 gKERLO7q11lEZpzn3eveeUbHXoCNl/YlcshZUR11raBikvg6WjuY6lFxOVkUMhcN+m
	 oUEiEGDFJxARjgJNS4bK46H/DU20F7A4ZmBqPqxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfBLHtK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfBLHtK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 12 Feb 2019 02:49:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A127206BA;
        Tue, 12 Feb 2019 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549957749;
        bh=O2k9bmmdFTZg7BuUpD/Q9NQyAfuud66qHKCVn7dB/lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJQEqW7G764qkL73kpifO1JPi72DeGSS+qRwnqx7uy0Z6bjfOPRQTCo70ihylEH0e
         zjYYN7+VSK4Vuy3hHU0LLvmNTYUjYTSdEX677p02Gmg12u9nfbsgZuK5LtPUC/f0sw
         gyqktOEOL1fkBBPXCt05+Y9NiqMQHG4UPCaeFx58=
Date:   Tue, 12 Feb 2019 08:49:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] device.h: dma_mem is only needed for
 HAVE_GENERIC_DMA_COHERENT
Message-ID: <20190212074906.GA5924@kroah.com>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211133554.30055-3-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Feb 11, 2019 at 02:35:44PM +0100, Christoph Hellwig wrote:
> No need to carry an unused field around.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/device.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
