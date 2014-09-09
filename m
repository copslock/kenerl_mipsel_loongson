Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2014 18:02:25 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37143 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008463AbaIIQCXgK-nO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Sep 2014 18:02:23 +0200
Received: by mail-pa0-f53.google.com with SMTP id rd3so5132610pab.40
        for <multiple recipients>; Tue, 09 Sep 2014 09:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=Ld7F9a3EtmL1bR+yaB6M9SkPUaEHcsMdfMnv11s9kR8=;
        b=fTDx7+yAYOgOj7BADmayCFMOIjFq36oHWv/a4x+eOv5t+dwQH0Vsf2nRR/L4HjqOzL
         4PxZwxk2w3+v093Uryg+0nR9I/zQUREwqb87QpBrcjYpzHtIesxDCP7a+9Sbl76KxQZH
         qBPzP5OvnHs8mFf8Hx5E/kbJ9fwTeXBNJFOd3UmalAE8aAdr8wj3UKKhpP61FZ/tahxt
         LJ/oMxxnYaijC8+MzjYYdwSqkxLYs9NkzbhkQY5HhQV1pSwRebrIAKpXYjLQ+xSEv2Kh
         kBkRTAdrQxyZwHKy1cDNCQ/vtXefsS6Guza6+PdUjTdPnDuIqgt+vNeaFX22736JLBmC
         pdvQ==
X-Received: by 10.68.238.69 with SMTP id vi5mr31955612pbc.0.1410278535988;
        Tue, 09 Sep 2014 09:02:15 -0700 (PDT)
Received: from linux-ibnp.site (pdadd5e69.tokynt01.ap.so-net.ne.jp. [218.221.94.105])
        by mx.google.com with ESMTPSA id cf4sm11985499pbb.87.2014.09.09.09.02.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2014 09:02:15 -0700 (PDT)
From:   Isamu Mogi <isamu@leafytree.jp>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Isamu Mogi <isamu@leafytree.jp>
Subject: [PATCH] MIPS: R3000: Fix debug output for Virtual page number
Date:   Wed, 10 Sep 2014 01:00:29 +0900
Message-Id: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
X-Mailer: git-send-email 1.8.4.5
Return-Path: <wiz.saturday@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42485
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

Virtual page number of R3000 in entryhi is 20 bit from MSB. But in
dump_tlb(), the bit mask to read it from entryhi is 19 bit (0xffffe000).
The patch fixes that to 0xfffff000.

Signed-off-by: Isamu Mogi <isamu@leafytree.jp>
---
 arch/mips/lib/r3k_dump_tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 91615c2..1ef365a 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -34,7 +34,7 @@ static void dump_tlb(int first, int last)
 		entrylo0 = read_c0_entrylo0();
 
 		/* Unused entries have a virtual address of KSEG0.  */
-		if ((entryhi & 0xffffe000) != 0x80000000
+		if ((entryhi & 0xfffff000) != 0x80000000
 		    && (entryhi & 0xfc0) == asid) {
 			/*
 			 * Only print entries in use
@@ -43,7 +43,7 @@ static void dump_tlb(int first, int last)
 
 			printk("va=%08lx asid=%08lx"
 			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
-			       (entryhi & 0xffffe000),
+			       (entryhi & 0xfffff000),
 			       entryhi & 0xfc0,
 			       entrylo0 & PAGE_MASK,
 			       (entrylo0 & (1 << 11)) ? 1 : 0,
-- 
1.8.4.5
