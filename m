Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 15:54:27 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:34592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994059AbeHBNyY7SHwi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2018 15:54:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ct+JzfM6bhDwHg8E6m9mKmvGxLELOEgOksF82AxYn+E=; b=Cuy+9xn2E5TqvLVr2fO6NeBmB
        i5Ac1JkNa0ssox0VWawnWx7x59LVr7JnTh/Rikd+FFgif8XQcJjt1M4mtjszYAob+UrER2Uu7OdvM
        CMhrLrSyOYs3BXswXKR8I4U12xc1N2TF0YCE35Q10m+YyRLUQGdG5UE3tkikrPFi0CnG4lL1Hx9q4
        s9SFmkNv8mJJ/8ezobeSHv/dyijCHAt+xISwemH71yNYDoTCKMU13+pDHCIqRgDpLAfHhBsEch3WT
        u1w0zikrMyw9HEU7C0tdKnE3mhsrmNMhRqLaO1KAvGxqcLZniQqDu8eCbul9goWBrzf8OrZA80y2Q
        dtICiawng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flE3Z-0003a5-59; Thu, 02 Aug 2018 13:54:21 +0000
Date:   Thu, 2 Aug 2018 06:54:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexei Colin <acolin@isi.edu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, alex.bou9@gmail.com,
        Christoph Hellwig <hch@infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jwalters@isi.edu, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180802135421.GA13512@infradead.org>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
 <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
 <20180802134544.GG38497@guest228.east.isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802134544.GG38497@guest228.east.isi.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+60c7bee3dfeef1f96717+5457+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65354
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

On Thu, Aug 02, 2018 at 09:45:44AM -0400, Alexei Colin wrote:
> If I move RapidIO option to drivers/Kconfig, then it won't appear under
> the Bus Options/System Support menu, along with other choices for the
> system bus (PCI, PCMCIA, ISA, TC, ...).

It's not like anyone cares.  And FYI, moving all those to
drivers/Kconfig is osmething I will submit for the next merge window.

> Alex explains above that RapidIO
> may be selected as a system bus on some architectures, and users expect
> it to be in the menu in which it has been for some time now.  What
> problem is the current organization causing?

A "system bus" seems like a rather outdated concept to start with.
