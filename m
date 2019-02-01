Return-Path: <SRS0=+ky4=QI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC60EC282D8
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 13:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C4720863
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 13:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfBANMs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:12:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:37502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfBANMs (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 08:12:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55521ACA9;
        Fri,  1 Feb 2019 13:12:46 +0000 (UTC)
Date:   Fri, 01 Feb 2019 14:12:45 +0100
Message-ID: <s5hr2cr8xf6.wl-tiwai@suse.de>
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
Subject: Re: [alsa-devel] [PATCH 17/18] ALSA: hal2: pass struct device to DMA   API functions
In-Reply-To: <20190201084801.10983-18-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
        <20190201084801.10983-18-hch@lst.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, 01 Feb 2019 09:48:00 +0100,
Christoph Hellwig wrote:
> 
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me:
  Reviewed-by: Takashi Iwai <tiwai@suse.de>

Shall I take this one through sound git tree or all through yours?


thanks,

Takashi
