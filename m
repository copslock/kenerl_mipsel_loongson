Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 20:44:57 +0200 (CEST)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:53105 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835057Ab3EVSoNzIuGn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 20:44:13 +0200
Received: by mail-pb0-f53.google.com with SMTP id un4so1990915pbc.26
        for <multiple recipients>; Wed, 22 May 2013 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LcX/8NieWEnH8Pi2mGMtZ4MKTZnFoS2kiqPdCX9bNyg=;
        b=Jc4R1prNoeefnfuXv0KdEUWoH/yQU9tanrJ/X50h8X0OLe0Olw+gkEAsqoAdwwzP+9
         4xg42qhmmbZGEUNW7Jp4ldb2TI1YkPTfTuptzG9frUDz9TAYG9LEuzjFy87TlkodCIut
         CYkb8JnDuAEheis6WlowVHVzXeb3S2oFOyMuU/RlYh+eb0XzEKFySMYbNQIL8/5q9pwA
         YTr/B9BAgzieQ8eXOrHa3FU1jesxOn6VmsgqrvsPOfFXeaqvjjSIgMynQIr/P5XKE8gN
         k46FI5ELoKrWcEffp8Vsoq39ve3P5FkTEvNhMoQgU60FmfZOfECoKLvEcI09A+UQ4UTE
         vh3g==
X-Received: by 10.66.123.72 with SMTP id ly8mr9526483pab.159.1369248247126;
        Wed, 22 May 2013 11:44:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id v7sm8214352pbq.32.2013.05.22.11.44.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 11:44:06 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MIi4ss027285;
        Wed, 22 May 2013 11:44:04 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MIi4wY027284;
        Wed, 22 May 2013 11:44:04 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v5 2/6] mips/kvm: Fix ABI for use of 64-bit registers.
Date:   Wed, 22 May 2013 11:43:52 -0700
Message-Id: <1369248236-27237-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36533
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
