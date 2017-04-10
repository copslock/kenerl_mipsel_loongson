Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:42:17 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35848 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbdDJQktx9gYJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:40:49 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63BDDB80;
        Mon, 10 Apr 2017 16:40:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rui Wang <wangr@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 31/32] MIPS: Flush wrong invalid FTLB entry for huge page
Date:   Mon, 10 Apr 2017 18:39:21 +0200
Message-Id: <20170410163843.689864352@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410163839.055472822@linuxfoundation.org>
References: <20170410163839.055472822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57641
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 0115f6cbf26663c86496bc56eeea293f85b77897 upstream.

On VTLB+FTLB platforms (such as Loongson-3A R2), FTLB's pagesize is
usually configured the same as PAGE_SIZE. In such a case, Huge page
entry is not suitable to write in FTLB.

Unfortunately, when a huge page is created, its page table entries
haven't created immediately. Then the TLB refill handler will fetch an
invalid page table entry which has no "HUGE" bit, and this entry may be
written to FTLB. Since it is invalid, TLB load/store handler will then
use tlbwi to write the valid entry at the same place. However, the
valid entry is a huge page entry which isn't suitable for FTLB.

Our solution is to modify build_huge_handler_tail. Flush the invalid
old entry (whether it is in FTLB or VTLB, this is in order to reduce
branches) and use tlbwr to write the valid new entry.

Signed-off-by: Rui Wang <wangr@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15754/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/tlbex.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -757,7 +757,8 @@ static void build_huge_update_entries(u3
 static void build_huge_handler_tail(u32 **p, struct uasm_reloc **r,
 				    struct uasm_label **l,
 				    unsigned int pte,
-				    unsigned int ptr)
+				    unsigned int ptr,
+				    unsigned int flush)
 {
 #ifdef CONFIG_SMP
 	UASM_i_SC(p, pte, 0, ptr);
@@ -766,6 +767,22 @@ static void build_huge_handler_tail(u32
 #else
 	UASM_i_SW(p, pte, 0, ptr);
 #endif
+	if (cpu_has_ftlb && flush) {
+		BUG_ON(!cpu_has_tlbinv);
+
+		UASM_i_MFC0(p, ptr, C0_ENTRYHI);
+		uasm_i_ori(p, ptr, ptr, MIPS_ENTRYHI_EHINV);
+		UASM_i_MTC0(p, ptr, C0_ENTRYHI);
+		build_tlb_write_entry(p, l, r, tlb_indexed);
+
+		uasm_i_xori(p, ptr, ptr, MIPS_ENTRYHI_EHINV);
+		UASM_i_MTC0(p, ptr, C0_ENTRYHI);
+		build_huge_update_entries(p, pte, ptr);
+		build_huge_tlb_write_entry(p, l, r, pte, tlb_random, 0);
+
+		return;
+	}
+
 	build_huge_update_entries(p, pte, ptr);
 	build_huge_tlb_write_entry(p, l, r, pte, tlb_indexed, 0);
 }
@@ -2082,7 +2099,7 @@ static void build_r4000_tlb_load_handler
 		uasm_l_tlbl_goaround2(&l, p);
 	}
 	uasm_i_ori(&p, wr.r1, wr.r1, (_PAGE_ACCESSED | _PAGE_VALID));
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
@@ -2137,7 +2154,7 @@ static void build_r4000_tlb_store_handle
 	build_tlb_probe_entry(&p);
 	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
@@ -2193,7 +2210,7 @@ static void build_r4000_tlb_modify_handl
 	build_tlb_probe_entry(&p);
 	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 0);
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
