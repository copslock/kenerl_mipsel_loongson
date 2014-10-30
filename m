Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 14:08:30 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58851 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012302AbaJ3NINyp4-A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 14:08:13 +0100
Received: by mail-pa0-f53.google.com with SMTP id kx10so5428076pab.40
        for <multiple recipients>; Thu, 30 Oct 2014 06:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qc8e1QDMx+pDlU4Z5J60/q6v+mbhih+wUezMK30QNSQ=;
        b=N4JEq0pHi2q3XBD45NtJMu1SsykHXoyXq/kuq46jv5ZAalfbyn7/lSJx8E63FhTDEQ
         E31MWrnWXoL/WMrkK7F6o0lc31MQGPpu4gTKqFhld/9LyIO1KWduGBE7YctPsN0jhOqw
         GPQjk8xFA2FhG4AxEoC8I8HyyeYifXceSdmM+M+M8Fv9lFbMOm6fTbx0QyioOBVUNobR
         fLkvQJzuHAMkzUB9eN45xdsYFrLttZwGmo8mmKxdJC7r2UrLhftrMISqKMyBPq14qxI5
         tJ52hQuTaQnybPoGwGYOrtJScIRznJx2lxvFf2k1q1QMEcXPSodyZVD1ylB6jWOLJ2tx
         yW1A==
X-Received: by 10.70.103.102 with SMTP id fv6mr17532229pdb.92.1414674487814;
        Thu, 30 Oct 2014 06:08:07 -0700 (PDT)
Received: from localhost.localdomain (p76ecb424.tokynt01.ap.so-net.ne.jp. [118.236.180.36])
        by mx.google.com with ESMTPSA id gy10sm4284525pbd.67.2014.10.30.06.08.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Oct 2014 06:08:06 -0700 (PDT)
From:   Isamu Mogi <isamu@leafytree.jp>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        isamu@leafytree.jp
Subject: [PATCH v2 1/3] MIPS: R3000: Fix debug output for Virtual page number
Date:   Thu, 30 Oct 2014 22:07:36 +0900
Message-Id: <1414674458-7583-2-git-send-email-isamu@leafytree.jp>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
References: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
 <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
Return-Path: <wiz.saturday@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43783
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
1.9.1
