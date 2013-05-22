Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 20:45:53 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34155 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835059Ab3EVSoO32m1y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 20:44:14 +0200
Received: by mail-pa0-f43.google.com with SMTP id hz10so2105052pad.30
        for <multiple recipients>; Wed, 22 May 2013 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c9BSCB1NujibP7eUFGiq2gccKrGQoppYXygvsMvfjNA=;
        b=OynWpIcv8wl5LtZllWP8fAdU9A9CIz+PAD/2R4vT4uI3kOCqNe+TfR9EnQ1ESzfRqI
         P+YBH31d+uhkP/thNEwUE72iYg6nN+duRXHyuoDL/2Ngfu0PLK/eq3T7zAr5eu2BSwdc
         ftxdycwC7YEjB0N9u9lzNShlySYHocdjpZ4t4Lhd4++Wix0QTXD0vyvetUOTgMOweu3T
         mLGuD/9/szrgOddkz3nmNjXq06E2fqjFwy0i3GeZHEbVP5VfhqBw3pOWIBgGay2KKfM6
         G7pdkv6mz+dhkywNrUd+dI0C1SLefyuAuzs0uNYXqgAUBY8HjQkIVtba5LHaWf6I4zuv
         r4KQ==
X-Received: by 10.66.188.137 with SMTP id ga9mr9802013pac.9.1369248247957;
        Wed, 22 May 2013 11:44:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id do4sm8256518pbc.8.2013.05.22.11.44.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 11:44:07 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MIi54M027293;
        Wed, 22 May 2013 11:44:05 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MIi5XI027292;
        Wed, 22 May 2013 11:44:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v5 4/6] mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in kvm_arch_vcpu_ioctl_{s,g}et_regs
Date:   Wed, 22 May 2013 11:43:54 -0700
Message-Id: <1369248236-27237-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36535
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
