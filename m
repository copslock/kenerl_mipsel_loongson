Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:05:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6867 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993883AbdBBME7zCIIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:04:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7EA86FDCDB833;
        Thu,  2 Feb 2017 12:04:50 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:04:53 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>
Subject: [PATCH v2 1/30] MIPS: Move pgd_alloc() out of header
Date:   Thu, 2 Feb 2017 12:04:14 +0000
Message-ID: <21f45e82ab0d734ea1ef614551639f2e8d900557.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

pgd_alloc() references init_mm which is not exported to modules. In
order for KVM to be able to use pgd_alloc() to allocate GVA page tables,
move pgd_alloc() into a new pgtable.c file and export it to modules.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
Changes in v2:
- Move pgd_alloc() into C code rather than exporting init_mm itself
  (feedback from Arjan van de Ven).
---
 arch/mips/include/asm/pgalloc.h | 16 +---------------
 arch/mips/mm/Makefile           |  2 +-
 arch/mips/mm/pgtable.c          | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 16 deletions(-)
 create mode 100644 arch/mips/mm/pgtable.c

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index a03e86969f78..a8705f6c8180 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -43,21 +43,7 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
  * Initialize a new pgd / pmd table with invalid pointers.
  */
 extern void pgd_init(unsigned long page);
-
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *ret, *init;
-
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
-	if (ret) {
-		init = pgd_offset(&init_mm, 0UL);
-		pgd_init((unsigned long)ret);
-		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
-
-	return ret;
-}
+extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index b4c64bd3f723..b4cc8811a664 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -4,7 +4,7 @@
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
 				   gup.o init.o mmap.o page.o page-funcs.o \
-				   tlbex.o tlbex-fault.o tlb-funcs.o
+				   pgtable.o tlbex.o tlbex-fault.o tlb-funcs.o
 
 ifdef CONFIG_CPU_MICROMIPS
 obj-y				+= uasm-micromips.o
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
new file mode 100644
index 000000000000..05560b042d82
--- /dev/null
+++ b/arch/mips/mm/pgtable.c
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <asm/pgalloc.h>
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *ret, *init;
+
+	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
+	if (ret) {
+		init = pgd_offset(&init_mm, 0UL);
+		pgd_init((unsigned long)ret);
+		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
+		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pgd_alloc);
-- 
git-series 0.8.10
