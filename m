Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 00:11:59 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:53091 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493663AbZKYXL4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 00:11:56 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1NDR1c-0001Jn-00; Thu, 26 Nov 2009 00:11:52 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 619B4C225F; Thu, 26 Nov 2009 00:10:06 +0100 (CET)
Date:   Thu, 26 Nov 2009 00:10:06 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] Set of fixes for DMA when dma_addr_t != physical
        address
Message-ID: <20091125231006.GA12699@alpha.franken.de>
References: <20091125200027.GA13748@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091125200027.GA13748@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 03:00:28PM -0500, David VomLehn wrote:
> Fixes for using DMA on systems where the DMA address and the physical address
> differ.

what's the problem ? Even the old Olivetti M700 has an iommu, so dma
address and physical address are always different... and it works without
changes. You just need to tweak the plat_dma_XXX() macros/functions.

And I don't see a reason for the KSEG0 checks in your other patch,
but maybe I'm missing something...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
