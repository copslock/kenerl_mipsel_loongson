Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 22:57:26 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:62697 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835044Ab3EUUzMqY4n2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 22:55:12 +0200
Received: by mail-pd0-f169.google.com with SMTP id y11so1018312pdj.28
        for <multiple recipients>; Tue, 21 May 2013 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=evALR8WiLRaUhTvxnR+Vjcs1Q4nUbzqFXjkZpToRGg4=;
        b=nCC51GYwERxfyIGGa7tEMWw2W6on26dZLckrwYrSTtYy/4yUjOSGT4OZBX4DzVYLv6
         ShMmY6MMVgHysavPox7YQwryAZeyzPdvShYaC3qMj+/spMJ1Pa/E+SXMx5TasQC3lxeD
         EDEaswJA409C5sh5wjKV9OiNzEPk/5F4ElpjJ0DwIr+jlnrwmCK5+w4Ea4jl/P9cixqq
         S0FYBpyd6tbI/JZbY8FT6rk0ezLRM0kHcISBnF/o4ccXst4hMQ3OLCQ3fm2YG6N34iDF
         kkJd/qgB4VPSHI/v3PvuLRVR8dy6gNWH1O5A0n231iu5OZ5Nj8q1oJuVk6HmgYBXajTW
         /qZA==
X-Received: by 10.66.26.226 with SMTP id o2mr4883670pag.180.1369169705601;
        Tue, 21 May 2013 13:55:05 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vm10sm4765567pab.5.2013.05.21.13.55.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 13:55:03 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4LKt0Lb010507;
        Tue, 21 May 2013 13:55:00 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4LKt0U2010506;
        Tue, 21 May 2013 13:55:00 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v4 6/6] mips/kvm: Use ENOIOCTLCMD to indicate unimplemented ioctls.
Date:   Tue, 21 May 2013 13:54:55 -0700
Message-Id: <1369169695-10444-7-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36513
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
index bc879bd..8ea4bc5 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -185,7 +185,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 long
 kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 void kvm_arch_free_memslot(struct kvm_memory_slot *free,
@@ -391,7 +391,7 @@ int
 kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 				    struct kvm_guest_debug *dbg)
 {
-	return -EINVAL;
+	return -ENOIOCTLCMD;
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
@@ -429,14 +429,14 @@ int
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
 
 /*
@@ -483,7 +483,7 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 
 	switch (ioctl) {
 	default:
-		r = -EINVAL;
+		r = -ENOIOCTLCMD;
 	}
 
 	return r;
@@ -511,13 +511,13 @@ void kvm_arch_exit(void)
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
@@ -527,12 +527,12 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
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
