Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:12:11 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51688 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835174Ab3FGXD7g-Ga2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:59 +0200
Received: by mail-ie0-f170.google.com with SMTP id e14so12152580iej.15
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/5Y8PTAm7wOs6BL5Cm8KYBKvOVPHJgA0Q1o7EwKsSKo=;
        b=aEijGJ+oq3mhGybSVIVfybAP/8o/D1T1AUMdDSQGqLBTz5cvrszm3kJv05/mfx8JTS
         3QchEKontW7XYWemGIo7oPHSr47K6at0zmOhtIPbI9pgpcvIoyOEvKItGI3VO7jzJaLD
         TfbpEwy4b0dNRZj6OOgA9nvLzCt8KMdZYXddNt4rykCdJu9myIdtqTEo0kf3zmHC9wyK
         WstWHw86Ks9aNXVUlBEN002XnDMm4SM/U3H+5jiwYIT9hovebque3G9d63D+KxlObMjI
         kM6Pw7cfvvZRVxYLWvHC/guU81hm8aLlNtPoegKRowIvKhWUSR/GM0TGWw28l6Cp9Vfo
         WjZQ==
X-Received: by 10.50.112.4 with SMTP id im4mr487775igb.1.1370646233487;
        Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id r20sm1155684ign.8.2013.06.07.16.03.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3odd006698;
        Fri, 7 Jun 2013 16:03:50 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3oTR006697;
        Fri, 7 Jun 2013 16:03:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 22/31] mips/kvm: Split get_new_mmu_context into two parts.
Date:   Fri,  7 Jun 2013 16:03:26 -0700
Message-Id: <1370646215-6543-23-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The new function (part) get_new_asid() can now be used from MIPSVZ code.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mmu_context.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 8201160..5609a32 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -108,8 +108,8 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 
 #ifndef CONFIG_MIPS_MT_SMTC
 /* Normal, classic MIPS get_new_mmu_context */
-static inline void
-get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
+static inline unsigned long
+get_new_asid(unsigned long cpu)
 {
 	extern void kvm_local_flush_tlb_all(void);
 	unsigned long asid = asid_cache(cpu);
@@ -125,7 +125,13 @@ get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 		if (!asid)		/* fix version if needed */
 			asid = ASID_FIRST_VERSION;
 	}
+	return asid;
+}
 
+static inline void
+get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
+{
+	unsigned long asid = get_new_asid(cpu);
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
 }
 
-- 
1.7.11.7
