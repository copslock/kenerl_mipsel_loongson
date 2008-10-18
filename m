Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2008 12:02:25 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:33963 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21781222AbYJRLCS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Oct 2008 12:02:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9IB2Dxm020984;
	Sat, 18 Oct 2008 12:02:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9IB2B93020982;
	Sat, 18 Oct 2008 12:02:11 +0100
Date:	Sat, 18 Oct 2008 12:02:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Don't unmap the memory for dma_sync*.
Message-ID: <20081018110211.GA17322@linux-mips.org>
References: <48F93275.8010305@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48F93275.8010305@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 17, 2008 at 05:48:53PM -0700, David Daney wrote:

> Don't unmap the memory for dma_sync*.
>
> This must have been typo, it cannot have been correct.

Interesting ...

We were getting away with this for so long only because the only platform
(Jazz) with a non-empty plat_unmap_dma_mem() doesn't call
dma_sync_sg_for_cpu() and dma_sync_sg_for_device() from its commonly used
drivers.

  Ralf
