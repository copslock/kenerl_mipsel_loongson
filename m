Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:13:13 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:49108 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835179Ab3FGXEAUTATI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:00 +0200
Received: by mail-ie0-f180.google.com with SMTP id f4so7064862iea.39
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FesZui2Z1aJ6HjRckKuehFdG5wSHsW02t2Zo5UHJBJc=;
        b=FB8vyCvoCndCiU+mr4+yfmxfqJ8imE/3BMjXm2bwB1EhbiHMzbFEqJ3b9RPNEG0H1K
         GoIJoCZ6hBFfEfJ5YRRffirXzb6mhx5X5IYehwJObVpmT5NyJCPpy9AK2eAYlX7xczAq
         kKtLqN9f23cEKqvZ6ouRkfYPvgg7KLP2lRUCi6GXhJg8CwCx7c+QE5I09vz2UcoX9Scd
         q36DcMzgpxWPbQJshLfqV1mRIcfy2DCH2m03fGCnCWkKDospCBNIRk819zCOVfvcd3Rx
         ITClrU/RQkCnxmvvzAMpa9pjIwOMYZp+THlxVfqKL3/PnNQGWXFUaewTD/F/veCNxxGq
         9wWg==
X-Received: by 10.50.70.99 with SMTP id l3mr381148igu.91.1370646234213;
        Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id z6sm153992igw.8.2013.06.07.16.03.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3pQv006711;
        Fri, 7 Jun 2013 16:03:51 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3p79006710;
        Fri, 7 Jun 2013 16:03:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 25/31] mips/kvm: Add some asm-offsets constants used by MIPSVZ.
Date:   Fri,  7 Jun 2013 16:03:29 -0700
Message-Id: <1370646215-6543-26-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36743
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/asm-offsets.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 37fd9e2..db09376 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -19,6 +19,7 @@
 
 #include <linux/kvm_host.h>
 #include <asm/kvm_mips_te.h>
+#include <asm/kvm_mips_vz.h>
 
 void output_ptreg_defines(void)
 {
@@ -345,6 +346,8 @@ void output_pbe_defines(void)
 void output_kvm_defines(void)
 {
 	COMMENT(" KVM/MIPS Specfic offsets. ");
+	OFFSET(KVM_ARCH_IMPL, kvm, arch.impl);
+	OFFSET(KVM_VCPU_KVM, kvm_vcpu, kvm);
 	DEFINE(VCPU_ARCH_SIZE, sizeof(struct kvm_vcpu_arch));
 	OFFSET(VCPU_RUN, kvm_vcpu, run);
 	OFFSET(VCPU_HOST_ARCH, kvm_vcpu, arch);
@@ -411,5 +414,9 @@ void output_kvm_defines(void)
 	OFFSET(COP0_TLB_HI, mips_coproc, reg[MIPS_CP0_TLB_HI][0]);
 	OFFSET(COP0_STATUS, mips_coproc, reg[MIPS_CP0_STATUS][0]);
 	BLANK();
+
+	COMMENT(" Linux struct kvm mipsvz offsets. ");
+	OFFSET(KVM_MIPS_VZ_PGD,	kvm_mips_vz, pgd);
+	BLANK();
 }
 #endif
-- 
1.7.11.7
