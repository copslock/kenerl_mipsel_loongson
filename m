Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 22:56:40 +0200 (CEST)
Received: from mail-da0-f43.google.com ([209.85.210.43]:42391 "EHLO
        mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835045Ab3EUUzLaPEgU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 22:55:11 +0200
Received: by mail-da0-f43.google.com with SMTP id u7so672691dae.2
        for <multiple recipients>; Tue, 21 May 2013 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c9BSCB1NujibP7eUFGiq2gccKrGQoppYXygvsMvfjNA=;
        b=FivCqQ/VqOA/rMq8o5TWjRmF/QypFQ3N5jpuV+zHT4sqkHHlGH880cP30ee3D4jApv
         jSf8JbUxCaAbFfjHii29ikU1bJLFia61G/DLvlzqbjeNro0VIgM6riB/RjUgl4QtrjFn
         FMPPf/oZx8qqnSpJ9cKgjSGe9dj19e/jYRe6yAiAWr/s+5eoP8inLDgH8+LZzd7b0XLg
         hOWms/xJe5NliC8ldGcVVflT0l64Y+74PFhnNjnPyzgE78TpJeBw4kER4yx0eP//yLRq
         GpC3w2aK/wvahrPYp6vYQ9zoqbALDUV86vHMBo2penb3s264DZ+44FSjeeYwKd0QS5I/
         k3yw==
X-Received: by 10.68.197.66 with SMTP id is2mr4477109pbc.175.1369169704954;
        Tue, 21 May 2013 13:55:04 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qi1sm4710859pac.21.2013.05.21.13.55.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 13:55:03 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4LKt020010499;
        Tue, 21 May 2013 13:55:00 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4LKt0YV010498;
        Tue, 21 May 2013 13:55:00 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v4 4/6] mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in kvm_arch_vcpu_ioctl_{s,g}et_regs
Date:   Tue, 21 May 2013 13:54:53 -0700
Message-Id: <1369169695-10444-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36511
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
