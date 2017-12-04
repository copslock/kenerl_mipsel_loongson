Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 21:42:40 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:35999
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994628AbdLDUgQVa-B6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 21:36:16 +0100
Received: by mail-wm0-x242.google.com with SMTP id b76so16708335wmg.1
        for <linux-mips@linux-mips.org>; Mon, 04 Dec 2017 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=christofferdall-dk.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w7+JCGDxXqRgNaEBotBwTBmOyxryFF6QgFJkBNxEQw0=;
        b=h/dh5LaopPGXmYs8XtM+73ZeJb3p91UMamvk5JbgHsFslqpln0UfNl/vuiKODM0zsP
         w4M1VXrPaRGL9EMjKTVhwwgeDSnuK0+2MDNndtzx/DoM6fwdW6MwGi28TdlqEdWtDpJ8
         WdaPwDZR3L3o90CCMf3CsJmWIZ0lmyoVVpdEmDP1s3EuVstFweGq3vxDtgL48JXHZ6iO
         W0P3DJ98RAgk0oTvfbv5S2Dz+aI8vohuuMatIgOjn0q+Z5p/LvFvfMlTcNcKF4i/ZEod
         NNN14AvyYEvalrE0zfeLoL5kIUOOjC2mii7aYAQ5vm9dsljj3gSg+7XyNJPrG0tv5g/v
         qt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=w7+JCGDxXqRgNaEBotBwTBmOyxryFF6QgFJkBNxEQw0=;
        b=mqXTVHgvnLBv9m1EugQq7Tir8TWQTeBadmEC8vfRf7Bgc5veHafF3qoB/7A6n8fr91
         R2ooDTSH54+M3y1SJXaNQTeYELrTyvWgnKeUoFgPhcdksA8zMBFtPaUrO5DQLFZuzcU3
         Hp8F2V29s84RhBx/vEZkWpYcT7iVTDY7lyuzL52A5eVJrbv5scwEPTTc8MFMTkhoZ4XR
         fZyZuP2LO2mK86XoGlG1wwlYQ/Q3LwF2k+NCYLMPNgcM0k0RovF03CT03WH7FIoQTRs2
         Wxck4fYT52Uhg+KhJMIbNsI2530un3itEuQzKltzVxmVyIijs7f1MNDwbqqh9PiwAeJn
         x/iA==
X-Gm-Message-State: AJaThX7TDOV350CGiyDQ0c/rqBN0sTD2jBUfnq6wR6GlYRyy1lsjgX4r
        uj02qNJJUFyhEXYXQXka0Y0TYw==
X-Google-Smtp-Source: AGs4zMZ6Y4WDcT4SznLIfPz97t6CterTEhftdBUtiB25cG0lA6iTH2+99q2DmJh3M7dXw2PkpRJuwQ==
X-Received: by 10.80.137.244 with SMTP id h49mr32741666edh.303.1512419771048;
        Mon, 04 Dec 2017 12:36:11 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id k42sm8434943edb.94.2017.12.04.12.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 12:36:10 -0800 (PST)
From:   Christoffer Dall <cdall@kernel.org>
To:     kvm@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: [PATCH v3 16/16] KVM: arm/arm64: Move vcpu_load call after kvm_vcpu_first_run_init
Date:   Mon,  4 Dec 2017 21:35:38 +0100
Message-Id: <20171204203538.8370-17-cdall@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Return-Path: <christofferdall@christofferdall.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cdall@kernel.org
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

From: Christoffer Dall <christoffer.dall@linaro.org>

Moving the call to vcpu_load() in kvm_arch_vcpu_ioctl_run() to after
we've called kvm_vcpu_first_run_init() simplifies some of the vgic and
there is also no need to do vcpu_load() for things such as handling the
immediate_exit flag.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c     |  4 ----
 virt/kvm/arm/arm.c            | 12 +++++-------
 virt/kvm/arm/vgic/vgic-init.c | 11 -----------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 4151250ce8da..801fecfee299 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -839,11 +839,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 		return ret;
 
 no_vgic:
-	preempt_disable();
 	timer->enabled = 1;
-	kvm_timer_vcpu_load_vgic(vcpu);
-	preempt_enable();
-
 	return 0;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a760ef1803be..991f1aa70fb9 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -622,8 +622,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
-	vcpu_load(vcpu);
-
 	ret = kvm_vcpu_first_run_init(vcpu);
 	if (ret)
 		goto out;
@@ -631,13 +629,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-	if (run->immediate_exit) {
-		ret = -EINTR;
-		goto out;
-	}
+	if (run->immediate_exit)
+		return -EINTR;
+
+	vcpu_load(vcpu);
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 62310122ee78..a0688ef52ad7 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -300,17 +300,6 @@ int vgic_init(struct kvm *kvm)
 
 	dist->initialized = true;
 
-	/*
-	 * If we're initializing GICv2 on-demand when first running the VCPU
-	 * then we need to load the VGIC state onto the CPU.  We can detect
-	 * this easily by checking if we are in between vcpu_load and vcpu_put
-	 * when we just initialized the VGIC.
-	 */
-	preempt_disable();
-	vcpu = kvm_arm_get_running_vcpu();
-	if (vcpu)
-		kvm_vgic_load(vcpu);
-	preempt_enable();
 out:
 	return ret;
 }
-- 
2.14.2
