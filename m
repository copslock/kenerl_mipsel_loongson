Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 14:28:06 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:50830 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990439AbeKINYqS81zY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2018 14:24:46 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E89CF68C73; Fri,  9 Nov 2018 14:24:40 +0100 (CET)
Date:   Fri, 9 Nov 2018 14:24:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Paul Burton <paul.burton@mips.com>, Christoph Hellwig <hch@lst.de>,
        linux-mips@linux-mips.org
Subject: Re: dma_pool broken on MIPS generic?
Message-ID: <20181109132440.GA12787@lst.de>
References: <20181109131014.GA29768@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109131014.GA29768@piout.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Fri, Nov 09, 2018 at 02:10:14PM +0100, Alexandre Belloni wrote:
> Hello,
> 
> I'm working on a (not yet upstreamed) dmaengine driver. While rebasing
> from v4.19 to v4.20-rc1, I saw that it is not working properly anymore
> because dma_pool is allocating descriptors in kseg0 which is cached
> while in v4.19, it was allocating them in kseg1.
> 
> Am I missing something to explicitely state that the cache is not dma
> coherent? How could I track this behaviour change?

You probably want this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?h=mips-fixes&id=d01501f85249848a2497968d46dd46d5c6fe32e6
