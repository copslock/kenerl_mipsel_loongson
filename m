Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 14:08:45 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:57281 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012298AbaJ3NIQ1DnoL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 14:08:16 +0100
Received: by mail-pa0-f54.google.com with SMTP id rd3so5467206pab.13
        for <multiple recipients>; Thu, 30 Oct 2014 06:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2X48KIjDbrbMzjvaJ8uPP5ZvBv23nknjdx07MXDvvoU=;
        b=IXS2Qoj5V+vseWyU0rS0mh8OLiYWYLe4DweAuvJ8mdmWE2GFBZvCp/VbVGH68x22iZ
         dczA6fqEFTmznPJ3DRIq8aF7x6sUYlcuF1xZ0RY7U/soH18IyPzYjH7eA2JFZqpm/dCF
         suoDDWbukXEz9U0I7iHBVmYmF3BTWTVy2cF/TUDZ5+1adHWD22gzjcjOSUDqlpgBT5w8
         BrlCU5497tWhsXCB6lsoEoxsMY/Cd5bXX4BAJWG39zWmQL/82iRKdrVhWlEB5nHghOla
         M8UtFrU132jnKnjJSCec27G+jf+wWP1cZMwCEBxpeeQfXIBWGYQWBjIb12tGVkwNdOL7
         KFYw==
X-Received: by 10.66.171.135 with SMTP id au7mr17150516pac.80.1414674490098;
        Thu, 30 Oct 2014 06:08:10 -0700 (PDT)
Received: from localhost.localdomain (p76ecb424.tokynt01.ap.so-net.ne.jp. [118.236.180.36])
        by mx.google.com with ESMTPSA id gy10sm4284525pbd.67.2014.10.30.06.08.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Oct 2014 06:08:09 -0700 (PDT)
From:   Isamu Mogi <isamu@leafytree.jp>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        isamu@leafytree.jp
Subject: [PATCH v2 2/3] MIPS: R3000: Replace magic numbers with macros
Date:   Thu, 30 Oct 2014 22:07:37 +0900
Message-Id: <1414674458-7583-3-git-send-email-isamu@leafytree.jp>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
References: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
 <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
Return-Path: <wiz.saturday@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: isamu@leafytree.jp
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

Also include asm/mmu_context.h for ASID_MASK.

Signed-off-by: Isamu Mogi <isamu@leafytree.jp>
---
 arch/mips/lib/r3k_dump_tlb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 1ef365a..c97bb70 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 
 #include <asm/mipsregs.h>
+#include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/tlbdebug.h>
@@ -21,7 +22,7 @@ static void dump_tlb(int first, int last)
 	unsigned int asid;
 	unsigned long entryhi, entrylo0;
 
-	asid = read_c0_entryhi() & 0xfc0;
+	asid = read_c0_entryhi() & ASID_MASK;
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i<<8);
@@ -34,8 +35,8 @@ static void dump_tlb(int first, int last)
 		entrylo0 = read_c0_entrylo0();
 
 		/* Unused entries have a virtual address of KSEG0.  */
-		if ((entryhi & 0xfffff000) != 0x80000000
-		    && (entryhi & 0xfc0) == asid) {
+		if ((entryhi & PAGE_MASK) != KSEG0
+		    && (entryhi & ASID_MASK) == asid) {
 			/*
 			 * Only print entries in use
 			 */
@@ -43,8 +44,8 @@ static void dump_tlb(int first, int last)
 
 			printk("va=%08lx asid=%08lx"
 			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
-			       (entryhi & 0xfffff000),
-			       entryhi & 0xfc0,
+			       (entryhi & PAGE_MASK),
+			       entryhi & ASID_MASK,
 			       entrylo0 & PAGE_MASK,
 			       (entrylo0 & (1 << 11)) ? 1 : 0,
 			       (entrylo0 & (1 << 10)) ? 1 : 0,
-- 
1.9.1
