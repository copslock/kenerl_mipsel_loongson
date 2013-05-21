Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 22:55:57 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:65384 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835041Ab3EUUzJ2NUj4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 22:55:09 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so1112139pad.36
        for <multiple recipients>; Tue, 21 May 2013 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LcX/8NieWEnH8Pi2mGMtZ4MKTZnFoS2kiqPdCX9bNyg=;
        b=F8mfWz3IvA9tIRCdxAU9OuMikgSTOBzLeJPlrmJVQv+ZJ4IbXe1BbcKB1Ulge5T3od
         6XpzRia7KjRk3rEgBdzzI1FE3zCxbtIyAfdxio3MWIiD/+xpeyvelzmEqPWl9ADJw7UP
         G9CiGCXRMtIwmvtSsNvQhZgKFrF3lG4L6xk9e5rYzfymbRSdh1PTmCqazLfUrgvDDvHI
         SrEXShj74LOkzkK7ymE28x0WtGmbss3dtmeTxpUpup6JzgBpSCijNa0N3P2WitL2zO41
         Ve7w/uj6a8TfpVSBQ6epEUV8IioiDaR1V7gSNtnX+WQZFbD7TCtd3vgqtp7HlQPZo2R2
         /QSA==
X-Received: by 10.68.11.73 with SMTP id o9mr4617408pbb.18.1369169702935;
        Tue, 21 May 2013 13:55:02 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id fp2sm4027566pbb.36.2013.05.21.13.55.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 13:55:00 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4LKsxcm010491;
        Tue, 21 May 2013 13:54:59 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4LKsxJZ010490;
        Tue, 21 May 2013 13:54:59 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v4 2/6] mips/kvm: Fix ABI for use of 64-bit registers.
Date:   Tue, 21 May 2013 13:54:51 -0700
Message-Id: <1369169695-10444-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36509
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

All registers are 64-bits wide, 32-bit guests use the least
significant portion of the register storage fields.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
index 0e8f565..86812fb 100644
--- a/arch/mips/include/asm/kvm.h
+++ b/arch/mips/include/asm/kvm.h
@@ -18,12 +18,18 @@
 #define N_MIPS_COPROC_REGS      32
 #define N_MIPS_COPROC_SEL   	8
 
-/* for KVM_GET_REGS and KVM_SET_REGS */
+/*
+ * for KVM_GET_REGS and KVM_SET_REGS
+ *
+ * If Config[AT] is zero (32-bit CPU), the register contents are
+ * stored in the lower 32-bits of the struct kvm_regs fields and sign
+ * extended to 64-bits.
+ */
 struct kvm_regs {
-	__u32 gprs[32];
-	__u32 hi;
-	__u32 lo;
-	__u32 pc;
+	__u64 gprs[32];
+	__u64 hi;
+	__u64 lo;
+	__u64 pc;
 
 	__u32 cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
 };
-- 
1.7.11.7
