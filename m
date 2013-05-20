Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 23:13:00 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51590 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825665Ab3ETVMHgnduK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 23:12:07 +0200
Received: by mail-pd0-f173.google.com with SMTP id v10so5775135pde.4
        for <multiple recipients>; Mon, 20 May 2013 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=c9BSCB1NujibP7eUFGiq2gccKrGQoppYXygvsMvfjNA=;
        b=XT2Vr3YEH5T4id5CoiF3KC+i4/3Lcuearx0D53VMgYAFt7iytmLX8vFW6j4dh2bdlA
         nzZBm+5axBc8D2a7lCrcUKQ8czEDZp66xE2AltDfPurW+9oTLz9/hPFruuqnJMD7UWOS
         ORh8jAcwITexbLwIijoHscjGTdNfVOGhwO6pDykWPKU+BGrb09Mg6REDRAVdVY8vc7IJ
         +39VuMoVnryxE9HwrBawVvt0dR+eizCeXIDY7W6RJG3YZI3/tRtW9FUN244ubzlc/+MO
         bivZQJpjGZdggeV96a/KP2dJ30MrzMnY47EF6gVgyc01ZI/FZWBhwe12gLPOkL1hkKcc
         RQaw==
X-Received: by 10.68.137.74 with SMTP id qg10mr61916382pbb.172.1369084321078;
        Mon, 20 May 2013 14:12:01 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id t1sm46698pab.12.2013.05.20.14.11.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 14:11:59 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4KLBvgU027919;
        Mon, 20 May 2013 14:11:57 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4KL1UCh027565;
        Mon, 20 May 2013 14:01:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 4/5] mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in kvm_arch_vcpu_ioctl_{s,g}et_regs
Date:   Mon, 20 May 2013 14:01:25 -0700
Message-Id: <1369083686-27524-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36492
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
