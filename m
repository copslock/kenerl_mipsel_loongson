Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 13:57:19 +0100 (CET)
Received: from bombadil.infradead.org ([IPv6:2001:1868:205::9]:59772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992279AbdAIM5L1A3Kj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 13:57:11 +0100
Received: from hch by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1cQZV8-0004MT-QS; Mon, 09 Jan 2017 12:56:38 +0000
Date:   Mon, 9 Jan 2017 04:56:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net
Subject: Re: [PATCH v2 7/7] uapi: export all headers under uapi directories
Message-ID: <20170109125638.GA15506@infradead.org>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+346223d864736513bcc6+4887+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56231
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

On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
> Regularly, when a new header is created in include/uapi/, the developer
> forgets to add it in the corresponding Kbuild file. This error is usually
> detected after the release is out.
> 
> In fact, all headers under uapi directories should be exported, thus it's
> useless to have an exhaustive list.
> 
> After this patch, the following files, which were not exported, are now
> exported (with make headers_install_all):

... snip ...

> linux/genwqe/.install
> linux/genwqe/..install.cmd
> linux/cifs/.install
> linux/cifs/..install.cmd

I'm pretty sure these should not be exported!
