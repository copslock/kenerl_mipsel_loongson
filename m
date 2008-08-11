Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2008 15:43:07 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:31707
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20029352AbYHKOm6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2008 15:42:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7BEgqZU029841;
	Mon, 11 Aug 2008 15:42:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7BEgp52029839;
	Mon, 11 Aug 2008 15:42:51 +0100
Date:	Mon, 11 Aug 2008 15:42:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org,
	Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH] kgdb: Do not call fixup_exception
Message-ID: <20080811144251.GA29441@linux-mips.org>
References: <20080811.230535.25909452.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080811.230535.25909452.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 11, 2008 at 11:05:35PM +0900, Atsushi Nemoto wrote:

> kgdb_mips_notify is called on IBE/DBE/FPE/BP/TRAP/RI exception.  None
> of them need fixup.  And doing fixup for a breakpoint exception will
> confuse gdb.

Thanks, applied.

  Ralf
