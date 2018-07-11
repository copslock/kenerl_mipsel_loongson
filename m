Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 08:56:43 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:33306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGKG4g4xImt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 08:56:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ePsF86RfBm9KlJk6HkO8sqsuPBV7pw/yT5/Pb12gx2Q=; b=jmCpiQATag3E6ZKwnA+yG3XCE
        qyrZ9/xJ1FUTfJHBlFNmi+HYZIRKx0kVuUZkV0DuhRn1LcBi8ZDAUClcN1Ay/+BKEaYp5BPRFv8AK
        pdD2vPVtJeI3Xzgdob5x/sESwHaf2MPvTaClEeZQtbyeWitP7rnJiD15Qi02VVoYi/c4uDXhssdB6
        c/R2fYvuF/CUHKJDMonZPMLXmQU29+nUwgehvHFoXEkrvlLgLipiXs/Owv3rA4UeX9Bh1UOGR4iSq
        U3AfSe3f7lqAg5rG2a34N2GibwDbJAO8JuO/V359f++5dsmm0Ecqqicj4CNqqprRlXuv3V9QZNwZr
        IrlQnKtEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fd939-0007vU-H0; Wed, 11 Jul 2018 06:56:31 +0000
Date:   Tue, 10 Jul 2018 23:56:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180711065631.GA21948@infradead.org>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709135713.8083-2-fancer.lancer@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7dae7aff98f6b03f0ec2+5435+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
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

> + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> + * requests a cachable mapping with CWB attribute enabled.
>   */
>  #define ioremap_cacheable_cow(offset, size)				\
>  	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)

This isn't actually used anywhere in the kernel tree.  Please remove it
as well.
