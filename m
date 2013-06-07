Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:05:24 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:54049 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835084Ab3FGXDxVmf7E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:53 +0200
Received: by mail-ie0-f173.google.com with SMTP id k5so5443804iea.4
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+TvDyBNi/P/JTzYJ7fXpVlJ2POS24pUA5/sXlaxS1f8=;
        b=HKq11ol5q5PlSFbXm5vnLG4hxfzuVd9oPllGT+1mTckvB409Ff6XZCBLhRb1oJoQ6P
         dggoreG9loMfU45PXott6P5Uc9T5EvD2uljYGVzlzZ0mFnNZZTrA5KCEbI3SjMS6zK0Y
         LcvzJoYrpudYlDK7E6o5gqY9jfY47A5TM1t9AN3XQ5mlIu/N780mF01mTjfgylBU6uah
         kucRDwBr0TNUc+Vf57jlozTGw5QRwr4jGkmqxaVqe7H9CkTMK1lc/hB6ElHQBT2UoE/Z
         O6BVrnOTc785Kq7E1xxnVMa+rhqpBBG7C5mYHiMh0SZh2rkGTQOesPnWVy+c/4F0AqtV
         nkzQ==
X-Received: by 10.50.82.98 with SMTP id h2mr2323185igy.33.1370646227214;
        Fri, 07 Jun 2013 16:03:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id l14sm1145857igf.9.2013.06.07.16.03.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:46 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3ipc006630;
        Fri, 7 Jun 2013 16:03:44 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3i4m006629;
        Fri, 7 Jun 2013 16:03:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 05/31] mips/kvm: Use generic cache flushing functions.
Date:   Fri,  7 Jun 2013 16:03:09 -0700
Message-Id: <1370646215-6543-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36723
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

We don't know if we have the r4k specific functions available, so use
universally available __flush_cache_all() instead.  This takes longer
as it flushes both i-cache and d-cache, but is available for all CPUs.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/kvm_mips_emul.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index af9a661..a2c6687 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -916,8 +916,6 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 		       struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
-	extern void (*r4k_blast_dcache) (void);
-	extern void (*r4k_blast_icache) (void);
 	enum emulation_result er = EMULATE_DONE;
 	int32_t offset, cache, op_inst, op, base;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
@@ -954,9 +952,9 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 		     arch->gprs[base], offset);
 
 		if (cache == MIPS_CACHE_DCACHE)
-			r4k_blast_dcache();
+			__flush_cache_all();
 		else if (cache == MIPS_CACHE_ICACHE)
-			r4k_blast_icache();
+			__flush_cache_all();
 		else {
 			printk("%s: unsupported CACHE INDEX operation\n",
 			       __func__);
-- 
1.7.11.7
