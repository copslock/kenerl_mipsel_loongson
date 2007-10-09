Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:37:30 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:50952 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022184AbXJIUhV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:37:21 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1327870nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:37:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=W0WiNFuklsWmjOQ/okiqxMmXDfJObYtAVu995qdt/+I=;
        b=hVSnwlKJW0bZSL6OOtmbgesvTPhh6UoMJ4z5pZ8WoKGK4Q6kl8jOkL5ZsmaL+1Z7t0uedASP8Hp1t20ecGzpDOqm99zLeIkRJnD4Xu7GRJVt1ozcFC+tSheagIAZytjJE/9Hq4hFD4+f/M1EZg2oAe/sUZhCzrf+SVT8C4NZ7Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=SyEC5Og5gjDHPK4qg652UH9nBh9vf9lK6VmA5c7FLGD3lcVXXWAGpQrFdRYyavs8JOyXqc85qTyrEdKfutingeF4Ky9ZaULqeJ18kr4I8+I386QofCTf4wVFLaIteMFCFLpUvfRWtQo7Gx/pRF1jkHQ+mvyYfCWMpEWFRrWtAcM=
Received: by 10.86.86.12 with SMTP id j12mr6292113fgb.1191962223983;
        Tue, 09 Oct 2007 13:37:03 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id g8sm16645767muf.2007.10.09.13.37.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:37:03 -0700 (PDT)
Message-ID: <470BE65C.9030407@gmail.com>
Date:	Tue, 09 Oct 2007 22:36:44 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 3/6] tlbex.c: remove tlb_handler[] from init.data section
   
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
X-archive-position: 16915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch makes it an automatic variable instead therefore it
still increases the stack pressure by 512 bytes.

It results in the following size decrease:

	tlbex.o~old  =>  tlbex.o
	 text:     9812     9780      -32  0%
	 data:     1344      832     -512 -38%
	  bss:     1568     1568        0  0%
	total:    12724    12180     -544 -4%

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |   50 +++++++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ae1bf81..cbcb320 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -735,27 +735,23 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
 # define GET_CONTEXT(buf, reg) i_MFC0(buf, reg, C0_CONTEXT)
 #endif
 
-/* The worst case length of the handler is around 18 instructions for
- * R3000-style TLBs and up to 63 instructions for R4000-style TLBs.
- * Maximum space available is 32 instructions for R3000 and 64
- * instructions for R4000.
- *
- * We deliberately chose a buffer size of 128, so we won't scribble
- * over anything important on overflow before we panic.
- */
-static u32 tlb_handler[128] __initdata;
-
 /*
  * The R3000 TLB handler is simple.
+ *
+ * The worst case length of the handler is around 18 instructions for
+ * R3000-style TLBs and the maximum space available for it is 32
+ * instructions.
+ *
+ * We deliberately chose a buffer size of 64, so we won't scribble
+ * over anything important on overflow before we panic.
  */
 static void __init build_r3000_tlb_refill_handler(void)
 {
+	u32 tlb_handler[64], *p = tlb_handler;
 	long pgdc = (long)pgd_current;
-	u32 *p;
 	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
-	p = tlb_handler;
 
 	i_mfc0(&p, K0, C0_BADVADDR);
 	i_lui(&p, K1, rel_hi(pgdc)); /* cp0 delay */
@@ -787,17 +783,19 @@ static void __init build_r3000_tlb_refill_handler(void)
 		pr_debug("\t.word 0x%08x\n", tlb_handler[i]);
 	pr_debug("\t.set pop\n");
 
-	memcpy((void *)ebase, tlb_handler, 0x80);
+	memcpy((void *)ebase, tlb_handler, 32);
 }
 
 /*
- * The R4000 TLB handler is much more complicated. We have two
- * consecutive handler areas with 32 instructions space each.
- * Since they aren't used at the same time, we can overflow in the
- * other one.To keep things simple, we first assume linear space,
- * then we relocate it to the final handler layout as needed.
+ * The R4000 TLB handler.
+ *
+ * The worst case length of the handler is up to 63 instructions for
+ * R4000-style TLBs and the maximum space available for it is 64
+ * instructions.
+ *
+ * We deliberately chose a buffer size of 128, so we won't scribble
+ * over anything important on overflow before we panic.
  */
-static u32 final_handler[64] __initdata;
 
 /*
  * Hazards
@@ -1243,9 +1241,19 @@ static void __init build_update_entries(u32 **p, unsigned int tmp,
 #endif
 }
 
+/*
+ * The R4000 TLB handler is much more complicated. We have two
+ * consecutive handler areas with 32 instructions space each.
+ * Since they aren't used at the same time, we can overflow in the
+ * other one.To keep things simple, we first assume linear space,
+ * then we relocate it to the final handler layout as needed.
+ */
+static u32 final_handler[64] __initdata;
+
+
 static void __init build_r4000_tlb_refill_handler(void)
 {
-	u32 *p = tlb_handler;
+	u32 tlb_handler[128], *p = tlb_handler;
 	struct label labels[128], *l = labels;
 	struct reloc relocs[128], *r = relocs;
 	u32 *f;
@@ -1365,7 +1373,7 @@ static void __init build_r4000_tlb_refill_handler(void)
 		pr_debug("\t.word 0x%08x\n", f[i]);
 	pr_debug("\t.set pop\n");
 
-	memcpy((void *)ebase, final_handler, 0x100);
+	memcpy((void *)ebase, final_handler, 64);
 }
 
 /*
-- 
1.5.3.3
