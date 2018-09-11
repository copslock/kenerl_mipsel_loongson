Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 09:30:11 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990947AbeIKHaInd0O4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 09:30:08 +0200
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6AA20865;
        Tue, 11 Sep 2018 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536651002;
        bh=2ADZAPA+oOEOKQA5tW1u/Y95m+EabwiGs8TtKaRMAeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebTtlnHiECsYWtz8LVq4xtXzjNXCdKi6CeuDCB6k0PzyryReOAccPFAnJ33z5jN1n
         4U/4ObxrF8TYDAyTeJhZ6HWPhlapfVonDNoX7aK5m70nKvzlCk4GpzMA9QRWnyPaqU
         GEhcRwFPurz19DrzgmJpgmoPpUdB+u/8dVbTiV2E=
Date:   Tue, 11 Sep 2018 12:59:52 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 00/18] JZ4780 DMA patchset v5
Message-ID: <20180911072952.GJ2634@vkoul-mobl>
References: <20180829213300.22829-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66197
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

On 29-08-18, 23:32, Paul Cercueil wrote:
> Hi Vinod,
> 
> This is the V5 of my Ingenic JZ4780 DMA patchset.

Applied all, thanks

> 
> - Patch [01/18] dropped the "doc:" in the patch title;
> - Patches [11/18] and [12/18] now use the GENMASK() macro.
> - The rest is untouched.
> 
> Thanks,
> -Paul Cercueil

-- 
~Vinod
