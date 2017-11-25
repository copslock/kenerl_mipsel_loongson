Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 21:59:26 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:34294
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbdKYU5ZdyYu6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:25 +0100
Received: by mail-wr0-x242.google.com with SMTP id k18so18070795wre.1
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ny0zQ+6naqJMxg1v/kJ/YPA9h7EUYTci1EyO77zJsR4=;
        b=g2ViyK/MzyoMoEFdnbmi+BqUN99BcKKbMU9UGchF6f3YdwajaaLqfhSknHJWrwuWr1
         KnOx3SYfZuSnecQ8TP2Zw8QCA9Qj0ZyPQiWnQD83vN446kSkSAD8PG0v7bNOoXTiNXvn
         a/GhPf7HLEHwDpNozQeFtr7L8JyWsoRqIKxU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ny0zQ+6naqJMxg1v/kJ/YPA9h7EUYTci1EyO77zJsR4=;
        b=EX2kx+nLPSpHPV/EEZ0fTD1XXrWTJcbxZO7nCRhqi0KjsAi19hWj5P3YFbKKy6oxwb
         P7DGfhnY7epzGMORSTuuGhbmX29YcqzgnARUyIdzDIEgC3eVVM7FWEmgHEXT89jO1Zut
         wFly7709I2xL+BzKj8CLMJ94Iplo+v730fvyzE+FD2JtcQWsq8p5vvmQK25sT0Jgs5Kv
         rzHkS8xVpGaqxCZwglOxYi7J/V3HOFZsVxFsv9ZafHOunW9rWuWCLqXtH7riQIdNURHx
         y/Iq7/DAgbUIxguauc1WU0uk8pyw2lCUP1pIO1VXdp0rAZQgfVzHoFAY/OO2d8tceUkO
         n+OQ==
X-Gm-Message-State: AJaThX7btw+HqoA46z386Wg9yGBNCY/WlVc26G2Ou1K2gjL47v6FU1On
        zkNvCizAhZBl/HwzYHaleIyBtw==
X-Google-Smtp-Source: AGs4zMYKFb7fmiNucBb/gPEXoeTfF7v4CWcLVQpmvh7FdcTHeVDk69ZDD8AA9Q23TTlyIBt1D9gGoQ==
X-Received: by 10.223.202.1 with SMTP id o1mr29369757wrh.233.1511643440219;
        Sat, 25 Nov 2017 12:57:20 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:19 -0800 (PST)
From:   Christoffer Dall <christoffer.dall@linaro.org>
To:     kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: [PATCH 05/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
Date:   Sat, 25 Nov 2017 21:57:08 +0100
Message-Id: <20171125205718.7731-6-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christoffer.dall@linaro.org
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

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_set_regs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c      | 6 ++++++
 arch/powerpc/kvm/book3s.c | 6 ++++++
 arch/powerpc/kvm/booke.c  | 6 ++++++
 arch/s390/kvm/kvm-s390.c  | 6 ++++++
 arch/x86/kvm/x86.c        | 7 +++++++
 virt/kvm/kvm_main.c       | 4 ----
 6 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 1cb1020e044f..55d2e6e2c4e6 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1153,8 +1153,13 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		vcpu->arch.gprs[i] = regs->gpr[i];
 	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
@@ -1162,6 +1167,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.lo = regs->lo;
 	vcpu->arch.pc = regs->pc;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 04cfe6749858..047d3178d70f 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -529,8 +529,13 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	kvmppc_set_pc(vcpu, regs->pc);
 	kvmppc_set_cr(vcpu, regs->cr);
 	kvmppc_set_ctr(vcpu, regs->ctr);
@@ -551,6 +556,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 19b6299a5aad..47b3d11345ed 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1464,8 +1464,13 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	vcpu->arch.pc = regs->pc;
 	kvmppc_set_cr(vcpu, regs->cr);
 	vcpu->arch.ctr = regs->ctr;
@@ -1487,6 +1492,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 51ad3c6fc694..eb2724d6e524 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2713,7 +2713,13 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	memcpy(&vcpu->run->s.regs.gprs, &regs->gprs, sizeof(regs->gprs));
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f6594eb2b3be..e4e34af97ba0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7329,6 +7329,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
 	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 
@@ -7358,6 +7364,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 759f3a1e042e..7671ebb5971f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2580,11 +2580,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
-		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
-- 
2.14.2
