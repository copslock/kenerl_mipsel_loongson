Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 23:12:41 +0200 (CEST)
Received: from mail-da0-f52.google.com ([209.85.210.52]:63743 "EHLO
        mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825657Ab3ETVMHa5b-c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 23:12:07 +0200
Received: by mail-da0-f52.google.com with SMTP id o9so4109854dan.25
        for <multiple recipients>; Mon, 20 May 2013 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LcX/8NieWEnH8Pi2mGMtZ4MKTZnFoS2kiqPdCX9bNyg=;
        b=opkDqwibdP46iIYzMTkB7z/Xws1/AG2/lHuo74JICitr9f5cg/mgqfbbWDQHFJYG6V
         n4UB1/zmyTyxLr+tKPGJcyxLuSi/QJbl99l/pZCvLUUMD5J47cCDCzuZncZiCCsWqVnH
         z0svQok1y07bcr8srJSwZ3FH1Oi52vOtJuZNx9pQrQDlUOjnc4zefgi74u86quy0TuHv
         K1SfbTk652yiYkhCTrahfh3YRWqF/b0vFJ2PwRaWyLKiySn9lsJQPWUDFEfz0pSiSn4K
         y2xgHXWB/pJ8YUSQQO90NYumR7kGm7nH1/mF/SfeQ0TitkYNHH4pF3QrUNWuRs5XCRTN
         9rLg==
X-Received: by 10.68.176.133 with SMTP id ci5mr62155182pbc.21.1369084320514;
        Mon, 20 May 2013 14:12:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id fr1sm25503094pbb.26.2013.05.20.14.11.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 14:11:59 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4KLBvgS027919;
        Mon, 20 May 2013 14:11:57 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4KL1T4T027563;
        Mon, 20 May 2013 14:01:29 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 2/5] mips/kvm: Fix ABI for use of 64-bit registers.
Date:   Mon, 20 May 2013 14:01:23 -0700
Message-Id: <1369083686-27524-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36491
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
