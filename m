Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 10:10:20 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.236]:58734 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021603AbXGaJKR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 10:10:17 +0100
Received: by qb-out-0506.google.com with SMTP id z1so1692969qbc
        for <linux-mips@linux-mips.org>; Tue, 31 Jul 2007 02:09:59 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=JbShXYIrQPJLDgF9uhEKYZUcgtKUjZH+oQxZlRF01os42NjQ/dKiryyUvUXBhizrtNR4dJMhhUOauC1VIalVaiJ/0+OyBWzN0kDIAzmk8hCSRmsxD8eWkJ3qWHNBItlomifo3w3C28UtZJ8JUZYpaxUvyeCCCHQM052XKhnVQSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=CotNTZ2BoqGw9nlHA1A3JYk4fPqiid3AB+Btlhe2SpLX7bhVjVMoDe4HK+Lw3iTTK1ClLM4eU4QtElQFbYOZT+3PGfbXew7Ut52U4qATSKOgGKpX82uGp8X1Mx4Q/+LRiildYR8dlKcxt+pVbFlzxoNH/maCzJWLbGw9pbXHusg=
Received: by 10.141.70.18 with SMTP id x18mr2130942rvk.1185872998733;
        Tue, 31 Jul 2007 02:09:58 -0700 (PDT)
Received: from dajietan.caozhai.com ( [58.213.112.151])
        by mx.google.com with ESMTPS id c19sm6637008rvf.2007.07.31.02.09.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 02:09:58 -0700 (PDT)
Received: from comcat by dajietan.caozhai.com with local (Exim 4.54)
	id 1IFrTz-0001U3-7i; Tue, 31 Jul 2007 17:09:51 +0400
Date:	Tue, 31 Jul 2007 17:09:51 +0400
From:	Dajie Tan <jiankemeng@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] 16K page size in 32 bit kernel
Message-ID: <20070731130950.GA5540@sw-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips


32-bit Kernel for loongson2e currently use 16KB page size to avoid
cache alias problem.So, the definiton of PGDIR_SHIFT muse be 12+14.

Using 22 in 16K page size do not lead to a serious problem but the number
of pages allocated for page table is more than previous. (cat
/proc/vmstat | grep nr_page_table_pages)

It's been tested on FuLong mini PC(loongson2e inside).


Signed-off-by: Dajie Tan <jiankemeng@gmail.com>
---
 include/asm-mips/pgtable-32.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 2fbd47e..8d34ebf 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -46,7 +46,7 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 #ifdef CONFIG_64BIT_PHYS_ADDR
 #define PGDIR_SHIFT	21
 #else
-#define PGDIR_SHIFT	22
+#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 2))
 #endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
