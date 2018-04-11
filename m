Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 21:04:38 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994791AbeDKTETd4AKB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2018 21:04:19 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E53B2BAC;
        Wed, 11 Apr 2018 19:04:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 219/310] MIPS: mm: adjust PKMAP location
Date:   Wed, 11 Apr 2018 20:35:58 +0200
Message-Id: <20180411183631.971996975@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63501
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>


[ Upstream commit c56e7a4c3e77f6fbd9b55c06c14eda65aae58958 ]

Space reserved for PKMap should span from PKMAP_BASE to FIXADDR_START.
For large page sizes this is not the case as eg. for 64k pages the range
currently defined is from 0xfe000000 to 0x102000000(!!) which obviously
isn't right.
Remove the hardcoded location and set the BASE address as an offset from
FIXADDR_START.

Since all PKMAP ptes have to be placed in a contiguous memory, ensure
that this is the case by placing them all in a single page. This is
achieved by aligning the end address to pkmap pages count pages.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15950/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/pgtable-32.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -18,6 +18,10 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
+
 extern int temp_tlb_entry;
 
 /*
@@ -61,7 +65,8 @@ extern int add_temporary_entry(unsigned
 
 #define VMALLOC_START	  MAP_BASE
 
-#define PKMAP_BASE		(0xfe000000UL)
+#define PKMAP_END	((FIXADDR_START) & ~((LAST_PKMAP << PAGE_SHIFT)-1))
+#define PKMAP_BASE	(PKMAP_END - PAGE_SIZE * LAST_PKMAP)
 
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
