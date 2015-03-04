Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:21:55 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50043 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007050AbbCDGUrL9ber (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:20:47 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95CF392F;
        Wed,  4 Mar 2015 06:20:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.19 082/175] MIPS: asm: pgtable: Prevent HTW race when updating PTEs
Date:   Tue,  3 Mar 2015 22:14:20 -0800
Message-Id: <20150304061039.860295538@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304061026.134125919@linuxfoundation.org>
References: <20150304061026.134125919@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit fde3538a8a711aedf1173ecb2d45aed868f51c97 upstream.

Whenever we modify a page table entry, we need to ensure that the HTW
will not fetch a stable entry. And for that to happen we need to ensure
that HTW is stopped before we modify the said entry otherwise the HTW
may already be in the process of reading that entry and fetching the
old information. As a result of which, we replace the htw_reset() calls
with htw_{stop,start} in more appropriate places. This also removes the
remaining users of htw_reset() and as a result we drop that macro

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9116/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/pgtable.h |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -116,14 +116,6 @@ do {									\
 } while(0)
 
 
-#define htw_reset()							\
-do {									\
-	if (cpu_has_htw) {						\
-		htw_stop();						\
-		htw_start();						\
-	}								\
-} while(0)
-
 extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	pte_t pteval);
 
@@ -155,12 +147,13 @@ static inline void pte_clear(struct mm_s
 {
 	pte_t null = __pte(0);
 
+	htw_stop();
 	/* Preserve global status for the pair */
 	if (ptep_buddy(ptep)->pte_low & _PAGE_GLOBAL)
 		null.pte_low = null.pte_high = _PAGE_GLOBAL;
 
 	set_pte_at(mm, addr, ptep, null);
-	htw_reset();
+	htw_start();
 }
 #else
 
@@ -190,6 +183,7 @@ static inline void set_pte(pte_t *ptep,
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
+	htw_stop();
 #if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX)
 	/* Preserve global status for the pair */
 	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
@@ -197,7 +191,7 @@ static inline void pte_clear(struct mm_s
 	else
 #endif
 		set_pte_at(mm, addr, ptep, __pte(0));
-	htw_reset();
+	htw_start();
 }
 #endif
 
