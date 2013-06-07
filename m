Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:10:29 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:54683 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835169Ab3FGXD6SrtRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:58 +0200
Received: by mail-ie0-f173.google.com with SMTP id k5so5443944iea.4
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bqbios0qAPVIJFNg+qjSdx1UGzUEs/W9K2uF+KtLf9s=;
        b=eQkx0lSBkrUR/YCzTtE18Np8SJKx8yQmSXXVGfErFbpRp8Q9rvB97lBysHoFgwnOL8
         F/rHz6tuhaVaM9Or7KF7exSBCN1hQUIgHX3g2rAy5h4vmMdqdzTYlgF7dyI5bJop3/wB
         NTKBSkde7F2j2+VFHCfEseGFxmgxPTktnnciDqeOAExS9xW8F+WOnAdr4ygoutSf+sto
         1I+wItRdT/lfkeQHMir1MZfPK/8UvKTVuGra481aSS7ynqUhqjdxqq8gG9qIKF1T4Yh6
         f743C0r5MJ9P5VkG6L9IjFZ/v30MwqQ7E4pA9tQLSSBMVZm5yZLahUmTDG/BbKgfWEKc
         DreA==
X-Received: by 10.50.87.4 with SMTP id t4mr399521igz.76.1370646232254;
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id h3sm1221753igv.1.2013.06.07.16.03.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:51 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3nNd006682;
        Fri, 7 Jun 2013 16:03:49 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3n33006681;
        Fri, 7 Jun 2013 16:03:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 18/31] mips/kvm: Add pt_regs slots for BadInstr and BadInstrP
Date:   Fri,  7 Jun 2013 16:03:22 -0700
Message-Id: <1370646215-6543-19-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36736
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

These save the instruction word to be used by MIPSVZ code for
instruction emulation.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/ptrace.h | 4 ++++
 arch/mips/kernel/asm-offsets.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 5e6cd09..d080716 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -46,6 +46,10 @@ struct pt_regs {
 	unsigned long long mpl[3];	  /* MTM{0,1,2} */
 	unsigned long long mtp[3];	  /* MTP{0,1,2} */
 #endif
+#ifdef CONFIG_KVM_MIPSVZ
+	unsigned int cp0_badinstr;	/* Only populated on do_page_fault_{0,1} */
+	unsigned int cp0_badinstrp;	/* Only populated on do_page_fault_{0,1} */
+#endif
 } __aligned(8);
 
 struct task_struct;
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 03bf363..c5cc28f 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -71,6 +71,10 @@ void output_ptreg_defines(void)
 	OFFSET(PT_MPL, pt_regs, mpl);
 	OFFSET(PT_MTP, pt_regs, mtp);
 #endif /* CONFIG_CPU_CAVIUM_OCTEON */
+#ifdef CONFIG_KVM_MIPSVZ
+	OFFSET(PT_BADINSTR, pt_regs, cp0_badinstr);
+	OFFSET(PT_BADINSTRP, pt_regs, cp0_badinstrp);
+#endif
 	DEFINE(PT_SIZE, sizeof(struct pt_regs));
 	BLANK();
 }
-- 
1.7.11.7
