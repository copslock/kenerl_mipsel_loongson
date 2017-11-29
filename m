Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:43:34 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:36008
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990740AbdK2QlcuseGa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:32 +0100
Received: by mail-wm0-x242.google.com with SMTP id b76so7247147wmg.1
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dc+K6GcI8JciAx3+9nFGUD/9jiDe0Rr3SUqjuPfgac0=;
        b=gGVSkV4FpQdzCsTJVbXNgsraWua0ZRqIaxFy1fzKxGf6gASTOezngQkQ5gXfjh0rDk
         VpfWRRzUvwu1fiHAuTHD1HzlFat5y5F3k43LMjQHWpuGaWb1rcpRa6BP6aNv5xe5kSEx
         hLcH8IEOJ8m9kPKvB2xxEGDkbE4fC5K5BfwIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dc+K6GcI8JciAx3+9nFGUD/9jiDe0Rr3SUqjuPfgac0=;
        b=bWsK+9DpNdZKRDZys3RGSNmigS7qXcA3G4cX/75h1hpb54FlPrlYdAN4Ffbr+Er+hS
         IUJmqMr/Bw574f9s7U/rYYleDIUF7D1tN9xMPB9q75ejHBJt6/qxsdbeKACppjZgZeZn
         s/lwCBnF8xP5xu3Sjs2SwIwvJ9vtff8thlgUT4/y2bbvUFFE+dlZZpYmFVwfGdXhBFiI
         Cz2jinYvWjys99CCxa1shipDSOfaBlJJCyqIIo9l5F+XgJGEnUrDbL1mfVTbGDflgDaN
         YNkWep8zfuVR6y+Rpdn2RveRhD9XfSbXunjtYQCQFBltK98tANfkTQXf3vhNXGRdVAL8
         +ynw==
X-Gm-Message-State: AJaThX5zJ/xd1KSJLNsSx+S/veDPqSRT4G4m3KRglpZZYN0EZ0gLUHYI
        auRvDlDyqU7N2pYTpfyzCKO4hg==
X-Google-Smtp-Source: AGs4zMZdqKqMX+FdFk5QlHszN/MlwPcqcizYnHgHv421QbmgjGhH+UExirxxyySb7D7rYZaGtHr0ag==
X-Received: by 10.28.31.131 with SMTP id f125mr2776759wmf.18.1511973687444;
        Wed, 29 Nov 2017 08:41:27 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:26 -0800 (PST)
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
Subject: [PATCH v2 05/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
Date:   Wed, 29 Nov 2017 17:41:05 +0100
Message-Id: <20171129164116.16167-6-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61198
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
 arch/mips/kvm/mips.c      | 3 +++
 arch/powerpc/kvm/book3s.c | 3 +++
 arch/powerpc/kvm/booke.c  | 3 +++
 arch/s390/kvm/kvm-s390.c  | 2 ++
 arch/x86/kvm/x86.c        | 3 +++
 virt/kvm/kvm_main.c       | 2 --
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index adfca57..3a89871 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1151,6 +1151,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		vcpu->arch.gprs[i] = regs->gpr[i];
 	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
@@ -1158,6 +1160,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.lo = regs->lo;
 	vcpu->arch.pc = regs->pc;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index d85bfd7..24bc7aa 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -528,6 +528,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	kvmppc_set_pc(vcpu, regs->pc);
 	kvmppc_set_cr(vcpu, regs->cr);
 	kvmppc_set_ctr(vcpu, regs->ctr);
@@ -548,6 +550,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index e0e4f04..bcbbedd 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1462,6 +1462,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
+	vcpu_load(vcpu);
+
 	vcpu->arch.pc = regs->pc;
 	kvmppc_set_cr(vcpu, regs->cr);
 	vcpu->arch.ctr = regs->ctr;
@@ -1483,6 +1485,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 37b7caa..e347643 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2712,7 +2712,9 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	vcpu_load(vcpu);
 	memcpy(&vcpu->run->s.regs.gprs, &regs->gprs, sizeof(regs->gprs));
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 597e1f8..75eacce 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7350,6 +7350,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	vcpu_load(vcpu);
+
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
 	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 
@@ -7379,6 +7381,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 843d481..963e249 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2572,9 +2572,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
-		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
-- 
2.7.4
