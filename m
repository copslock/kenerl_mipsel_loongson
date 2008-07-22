Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2008 18:10:14 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:48805
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28575478AbYGVRKL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2008 18:10:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6MHA84t000458;
	Tue, 22 Jul 2008 18:10:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6MHA6MB000457;
	Tue, 22 Jul 2008 18:10:06 +0100
Date:	Tue, 22 Jul 2008 18:10:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Julia Lawall <julia@diku.dk>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] : Add local_irq_restore in error handling code
Message-ID: <20080722171006.GA32742@linux-mips.org>
References: <Pine.LNX.4.64.0807221844250.2670@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807221844250.2670@ask.diku.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Julia,

On Tue, Jul 22, 2008 at 06:44:48PM +0200, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> There is a call to local_irq_restore in the normal exit case, so it would
> seem that there should be one on an error return as well.
> 
> The semantic patch that makes this change is as follows:
> (http://www.emn.fr/x-info/coccinelle/)

Correctly spotted - but I decieded to go for below patch instead.

Thanks,

  Ralf

From: Ralf Baechle <ralf@linux-mips.org>

[MIPS] tlb-r4k: Nuke broken paranoia error test.

Bug originally found and reported by Julia Lawall <julia@diku.dk>.  I
decieded that the whole error check was mostly useless paranoia and should
be discarded.  It would only ever trigger if r3k_have_wired_reg has a wrong
value.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index a782549..f0cf46a 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -246,10 +246,6 @@ void __init add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 		old_pagemask = read_c0_pagemask();
 		w = read_c0_wired();
 		write_c0_wired(w + 1);
-		if (read_c0_wired() != w + 1) {
-			printk("[tlbwired] No WIRED reg?\n");
-			return;
-		}
 		write_c0_index(w << 8);
 		write_c0_pagemask(pagemask);
 		write_c0_entryhi(entryhi);
