Return-Path: <SRS0=+ky4=QI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED46C282D8
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5905321872
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 16:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfBAQKs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:10:48 -0500
Received: from verein.lst.de ([213.95.11.211]:35652 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQKs (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 11:10:48 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 99C4F68D93; Fri,  1 Feb 2019 17:10:45 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:10:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 03/18] net: caif: pass struct device to DMA API
 functions
Message-ID: <20190201161045.GF6532@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-4-hch@lst.de> <1cafba51-b652-5457-0dd7-77d64264c85e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cafba51-b652-5457-0dd7-77d64264c85e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Feb 01, 2019 at 01:53:09PM +0000, Robin Murphy wrote:
>>   #define LOW_WATER_MARK   100
>>   #define HIGH_WATER_MARK  (LOW_WATER_MARK*5)
>>   -#ifdef CONFIG_UML
>> +#ifdef CONFIG_HAS_DMA
>
> #ifndef, surely?

Indeed.
