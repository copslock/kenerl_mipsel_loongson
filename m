Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 18:51:34 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:59567 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835071Ab3EWQt1B22X1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 18:49:27 +0200
Received: by mail-pb0-f50.google.com with SMTP id wy17so3133401pbc.37
        for <multiple recipients>; Thu, 23 May 2013 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5Hg5/wh82XV2iuYYkJCDDyjN8KNUnedAkxyJfJPluj0=;
        b=0HUpaEcm8rEREpH7jK5DiY55JxWirDWQ5uRprTZzOIPXPhsQDC6fmJ46TLBlxnH9oo
         x4xaAG0bzIgKlDp/r9CbzciSauXMedYxP64SR7KMC2BAOuniXDTaj5apUg4TPKjXZHYh
         38uyNP0bM7y+8x5UnCqFdqJ2a9fQNzAHUJRP/Ekl4jeWLcjMgZhULlDMyJRuSMx/5d7S
         hdpB6eg8bavziXMRwQP7twRjjfYMRFGdVYxTU9vCDBp2gK3JRFxJK9jpNPhb83HnKJgw
         HCLQnkD7pHHtc2kPzSwjv4c7KTOVL+IhTl1vYj0wfvyENRkkzfNjLC6i7qO2XvffqK+x
         zCDg==
X-Received: by 10.68.99.163 with SMTP id er3mr14025973pbb.36.1369327760471;
        Thu, 23 May 2013 09:49:20 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id aj2sm12419645pbc.1.2013.05.23.09.49.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 09:49:17 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4NGnFQV028635;
        Thu, 23 May 2013 09:49:15 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4NGnFYV028634;
        Thu, 23 May 2013 09:49:15 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 4/6] mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in kvm_arch_vcpu_ioctl_{s,g}et_regs
Date:   Thu, 23 May 2013 09:49:08 -0700
Message-Id: <1369327750-28580-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36560
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

Also we cannot set special zero register, so force it to zero.

Signed-off-by: David Daney <david.daney@cavium.com>
Acked-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 93da750..71a1fc1 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -677,9 +677,9 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	for (i = 0; i < 32; i++)
+	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		vcpu->arch.gprs[i] = regs->gpr[i];
-
+	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
 	vcpu->arch.hi = regs->hi;
 	vcpu->arch.lo = regs->lo;
 	vcpu->arch.pc = regs->pc;
@@ -691,7 +691,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	for (i = 0; i < 32; i++)
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		regs->gpr[i] = vcpu->arch.gprs[i];
 
 	regs->hi = vcpu->arch.hi;
-- 
1.7.11.7
