Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40385C282D7
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 10:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D8620870
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549102380;
	bh=V67/DR7kBa7CON0ew0ooSzTXzjEuFwcNUbYDLjGH7dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ND/BX9WWT+CRm4F3Fv7fexXHo601dEEdRKYOvWgCiQX3xpS389Ih8cr1UuxC1plMU
	 UdzM1HZ8tREyEJdpyBhTgHb86pz+TaI7kCQiOkIklNiLPlhy9foYxi5iFyDmTss+Lv
	 SVtPWNDnJ4sgMOEWn7aiwewqO7L+pMJ2wcWAhH14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfBBKMw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfBBKMw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 2 Feb 2019 05:12:52 -0500
Received: from localhost (unknown [125.16.100.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 861E820870;
        Sat,  2 Feb 2019 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549102371;
        bh=V67/DR7kBa7CON0ew0ooSzTXzjEuFwcNUbYDLjGH7dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPuV6ltu4Lj3zjCnvwB/17WBfxQjIFVGDAu6GC749dxKfkvO8+cNTekE24McxIAbe
         kIoUExnO86UuM3MxpnaSUbINeNw31OkgT5NeYVQ8wRVeSfNNj9WVu080T4jznw0N+Z
         H53omImB0vvYnZ47dLdCzrPlcETPo8cTdIzRs6n0=
Date:   Sat, 2 Feb 2019 15:41:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Crispin <john@phrozen.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 02/18] dmaengine: imx-sdma: pass struct device to DMA API
 functions
Message-ID: <20190202101121.GE4296@vkoul-mobl>
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201084801.10983-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 01-02-19, 09:47, Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.

This looks good to me but fails to apply. Can you please base it on
dmaengine-next or linux-next please and resend

Thanks
-- 
~Vinod
