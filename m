Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 18:51:09 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40869 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835069Ab3EWQt0MtNlB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 18:49:26 +0200
Received: by mail-pd0-f169.google.com with SMTP id y11so3109293pdj.0
        for <multiple recipients>; Thu, 23 May 2013 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KFfd6NKAVPZKiZ7EJ6LVR+FjzFhhVlvucDRvYk+PM1A=;
        b=TiL/xFlKRubH7F0xfseDen2vUZe/4+KlGlN42TVHeQmm0ZaSbUcUynmGlESK6CUZ92
         N79Fau1p4dPowMQscwWrLtpCa0WCL9W118vAWzaUBm2yfqIy0JzBunvfNjyL89lNG+HL
         MTPGLkGViQKyAzFP57fZHi340ZzSE9AaLX2dQiUbKOP+RMMFk/O26K1xBFg3Bs145uAt
         VC6ZehodSLZ62VKwWmY/QJpLH9j7KJBrDtcf06inVtTQpo6P9bBEtUDyBNhvn6goYv6G
         ECtL8Co+k0s0gGyzp0wAjo2JXcQhr+NesM/sBoBjM29hbEJYu/V1UM3erCZ584UDrw6z
         sGqg==
X-Received: by 10.68.92.165 with SMTP id cn5mr14061339pbb.50.1369327759683;
        Thu, 23 May 2013 09:49:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id al2sm12374002pbc.25.2013.05.23.09.49.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 09:49:17 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4NGnF1S028631;
        Thu, 23 May 2013 09:49:15 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4NGnFOL028630;
        Thu, 23 May 2013 09:49:15 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 3/6] mips/kvm: Fix name of gpr field in struct kvm_regs.
Date:   Thu, 23 May 2013 09:49:07 -0700
Message-Id: <1369327750-28580-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36559
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
Acked-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/uapi/asm/kvm.h | 3 ++-
 arch/mips/kvm/kvm_mips.c         | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index 86812fb..d145ead 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -26,7 +26,8 @@
  * extended to 64-bits.
  */
 struct kvm_regs {
-	__u64 gprs[32];
+	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
+	__u64 gpr[32];
 	__u64 hi;
 	__u64 lo;
 	__u64 pc;
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index e0dad02..93da750 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -678,7 +678,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	int i;
 
 	for (i = 0; i < 32; i++)
-		vcpu->arch.gprs[i] = regs->gprs[i];
+		vcpu->arch.gprs[i] = regs->gpr[i];
 
 	vcpu->arch.hi = regs->hi;
 	vcpu->arch.lo = regs->lo;
@@ -692,7 +692,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	int i;
 
 	for (i = 0; i < 32; i++)
-		regs->gprs[i] = vcpu->arch.gprs[i];
+		regs->gpr[i] = vcpu->arch.gprs[i];
 
 	regs->hi = vcpu->arch.hi;
 	regs->lo = vcpu->arch.lo;
-- 
1.7.11.7
