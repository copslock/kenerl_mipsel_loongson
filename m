Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 15:39:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994002AbeGXNjIZx1Z0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 15:39:08 +0200
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2366320856;
        Tue, 24 Jul 2018 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532439541;
        bh=ylxtXLVvwtlpzb8b+tTvZU0wnCxSID82NoRNGtR9hzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkEX17j+jvvXZw6+HyoNxTGjblAEZBwctG2bffIUUYk7gNkFN7VC+1653xO/9j22l
         UYPXGlLBXALoUa7rVHioBtNVQiVo2dvjfUbS0pYn2gZt3L7USA7v02CDaFFpcQfLMm
         a+RIOjam1d63lXfmwao5MLHut1FmF9idkm9lwvDQ=
Date:   Tue, 24 Jul 2018 19:08:53 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 11/18] dmaengine: dma-jz4780: Add missing residue DTC
 mask
Message-ID: <20180724133853.GH3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721110643.19624-12-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vkoul@kernel.org
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

On 21-07-18, 13:06, Paul Cercueil wrote:
> From: Daniel Silsby <dansilsby@gmail.com>
> 
> The 'dtc' word in jz DMA descriptors contains two fields: The
> lowest 24 bits are the transfer count, and upper 8 bits are the DOA
> offset to next descriptor. The upper 8 bits are now correctly masked
> off when computing residue in jz4780_dma_desc_residue(). Note that
> reads of the DTCn hardware reg are automatically masked this way.
> 
> Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
> Tested-by: Mathieu Malaterre <malat@debian.org>

This needs your s-o-b. Please see Documentation/process/submitting-patches.rst

I think Randy did flag this one some other patch as well. All the
patches need to be signed off by sender as well

-- 
~Vinod
