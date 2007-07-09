Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 15:19:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38088 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022197AbXGIOTW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 15:19:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l69EBYR1000472;
	Mon, 9 Jul 2007 15:11:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l69EBXNk000471;
	Mon, 9 Jul 2007 15:11:33 +0100
Date:	Mon, 9 Jul 2007 15:11:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rbtx4938: Provide minimum CLK API implementation
Message-ID: <20070709141133.GA32099@linux-mips.org>
References: <20070707.235720.92586759.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070707.235720.92586759.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 07, 2007 at 11:57:20PM +0900, Atsushi Nemoto wrote:

> 
> Implement a minimum CLK API to pass a base clock to spi_txx9 driver.
> This patch also remove old hack (abusing resource framework) which was
> only for preliminary version of the spi_txx9 driver.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch can be folded into a patch in linux-queue tree titled:
> "[MIPS] rbtx4938: Convert SPI codes to use generic SPI drivers"

Commited separately for lmo, folded into the other patch for Linus.

  Ralf
