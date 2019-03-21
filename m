Return-Path: <SRS0=ObrZ=RY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037EC43381
	for <linux-mips@archiver.kernel.org>; Thu, 21 Mar 2019 06:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9339E218A5
	for <linux-mips@archiver.kernel.org>; Thu, 21 Mar 2019 06:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfCUGE3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:04:29 -0400
Received: from mx.sdf.org ([205.166.94.20]:61064 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfCUGE3 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 21 Mar 2019 02:04:29 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2L64OKW000211
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Thu, 21 Mar 2019 06:04:25 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2L64Ord018045;
        Thu, 21 Mar 2019 06:04:24 GMT
Date:   Thu, 21 Mar 2019 06:04:24 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903210604.x2L64Ord018045@sdf.org>
To:     jhogan@kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH] arch/mips/kvm/emulate.c: Don't waste /dev/random emulating TLBWR
Cc:     lkml@sdf.org
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

KVM_MIPS_GUEST_TLB_SIZE is 64, so we only need one random byte,
not 4.

A more complex question is whether we need crypto-grade random
numbers at all.  If safe, we could use prandom_u32().  If not,
we could seed a private PRNG and use prandom_u32_state().

Or could we just use asm("mfc0 %0, Random" : "=r" (index))?

Signed-off-by: George Spelvin <lkml@sdf.org>
---
I ran across this whie doing some other cleanups, and thought
I'd pass it on.

get_random_bytes() is quite an expensive function call.
Is it needed at all?

 arch/mips/kvm/emulate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index ec9ed23bca7f..a689f3db3094 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1139,8 +1139,9 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_mips_tlb *tlb = NULL;
 	unsigned long pc = vcpu->arch.pc;
-	int index;
+	unsigned char index;
 
+	/* Do we need this quality of random numbers?  Would prandom_u32 do? */
 	get_random_bytes(&index, sizeof(index));
 	index &= (KVM_MIPS_GUEST_TLB_SIZE - 1);
 
-- 
2.20.1

