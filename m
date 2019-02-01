Return-Path: <SRS0=+ky4=QI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A47C282D8
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E57021726
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfBAQSX (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:18:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:40218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727042AbfBAQSX (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 11:18:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 925F1ABD4;
        Fri,  1 Feb 2019 16:18:21 +0000 (UTC)
Date:   Fri, 01 Feb 2019 17:18:21 +0100
Message-ID: <s5hwomj7a9e.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        iommu@lists.linux-foundation.org
Subject: Re: [alsa-devel] don't pass a NULL struct device to DMA API functions
In-Reply-To: <20190201160957.GD6532@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
        <s5ho97v8x9j.wl-tiwai@suse.de>
        <20190201160957.GD6532@lst.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, 01 Feb 2019 17:09:57 +0100,
Christoph Hellwig wrote:
> 
> On Fri, Feb 01, 2019 at 02:16:08PM +0100, Takashi Iwai wrote:
> > Actually there are a bunch of ISA sound drivers that still call
> > allocators with NULL device.
> > 
> > The patch below should address it, although it's only compile-tested.
> 
> Oh, I missed these "indirect" calls.  This looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

OK, merged this one to for-next branch now as well.


thanks,

Takashi

