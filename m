Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 18:00:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8673 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20032179AbYGKRAT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 18:00:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6BFPDJB028197;
	Fri, 11 Jul 2008 16:25:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6BFPCa3028196;
	Fri, 11 Jul 2008 16:25:12 +0100
Date:	Fri, 11 Jul 2008 16:25:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] txx9: Make single kernel can support multiple
	boards
Message-ID: <20080711152512.GA15391@linux-mips.org>
References: <20080711.232754.07644442.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080711.232754.07644442.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2008 at 11:27:54PM +0900, Atsushi Nemoto wrote:

> Make single kernel can be used on RBTX4927/37/38.  Also make
> some SoC-specific code independent from board-specific code.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, queued 2.6.27.

  Ralf
