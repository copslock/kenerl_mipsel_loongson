Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 00:49:03 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:39569 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026179AbbD0WseIO0GH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 00:48:34 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t3RMmR2Y023167
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 27 Apr 2015 15:48:27 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.224.2; Mon, 27 Apr 2015 15:48:27 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 07/11] mips/bcm77xx: remove legacy __cpuinit sections that crept in
Date:   Mon, 27 Apr 2015 18:47:56 -0400
Message-ID: <1430174880-27958-8-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

We removed __cpuinit support (leaving no-op stubs) quite some time ago.
However a few more crept in as of commit 6ee1d93455384cef8a0426effe85da2
("MIPS: BCM47XX: Detect more then 128 MiB of RAM (HIGHMEM)")

Since we want to clobber the stubs soon, get this removed now.

Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/bcm47xx/prom.c           | 2 +-
 arch/mips/include/asm/pgtable-32.h | 2 +-
 arch/mips/mm/tlb-r4k.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index ab698bad6d62..135a5407f015 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -126,7 +126,7 @@ void __init prom_free_prom_memory(void)
 /* Stripped version of tlb_init, with the call to build_tlb_refill_handler
  * dropped. Calling it at this stage causes a hang.
  */
-void __cpuinit early_tlb_init(void)
+void early_tlb_init(void)
 {
 	write_c0_pagemask(PM_DEFAULT_MASK);
 	write_c0_wired(0);
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 7d56686c0e62..832e2167d00f 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -18,7 +18,7 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
-extern int temp_tlb_entry __cpuinitdata;
+extern int temp_tlb_entry;
 
 /*
  * - add_temporary_entry() add a temporary TLB entry. We use TLB entries
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index a27a088e6f9f..440cbf3d6ab9 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -423,7 +423,7 @@ int __init has_transparent_hugepage(void)
  * lifetime of the system
  */
 
-int temp_tlb_entry __cpuinitdata;
+int temp_tlb_entry;
 
 __init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 			       unsigned long entryhi, unsigned long pagemask)
-- 
2.2.1
