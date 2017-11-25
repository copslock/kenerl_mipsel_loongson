Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 21:58:11 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:43128
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991120AbdKYU5UTAdt6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 21:57:20 +0100
Received: by mail-wm0-x242.google.com with SMTP id x63so27594692wmf.2
        for <linux-mips@linux-mips.org>; Sat, 25 Nov 2017 12:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=91VGEXMnBQngPYpeTzmCKazrW0+iJB8LM1lvpe7RajA=;
        b=PDyqZGJ/lIUNU+LsYwJGNsA/YKaajJxmUoLkwTP0aONjiVpFA9D8OeSbinxMxvwWaa
         PWKHK5thEIfL+/GEd9f2gcNx7Ny6HOf0xabyhf7zFOxrg8d3YHMBW0CLD1a5rl//Hyza
         IGJiHwyn8Bthv2KdK0vfjxSsodc0LBoLkokQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=91VGEXMnBQngPYpeTzmCKazrW0+iJB8LM1lvpe7RajA=;
        b=LFojZvFA+/Oa/e2ybAdzSbK9RuprR0+MLgICiOJtb9d+Aqa2qz8iJZsUhWJsYxOf1n
         ajMynuYleBXVQiPDCc+BNvDI4oyWD54GMF4ti32nfDU9Z2327gveGURktAt8gQ547zEL
         mMRdFsUNWtR4AQnSo4wtNT9YccR7wrSd69x8yqKYliXwBRZ75wnrjI9oaF8kSqkRxHAY
         n0tOPxORv+2RhMgkJ9hLFHI/uqC3kc0Q78LiqziZlOkZYZDc7arwtC4ng35A36WsevIN
         DBI8zUnaJmeEusE8jhHZaqHd4lqwt8hM5MM5V84wY+OEzYpx8P93yi7UvUtlsvplQQI1
         XNAg==
X-Gm-Message-State: AJaThX76uF+zp3j8n7PkAYOzQgoVyfOESDTM32dJXxC8PIJJQ3IC4hhA
        O1gtHMjZHomCze42w2sK1jGRyg==
X-Google-Smtp-Source: AGs4zMYCVEDBDrErrDrAgLYJ3ifjfaKubR2+zQQHO1qV4vWyu8tcJm+pYSghvfjVBdsRJmddmKyr7g==
X-Received: by 10.28.6.2 with SMTP id 2mr12557157wmg.37.1511643434971;
        Sat, 25 Nov 2017 12:57:14 -0800 (PST)
Received: from localhost.localdomain (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id z37sm15157577wrc.31.2017.11.25.12.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Nov 2017 12:57:14 -0800 (PST)
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
Subject: [PATCH 02/15] KVM: Factor out vcpu->pid adjustment for KVM_RUN
Date:   Sat, 25 Nov 2017 21:57:05 +0100
Message-Id: <20171125205718.7731-3-christoffer.dall@linaro.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61079
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

Every time userspace calls KVM_RUM, we check if another thread started
running the VCPU, and in that case, we adjust the vcpu->pid field to the
new thread.

We obviously only want to perform this logic once we hold the
vcpu->mutex and are actually going to run the VCPU.  As we are about to
move the vcpu_load() call into the architecture-specific implementation
of the ioctl, we first factor the pid adjustment logic out in its own
function which each architecture can call later on.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 28 +++++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538eda32..739a2f8e74c5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -536,6 +536,8 @@ void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 int __must_check vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
+void kvm_vcpu_run_adjust_pid(struct kvm_vcpu *vcpu);
+
 #ifdef __KVM_HAVE_IOAPIC
 void kvm_arch_post_irq_ack_notifier_list_update(struct kvm *kvm);
 void kvm_arch_post_irq_routing_update(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fafafcc38b5a..c9549d44c489 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2504,6 +2504,22 @@ static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 	return 0;
 }
 
+void kvm_vcpu_run_adjust_pid(struct kvm_vcpu *vcpu)
+{
+	struct pid *oldpid;
+
+	oldpid = rcu_access_pointer(vcpu->pid);
+	if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
+		/* The thread running this VCPU changed. */
+		struct pid *newpid = get_task_pid(current, PIDTYPE_PID);
+
+		rcu_assign_pointer(vcpu->pid, newpid);
+		if (oldpid)
+			synchronize_rcu();
+		put_pid(oldpid);
+	}
+}
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -2530,23 +2546,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
 
 	switch (ioctl) {
 	case KVM_RUN: {
-		struct pid *oldpid;
 		r = -EINVAL;
 		if (arg)
 			goto out;
 		r = vcpu_load(vcpu);
 		if (r)
 			goto out;
-		oldpid = rcu_access_pointer(vcpu->pid);
-		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
-			/* The thread running this VCPU changed. */
-			struct pid *newpid = get_task_pid(current, PIDTYPE_PID);
-
-			rcu_assign_pointer(vcpu->pid, newpid);
-			if (oldpid)
-				synchronize_rcu();
-			put_pid(oldpid);
-		}
+		kvm_vcpu_run_adjust_pid(vcpu);
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
 		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
-- 
2.14.2
