Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 18:52:34 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:53074 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835077Ab3EWQt2epFjJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 18:49:28 +0200
Received: by mail-pd0-f176.google.com with SMTP id r11so3085766pdi.21
        for <multiple recipients>; Thu, 23 May 2013 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZkswzmPe1DLYVbpIJim9vS1VNA8HSkvVY2ZtPcTd0/g=;
        b=dw5GU1PgVV1kjEB9xVQVlzDCWEognsyQ3xBVxMU3+jjigqVeLsK105MMV6xv4RWmaU
         /7XlpS70OT2YegGN+duz+h/05tKEA1FlaPS8UpKhb6L4Dpsu1j+IKIw2P39engO9mIPy
         fmvSiiC6adhg+BCJ+4YX91xVIdsJFVKIo5V9jnWhNZXqol+kP5npdk6FTFnRnxiDS9ch
         usCunC+/dkFOjkUQRasF7corQqUYjqlnbOHq8Q9CdMa+OdAZZz4NEwYyZe5E0KH9nORO
         huHmOA8jmKA3Dy88CGOITj518ksYZeRoB6CDn87dOnaMdEUM7pCnqVMDcqAiszWzTchf
         oKmw==
X-Received: by 10.68.244.72 with SMTP id xe8mr14030859pbc.51.1369327762007;
        Thu, 23 May 2013 09:49:22 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ea15sm13456564pad.16.2013.05.23.09.49.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 09:49:19 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4NGnG1Q028643;
        Thu, 23 May 2013 09:49:16 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4NGnGWK028642;
        Thu, 23 May 2013 09:49:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 6/6] mips/kvm: Use ENOIOCTLCMD to indicate unimplemented ioctls.
Date:   Thu, 23 May 2013 09:49:10 -0700
Message-Id: <1369327750-28580-7-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36562
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
Acked-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 3caa006..d934b01 100644
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
@@ -801,7 +801,7 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 
 	switch (ioctl) {
 	default:
-		r = -EINVAL;
+		r = -ENOIOCTLCMD;
 	}
 
 	return r;
@@ -829,13 +829,13 @@ void kvm_arch_exit(void)
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
@@ -845,12 +845,12 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
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
