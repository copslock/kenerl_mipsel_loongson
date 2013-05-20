Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 23:12:08 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55105 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824782Ab3ETVMHOc25G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 23:12:07 +0200
Received: by mail-pa0-f53.google.com with SMTP id kq12so618pab.26
        for <multiple recipients>; Mon, 20 May 2013 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3S3jqyZefuF+me5XGTGvkSRBH8Tk1ehaJ4J7UJW8LB0=;
        b=sVdiPQeN0jqJ7BGghFLgfpxLldm6lkZkOUKvlGpLTt1MoSvaNtYOA+SKvVNIegRENX
         25Uy012BDko7GCw+OAUNwX2a63p1Tg2r0eeg7TvBliou5RzRAyj4QYnXtHOmaDofxDiy
         W9ZSmVtMsFqmx9oeCyDIlmHQJQx/+0cgtvIuWK2/Yo8s8t2Ep6q1n7voxDkDWe2tHHlT
         4P9r4Fn86BVlZFR7XWViCJpfEwWIxXNTq5NEBLpnNxjGwCbuXa3fmF6EvlQqMAGxGKbT
         3fO/v3N/h9hMRU4nJQZHKzLjjdvqw9jAKpkykqF1R6FxGtF3JTSq/CxiPLkEOC+KhY2r
         Fv5g==
X-Received: by 10.66.144.5 with SMTP id si5mr25730pab.6.1369084320706;
        Mon, 20 May 2013 14:12:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id b7sm25488369pba.39.2013.05.20.14.11.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 14:11:59 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4KLBvgW027919;
        Mon, 20 May 2013 14:11:58 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4KL1Umw027564;
        Mon, 20 May 2013 14:01:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 3/5] mips/kvm: Fix name of gpr field in struct kvm_regs.
Date:   Mon, 20 May 2013 14:01:24 -0700
Message-Id: <1369083686-27524-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36489
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
 arch/mips/include/asm/kvm.h | 3 ++-
 arch/mips/kvm/kvm_mips.c    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
index 86812fb..d145ead 100644
--- a/arch/mips/include/asm/kvm.h
+++ b/arch/mips/include/asm/kvm.h
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
