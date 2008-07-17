Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2008 16:54:37 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:63947
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28585319AbYGQPyf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2008 16:54:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6HFsWpR004534;
	Thu, 17 Jul 2008 16:54:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6HFsVuS004532;
	Thu, 17 Jul 2008 16:54:31 +0100
Date:	Thu, 17 Jul 2008 16:54:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] txx9: miscellaneous build fixes
Message-ID: <20080717155431.GA4340@linux-mips.org>
References: <20080718.004348.41011911.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080718.004348.41011911.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 18, 2008 at 12:43:48AM +0900, Atsushi Nemoto wrote:

> * Fix build if only RBTX4927 or RBTX4938 was selected.
> * Move gpio helpers to generic part.
> * Select SOC_TX4938 for RBTX4927/37 board.
> * Fix parent of rbtx4938_fpga_resource.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, applied.

  Ralf
