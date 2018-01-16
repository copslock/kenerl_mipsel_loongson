Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 08:53:00 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:56766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeAPHwtjkBuV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 08:52:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d6f4S39rfOVMPAg7fsXfVzXoNMyuiW6xwKdo+R9yujc=; b=KVUUoa5NSH0udyu5aWbt5c8Eh
        8mr+u5EFfRfwku9B2Xz5iBJXPIKpyPQlZiG6bm+vlghr8oPUaq/smfUtmuoUqHwb79SmMVRJrS6ur
        1KNWDpee10R0oCAh5jf1WE0zKz0hfdEOPH1+5LSdE9uhLJY8n+pFpTunp3ITjQJ+P8LDbXIC5jfqZ
        mXOWBohIlytYVoS+uYbeOljfyOiSiUM9pIDUouK07Si32OUr706lzGHKBoYHBqyav24h09NONhL3k
        uGhzeDURUW1nZysuKYE2eVdSTq9opo/mxR9iRzW1EB2vbEr+iIzPUDuZJSW25AE8AhOI0yIcMZuD4
        CDRzRLxJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.89 #1 (Red Hat Linux))
        id 1ebM31-0003dd-C3; Tue, 16 Jan 2018 07:52:43 +0000
Date:   Mon, 15 Jan 2018 23:52:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: consolidate direct dma mapping V4
Message-ID: <20180116075243.GA12693@infradead.org>
References: <20180112084232.2857-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+a44557d646e720d5a26d+5259+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62156
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

I've pulled this into the dma-mapping for-next branch so that we get
a few days exposure before then end of the merge window.  If there is
anything important (e.g. the powerpc naming issue) please send
incremental patches.
