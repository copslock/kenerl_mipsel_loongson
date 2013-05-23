Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 18:50:18 +0200 (CEST)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:56220 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835067Ab3EWQtZFUWDo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 18:49:25 +0200
Received: by mail-pb0-f53.google.com with SMTP id un4so3107272pbc.26
        for <multiple recipients>; Thu, 23 May 2013 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vAgK6L8ALXYpkeW0UZmTLmrIhRHNbRQXnt0c6dS3Ydc=;
        b=IWbFdX1dcUHBTc5dxw6hsS0tAQ2P1Dw14yth3bIF/QfvdCKp5tThrpF9UN28JVM3RU
         wYLxAgE00sIonWiJScCMFnAIB20nCbvYE0GzMJY9sy0/7GZSop3MPp9K27s1DKxi0ptl
         AXty3Fv5KavowmGFcaNgeLUUVkZLg3jdMZYp9CpMQhgpFRk0kJg6SBP64FJwmA1TkmlA
         wmDbaqdFtP2gLbZEo51afZ+7qJy4VRRNO/szXD1TXojyOCfEjpKjceOl3X/nzDMGgoMX
         6Yhn3q6wcLHQcIhqo4v7NBdQrx9uU6p7/9rnmKuGwsLjpnYkKrGMTtx2vSs7QEjPJTLJ
         RN3w==
X-Received: by 10.66.163.5 with SMTP id ye5mr14160528pab.60.1369327758343;
        Thu, 23 May 2013 09:49:18 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ri8sm12416648pbc.3.2013.05.23.09.49.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 09:49:16 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4NGnEVE028627;
        Thu, 23 May 2013 09:49:14 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4NGnEAv028626;
        Thu, 23 May 2013 09:49:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 2/6] mips/kvm: Fix ABI for use of 64-bit registers.
Date:   Thu, 23 May 2013 09:49:06 -0700
Message-Id: <1369327750-28580-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36558
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
Acked-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/uapi/asm/kvm.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index 0e8f565..86812fb 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
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
