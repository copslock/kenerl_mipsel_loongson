Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 21:45:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52868 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021785AbXGaUpf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 21:45:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6VKjXKf022113;
	Tue, 31 Jul 2007 21:45:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6VKjWEB022112;
	Tue, 31 Jul 2007 21:45:32 +0100
Date:	Tue, 31 Jul 2007 21:45:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Songmao Tian <tiansm@lemote.com>
Cc:	Dajie Tan <jiankemeng@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] 16K page size in 32 bit kernel
Message-ID: <20070731204532.GA22036@linux-mips.org>
References: <20070731130950.GA5540@sw-linux.com> <20070731100027.GA3983@linux-mips.org> <46AF3DEE.2080603@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46AF3DEE.2080603@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 31, 2007 at 09:49:34PM +0800, Songmao Tian wrote:

> I think the following is more complete?
> 
> #ifdef CONFIG_64BIT_PHYS_ADDR
> -#define PGDIR_SHIFT    21
> +#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
> #else
> -#define PGDIR_SHIFT    22
> +#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 2))
> #endif

Better suggestion :-)

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 2fbd47e..ff29485 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -43,11 +43,7 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
  */
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
-#ifdef CONFIG_64BIT_PHYS_ADDR
-#define PGDIR_SHIFT	21
-#else
-#define PGDIR_SHIFT	22
-#endif
+#define PGDIR_SHIFT	(2 * PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2)
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
