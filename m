Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 17:10:27 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:59492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeGUPKWzQGmy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 17:10:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=++q495uVSzoG0HIPuX0lHaqiTw4orANcgknxNynbXWo=; b=aErXGL/P4c1sCABTmU9PVPJXG
        uHhIx1MMq/4kxIdjiRF0aPB1bh+JudTyg4uXsvTIWnk5lm2KCDi2P8xmXuFUa0pdyY5S48MgkAvNc
        hVuRqda4tnLgR2evFLRoXPpUWNDYfAJc2QDqEy+zAj6Aapm/0jn0T8GGAsWQ6X1kmTKX6xHqr9Ofo
        jAx1LUEh/8T72i32LW0cm0VDefGS2V93Cq4QbWl14gcczH5qVVK6ADFxZU+AWlA4Qd+OiBcEsP9IV
        4azFGDMi9tMWQaNiA81OYIQyKtLOWICNPHxb/LicLRc9vMQvi4fPsphis+f1g+F62tIqjH1N51eXH
        k7hXyb8bg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgtWV-0001PN-Lj; Sat, 21 Jul 2018 15:10:19 +0000
Subject: Re: [PATCH v3 13/18] dmaengine: dma-jz4780: Set DTCn register
 explicitly
To:     Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-14-paul@crapouillou.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bd06e477-a253-48f2-2b3e-dc48b2a12841@infradead.org>
Date:   Sat, 21 Jul 2018 08:10:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721110643.19624-14-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 07/21/2018 04:06 AM, Paul Cercueil wrote:
> From: Daniel Silsby <dansilsby@gmail.com>
> 
> Normally, we wouldn't set the channel transfer count register directly
> when using descriptor-driven transfers. However, there is no harm in
> doing so, and it allows jz4780_dma_desc_residue() to report the correct
> residue of an ongoing transfer, no matter when it is called.
> 
> Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/dma/dma-jz4780.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Hi,

Documentation/process/submitting-patches.rst says:

The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.

That means that patches that are from Daniel but you send (delivery path)
should also be Signed-off-by: you.


-- 
~Randy
