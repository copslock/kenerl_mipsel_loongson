Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 20:46:36 +0200 (CEST)
Received: from mail-da0-f41.google.com ([209.85.210.41]:58920 "EHLO
        mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835060Ab3EVSoPJmMya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 20:44:15 +0200
Received: by mail-da0-f41.google.com with SMTP id y19so1283464dan.14
        for <multiple recipients>; Wed, 22 May 2013 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KG55Qcw8yf1ebMK52M/0Zv0s4R326nTxfJ511nDkXyg=;
        b=tHAVHr40mfcEPcANBWZFq1znJiaY3n+o9F9FNOhVFm3s1xrXJi8KdWaEoli8l+YRgo
         GVZudHJ4yX4ECqQUDGxJgYjMf/lwvr+qBCcxr95PvZqGVA/Rv/bGJcGED1/RaLBho9dM
         Swar4jUp1HYKUibb56i1GGzNI8jTWYhBbkAbd796pZOQS6qb80L9ebdF6xHWXpw6yHVy
         cSViS5kYHzCZiPLfCbC1TWfpWYK6aaxNW/oN0ZIfXWVJyDFQBTlNI6s3m9VdVrFgU3eu
         u0jHpp92tikryYjMdPJQGsRgs191grtSFuTcchhJPvdXPOhwq6/pLbPWw1vyBBOJA528
         5Qww==
X-Received: by 10.68.100.98 with SMTP id ex2mr9410054pbb.19.1369248248515;
        Wed, 22 May 2013 11:44:08 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id xl10sm9123446pac.15.2013.05.22.11.44.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 11:44:07 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MIi6cw027301;
        Wed, 22 May 2013 11:44:06 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MIi5aJ027300;
        Wed, 22 May 2013 11:44:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v5 6/6] mips/kvm: Use ENOIOCTLCMD to indicate unimplemented ioctls.
Date:   Wed, 22 May 2013 11:43:56 -0700
Message-Id: <1369248236-27237-7-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36537
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

The Linux Way is to return -ENOIOCTLCMD to the vfs when an
unimplemented ioctl is requested.  Do this in kvm_mips instead of a
random mixture of -ENOTSUPP and -EINVAL.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/kvm_mips.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 5aec4f4..13e9438 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -195,7 +195,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 long
 kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 void kvm_arch_free_memslot(struct kvm_memory_slot *free,
@@ -401,7 +401,7 @@ int
 kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 				    struct kvm_guest_debug *dbg)
 {
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
@@ -475,14 +475,14 @@ int
 kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				struct kvm_mp_state *mp_state)
 {
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 int
 kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				struct kvm_mp_state *mp_state)
 {
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 #define KVM_REG_MIPS_CP0_INDEX (0x10000 + 8 * 0 + 0)
@@ -799,7 +799,7 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 
 	switch (ioctl) {
 	default:
-		r = -EINVAL;
+		r = -ENOIOCTLCMD;
 	}
 
 	return r;
@@ -827,13 +827,13 @@ void kvm_arch_exit(void)
 int
 kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	return -ENOTSUPP;
+	return -ENOIOCTLCMD;
 }
 
 int
 kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
-	return -ENOTSUPP;
+	return -ENOIOCTLCMD;
 }
 
 int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
@@ -843,12 +843,12 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	return -ENOTSUPP;
+	return -ENOIOCTLCMD;
 }
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	return -ENOTSUPP;
+	return -ENOIOCTLCMD;
 }
 
 int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
-- 
1.7.11.7
