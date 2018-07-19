Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2018 05:57:09 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeGSD5EX7VmX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Jul 2018 05:57:04 +0200
Received: from localhost (unknown [106.201.102.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8DE92084C;
        Thu, 19 Jul 2018 03:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531972617;
        bh=I6Glwk2YbAnTo9IMLqE86xgDfEa2NcFxsAv2v3GiuaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LC/YVAk3IoSqb4KxRqS3Rukihq8/Gu5VbNRxdiHhzuzWnG5ctOSvBofDxGSOjfJgJ
         uDRzYk37+8wqOnJUgUUf2zEQkj3395gUTR34VHHPHE236l382VAX8KaUMgGlEFh4n+
         hQzXf+Q53X4s2xbKyTRE4RKkJ4VsVMQr0SggvI1U=
Date:   Thu, 19 Jul 2018 09:26:49 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 00/17] JZ4780 DMA patchset v2
Message-ID: <20180719035649.GI3219@vkoul-mobl>
References: <20180718182023.8182-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64940
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

On 18-07-18, 20:20, Paul Cercueil wrote:
> Hi,
> 
> This is the version 2 of my jz4780-dma driver update patchset.

why is this not send to dmaengine mailing list? Please post on that as
well

> 
> Changelog:
> 
> - All documentation changes have been moved to one single patch [01/17].
> 
> - The new patch [02/17] enforces that we're probed from devicetree.
> 
> - The driver will not fail if only one memory resource has been supplied
>   in the devicetree, to keep compatibility with old devicetree files.
> 
> - A new patch [17/17] adds a devicetree node for the DMA driver in the
>   JZ4740 DTS file.
> 
> - Some other small changes; see per-file changelog.
> 
> Regards,
> -Paul

-- 
~Vinod
