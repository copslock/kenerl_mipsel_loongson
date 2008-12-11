Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 11:17:33 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:16074 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24207669AbYLKLRX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Dec 2008 11:17:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBBBHKZ3016948;
	Thu, 11 Dec 2008 11:17:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBBBHJpM016946;
	Thu, 11 Dec 2008 11:17:19 GMT
Date:	Thu, 11 Dec 2008 11:17:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [Patch] MIPS: Add missing calls to plat_unmap_dma_mem.
Message-ID: <20081211111719.GA16924@linux-mips.org>
References: <49407795.9010208@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49407795.9010208@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 10, 2008 at 06:14:45PM -0800, David Daney wrote:

> It appears that dma_free_noncoherent() and dma_free_coherent() are
> missing calls to plat_unmap_dma_mem().  This patch adds them.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> This is split out from my OCTEON processor support patch at Ralf's
> request.

Because it's relevant to other processors supported in 2.6.28.

Patch applied.  Thanks!

  Ralf
