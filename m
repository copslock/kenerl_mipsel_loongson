Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:12:56 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63882 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835177Ab3FGXEAI6ZHv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:00 +0200
Received: by mail-ie0-f180.google.com with SMTP id f4so7231466iea.11
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/ljMxTwVGPg7nYtNddBztuOxlXWaYc5iesNoNIV0oQw=;
        b=NitfzVhkab4wafL+UkyB9xMrvKGlbrtLga8LvfB/vRw27Rd+8YvTIlW6ECQP++3Eob
         wEQ1xTzd+Ytnup6dFoIgHvFZr4FkpyKf7qrL83jAtH1oNt1Y1gscRBlHfYVESUkTcLCi
         iC/iD4qymhUA0dM7XFE7dW1OMMyQ7I/sqLagb3vuObdcJL2YO0jCFBhwi6e+Jnv7Y1Vv
         jL5p8q1y8l+sN4B9s/CHo1WJw/6+THnC3yj0j1gnhKBnGKpJtcTMkNqqIRSWtS1bNKP2
         VJaZLqaAz+gZVvhzeCAIByOYWqDsaKVLP8v4QGhKiznDxAzHW43FlFOVxXEgT6e1idBW
         cO6g==
X-Received: by 10.50.40.39 with SMTP id u7mr2270599igk.51.1370646234029;
        Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id z6sm153970igw.8.2013.06.07.16.03.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3pE7006707;
        Fri, 7 Jun 2013 16:03:51 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3pbH006705;
        Fri, 7 Jun 2013 16:03:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 24/31] mips/kvm: Add thread_struct fields used by MIPSVZ hosts.
Date:   Fri,  7 Jun 2013 16:03:28 -0700
Message-Id: <1370646215-6543-25-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36742
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

... and their accessors in asm-offsets.c

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/processor.h | 6 ++++++
 arch/mips/kernel/asm-offsets.c    | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 1470b7b..e0aa198 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -198,6 +198,7 @@ typedef struct {
 #define ARCH_MIN_TASKALIGN	8
 
 struct mips_abi;
+struct kvm_vcpu;
 
 /*
  * If you change thread_struct remember to change the #defines below too!
@@ -230,6 +231,11 @@ struct thread_struct {
 	unsigned long cp0_badvaddr;	/* Last user fault */
 	unsigned long cp0_baduaddr;	/* Last kernel fault accessing USEG */
 	unsigned long error_code;
+#ifdef CONFIG_KVM_MIPSVZ
+	struct kvm_vcpu *vcpu;
+	unsigned int mm_asid;
+	unsigned int guest_asid;
+#endif
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
     struct octeon_cop2_state cp2 __attribute__ ((__aligned__(128)));
     struct octeon_cvmseg_state cvmseg __attribute__ ((__aligned__(128)));
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index c5cc28f..37fd9e2 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -132,6 +132,11 @@ void output_thread_defines(void)
 	       thread.cp0_baduaddr);
 	OFFSET(THREAD_ECODE, task_struct, \
 	       thread.error_code);
+#ifdef CONFIG_KVM_MIPSVZ
+	OFFSET(THREAD_VCPU, task_struct, thread.vcpu);
+	OFFSET(THREAD_MM_ASID, task_struct, thread.mm_asid);
+	OFFSET(THREAD_GUEST_ASID, task_struct, thread.guest_asid);
+#endif
 	BLANK();
 }
 
-- 
1.7.11.7
