Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 23:49:29 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:25545
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022246AbYHZWt1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 23:49:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7QMnHwH018222;
	Tue, 26 Aug 2008 23:49:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7QMnGt0018220;
	Tue, 26 Aug 2008 23:49:16 +0100
Date:	Tue, 26 Aug 2008 23:49:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] e100: Add missing dma sync for proper operation with
	non-coherent caches.
Message-ID: <20080826224916.GB8838@linux-mips.org>
References: <48B3A8D0.2040108@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48B3A8D0.2040108@avtrex.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 25, 2008 at 11:55:12PM -0700, David Daney wrote:

> I am running the e100 driver on a MIPS 4KEc system (32 bit mips with
> non-coherent DMA).  There was a problem where received packets would
> get 'stuck' for several seconds at a time and then be released all at
> once.
> 
> The cause was that if an interrupt were received when no RX packets
> were available, the status for the receive buffer would be stuck in
> the cache, so when the next interrupt arrived the old status value was
> read (indicating no packets available) instead of the new value.
> 
> The fix is to call pci_dma_sync_single_for_device on the RX if the
> packet is not available to invalidate the cache so that at the next
> interrupt valid status is returned.
> 
> The driver currently calls pci_dma_sync_single_for_cpu before reading
> the status, and this is indeed needed for cases like the R10000 CPU
> where the cache can be polluted by speculative execution, but for most
> machines it is a nop.
> 
> The patch was tested on 2.6.17-rc4 on a MIPS 4KEc.
> 
> Signed-off-by: David Daney <ddaney@avtrex.com>

Makes sense to me.

Reviewed-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
