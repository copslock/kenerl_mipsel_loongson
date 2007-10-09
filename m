Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:36:30 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.187]:62212 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022204AbXJIUgW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:36:22 +0100
Received: by mu-out-0910.google.com with SMTP id w1so2123556mue
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:36:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=Y7t3E1Z2CnqTWGuDKAfp836D9SeIropPChYkJFyKpoo=;
        b=ap86wPGJrYc45JycIoGExftu50v3T/wSND1/VweiHpYU2YPDqVWFVN8uFORUB4Gm0CokVE8HgMvQABxaG1NANGAnBiFhnVMrkadobPCqYZY1l3nQ3pFL34VSjZoA1yL3eCUmKW8Dll97ULDhhtNkTr8peCFBMDH9B33Jw2sYlK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=HRfrbbDjHqeYdBKVaQwKg5R7JdOhA7qnDdVy/vnxD1wVrWLnwwSCb/5SAPVyQEbe+Nm9J33M/ZH2EvNRgKQSlEhjKTqGLP1tWK/ohzpwEF3tKr7SgHR3sfQVjO1mJcoiGotN+A8CjaOW5sCJuxW21BmLZh5x3kVkXDVtbCWFJrM=
Received: by 10.82.134.12 with SMTP id h12mr8659161bud.1191962163091;
        Tue, 09 Oct 2007 13:36:03 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id i5sm16667672mue.2007.10.09.13.36.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:36:01 -0700 (PDT)
Message-ID: <470BE61F.5020108@gmail.com>
Date:	Tue, 09 Oct 2007 22:35:43 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 2/6] tlbex.c: Remove relocs[] and labels[] from the init.data
 section
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com>
In-Reply-To: <470BE58A.9070709@gmail.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch reduces the kernel image size by making these 2 arrays
automatic variables.

	tlbex.o~old  =>  tlbex.o
	 text:     9840     9812      -28  0%
	 data:     3904     1344    -2560 -65%
	  bss:     1568     1568        0  0%
	total:    15312    12724    -2588 -16%

It increases the stack pressure a lot (more than 2500 bytes) but
at this stage in the boot process, it shouldn't matter.

Futhermore the TLB handler generator code doesn't have any deep
call graph and probably won't.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 01b0961..ae1bf81 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -745,10 +745,6 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
  */
 static u32 tlb_handler[128] __initdata;
 
-/* simply assume worst case size for labels and relocs */
-static struct label labels[128] __initdata;
-static struct reloc relocs[128] __initdata;
-
 /*
  * The R3000 TLB handler is simple.
  */
@@ -1250,8 +1246,8 @@ static void __init build_update_entries(u32 **p, unsigned int tmp,
 static void __init build_r4000_tlb_refill_handler(void)
 {
 	u32 *p = tlb_handler;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct label labels[128], *l = labels;
+	struct reloc relocs[128], *r = relocs;
 	u32 *f;
 	unsigned int final_len;
 	int i;
@@ -1598,8 +1594,8 @@ build_r3000_tlbchange_handler_head(u32 **p, unsigned int pte,
 static void __init build_r3000_tlb_load_handler(void)
 {
 	u32 *p = handle_tlbl;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct label labels[FASTPATH_SIZE], *l = labels;
+	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
 	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
@@ -1633,8 +1629,8 @@ static void __init build_r3000_tlb_load_handler(void)
 static void __init build_r3000_tlb_store_handler(void)
 {
 	u32 *p = handle_tlbs;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct label labels[FASTPATH_SIZE], *l = labels;
+	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
 	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
@@ -1668,8 +1664,8 @@ static void __init build_r3000_tlb_store_handler(void)
 static void __init build_r3000_tlb_modify_handler(void)
 {
 	u32 *p = handle_tlbm;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct label labels[FASTPATH_SIZE], *l = labels;
+	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
 	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
@@ -1748,8 +1744,8 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct label **l,
 static void __init build_r4000_tlb_load_handler(void)
 {
 	u32 *p = handle_tlbl;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct label labels[FASTPATH_SIZE], *l = labels;
+	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
 	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
@@ -1793,8 +1789,8 @@ static void __init build_r4000_tlb_load_handler(void)
 static void __init build_r4000_tlb_store_handler(void)
 {
 	u32 *p = handle_tlbs;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct label labels[FASTPATH_SIZE], *l = labels;
+	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
 	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
@@ -1829,8 +1825,8 @@ static void __init build_r4000_tlb_store_handler(void)
 static void __init build_r4000_tlb_modify_handler(void)
 {
 	u32 *p = handle_tlbm;
-	struct label *l = labels;
-	struct reloc *r = relocs;
+	struct label labels[FASTPATH_SIZE], *l = labels;
+	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
 	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
-- 
1.5.3.3
