Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:46:53 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:42406
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991550AbdK2Qlqgv5Ma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:41:46 +0100
Received: by mail-wm0-x244.google.com with SMTP id l141so7615358wmg.1
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SDbGekwTGfPeOtIY2YvyvCh3khoLc38Ey9F55tV3OzA=;
        b=TUA1xHVmPw6HhIspyafTM96ZBHoTQSAHY5W1ESq/GTA4WsfUbAoIDQkpnCcKR4sRhR
         tu46FTdPCHtq9jCaUphotAC2FwxcaCIFu9QarRPQdLZp2NCEmngmL8FIVQtTbLshfkXR
         Ziqt3qlSF1f81sRK35uiIAstpAiHybKenNUKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SDbGekwTGfPeOtIY2YvyvCh3khoLc38Ey9F55tV3OzA=;
        b=tpdT2rllC51DNV7HGSAmwOFmZ+smtDmqaaWS+ohydSPVxpFCIcQSOU7nGUtIZm+3gg
         cAEoOYgsZe2tGroyubFc0fhXHr7F0jnT4i82GvmTtszaLg7eBZgkNycLdHjBkWHzidPD
         6F7TkuXXtB2bykHzvz8KV8RJgoTDiJpAZi2s5xY26Z53Ci0xtMobKb0rZ3JiAjLhBg9K
         v7TkOrtEexgeCNYHCPnVqEaaQoKbPSBvN3iqX8E1if4XztSFW1VxNmcx1z0XeDXkZ3Bo
         syR1uXnXfMZXtSPmqf5BmR/wb/rixTZ6i0Tt//S/z5ME3Wxx36Gw7GjM0TwSr9OcR0sp
         EfEA==
X-Gm-Message-State: AJaThX4p+se2q47ZILquESIDMexWjnoE5zgTrD1J593M82fdUA3FmuxI
        yhQjLp/11Z6nid7TeJO0K93/FQ==
X-Google-Smtp-Source: AGs4zMYdR7I998I3tymksI+Ie8LeJ8RwXeP+fEHp9QltLrFMUtAVaZ77xHguNx/isHjkk/Qg6zuZUA==
X-Received: by 10.28.12.75 with SMTP id 72mr2872353wmm.133.1511973701269;
        Wed, 29 Nov 2017 08:41:41 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e71sm2080765wma.13.2017.11.29.08.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 08:41:40 -0800 (PST)
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
Subject: [PATCH v2 13/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
Date:   Wed, 29 Nov 2017 17:41:13 +0100
Message-Id: <20171129164116.16167-14-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61206
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
implementations of kvm_arch_vcpu_ioctl_set_fpu().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 15 ++++++++++++---
 arch/x86/kvm/x86.c       |  8 ++++++--
 virt/kvm/kvm_main.c      |  2 --
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 88dcb89..43278f3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2752,15 +2752,24 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	if (test_fp_ctl(fpu->fpc))
-		return -EINVAL;
+	int ret = 0;
+
+	vcpu_load(vcpu);
+
+	if (test_fp_ctl(fpu->fpc)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
 				 (freg_t *) fpu->fprs);
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
-	return 0;
+
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8b54567..fd8b92f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7699,8 +7699,11 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	struct fxregs_state *fxsave;
+
+	vcpu_load(vcpu);
+
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd = fpu->fcw;
@@ -7711,6 +7714,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->rdp = fpu->last_dp;
 	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 73ad70a..06751bb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2689,9 +2689,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		break;
 	}
 	default:
-- 
2.7.4
