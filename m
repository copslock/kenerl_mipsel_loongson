Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 10:15:39 +0100 (CET)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:43088
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992554AbeKHJPgmRTd9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 10:15:36 +0100
Received: by mail-pl1-x642.google.com with SMTP id g59-v6so9254857plb.10;
        Thu, 08 Nov 2018 01:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BZQ//cVaU9tNuNQAUhzd/1Jm0JpGnlnc9pX5EOH8jfE=;
        b=LxIFTCt/GTcyxU0v9nk4twJxEGVigy1BlU2eCQPGqVBOUFZaAlHLG32Ki6yJcGNp/s
         xPuN5EnahHYlwz4TQ5jIcInfJ9az7mLvFgNuxRiU30b6aj2+u/60bs+5Q26rAKVSHhK+
         sNgWw+l55/iP7cf8hrj3jUuSQjqh4ZEdq9r6CKTj9oeYH8xmR56eUgINLkkc1G9SmSic
         ITdNvpD+CaRbBHfsPGhc76nDGi58sL/Tu/DUhBbg6YSGJVEugPvCqoU1jK18V00xzKX0
         +5j8Wj4Uy+5p0MpVftDhSgLtHvILx8dMaugq0NghFzrFbix6ZnUojwtP1vcGr8lb84fj
         JpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BZQ//cVaU9tNuNQAUhzd/1Jm0JpGnlnc9pX5EOH8jfE=;
        b=MWJqpPs3whWJoH+eYXovvVBU/YMW761iJJc5VQ/ePCa6wpQSXwA5m3oHE5IZOPK2+g
         K6+Yn0WDONXfNExyB+kQA7zggOScC/hzyOQkPYQMWUHkhqQqgq7kEPm8towC0/bq9xqF
         /qIO3qzEuCJW65cM5JZv1Ch+NOJT3PgbLC6qD//Xh2OyBYDNJQiPoqVwk1Owd4RWMTAO
         1iato1ZmQl1LmWPATTRc6pxJiOhERj66fM6UQ34xd10QOk3lGlWlHMQHFbKqZv/QkegV
         hRMiCCdcWWTLzHA4z27TgV2iklFK/5ujGMZNrrR6+0Oqw3/L2JvPN1v7b4RrQq4aMdQv
         aIEw==
X-Gm-Message-State: AGRZ1gKIISIyIPgBZTrEjCy9gRE/6gK7wPy4C5N8PEIv7q80em1Kk5hl
        Rfoz9o/rbL5ge+GVsZwUKow=
X-Google-Smtp-Source: AJdET5cjj8OCQlI0d0gch8uRXb7ma45QoRkvqCHNOyOIR5/cXRrSxwKM/LBAsOiq6x1ABZ8iRqn4JQ==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr3812752pln.129.1541668535729;
        Thu, 08 Nov 2018 01:15:35 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id w66-v6sm3284114pfb.51.2018.11.08.01.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:15:35 -0800 (PST)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V5 4/10] KVM/VMX: Add hv tlb range flush support
Date:   Thu,  8 Nov 2018 17:14:41 +0800
Message-Id: <20181108091447.8275-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
References: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <ltykernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ltykernel@gmail.com
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

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to register tlb_remote_flush_with_range callback with
hv tlb range flush interface.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v4:
	- Use new function kvm_fill_hv_flush_list_func() to fill flush
       request.
Change since v3:
	- Merge Vitaly's don't pass EPT configuration info to
vmx_hv_remote_flush_tlb() fix.
Change since v1:
	- Pass flush range with new hyper-v tlb flush struct rather
       than KVM tlb flush struct.
---
 arch/x86/kvm/vmx.c | 69 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index edbc96cb990a..405dfbde70b2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1567,7 +1567,38 @@ static void check_ept_pointer_match(struct kvm *kvm)
 	to_kvm_vmx(kvm)->ept_pointers_match = EPT_POINTERS_MATCH;
 }
 
-static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
+int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
+		void *data)
+{
+	struct kvm_tlb_range *range = data;
+
+	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+			range->pages);
+}
+
+static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_vcpu *vcpu, struct kvm_tlb_range *range)
+{
+	u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
+
+	/* If ept_pointer is invalid pointer, bypass flush request. */
+	if (!VALID_PAGE(ept_pointer))
+		return 0;
+
+	/*
+	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs address
+	 * of the base of EPT PML4 table, strip off EPT configuration
+	 * information.
+	 */
+	if (range)
+		return hyperv_flush_guest_mapping_range(ept_pointer & PAGE_MASK,
+				kvm_fill_hv_flush_list_func, (void *)range);
+	else
+		return hyperv_flush_guest_mapping(ept_pointer & PAGE_MASK);
+}
+
+static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
 {
 	struct kvm_vcpu *vcpu;
 	int ret = -ENOTSUPP, i;
@@ -1577,30 +1608,23 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 	if (to_kvm_vmx(kvm)->ept_pointers_match == EPT_POINTERS_CHECK)
 		check_ept_pointer_match(kvm);
 
-	/*
-	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
-	 * base of EPT PML4 table, strip off EPT configuration information.
-	 * If ept_pointer is invalid pointer, bypass the flush request.
-	 */
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
-		kvm_for_each_vcpu(i, vcpu, kvm) {
-			if (!VALID_PAGE(to_vmx(vcpu)->ept_pointer))
-				return 0;
-
-			ret |= hyperv_flush_guest_mapping(
-				to_vmx(vcpu)->ept_pointer & PAGE_MASK);
-		}
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			ret |= __hv_remote_flush_tlb_with_range(
+					kvm, vcpu, range);
 	} else {
-		if (!VALID_PAGE(to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer))
-			return 0;
-
-		ret = hyperv_flush_guest_mapping(
-			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+		ret = __hv_remote_flush_tlb_with_range(kvm,
+				kvm_get_vcpu(kvm, 0), range);
 	}
 
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 	return ret;
 }
+
+static int hv_remote_flush_tlb(struct kvm *kvm)
+{
+	return hv_remote_flush_tlb_with_range(kvm, NULL);
+}
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
@@ -7957,8 +7981,11 @@ static __init int hardware_setup(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
-	    && enable_ept)
-		kvm_x86_ops->tlb_remote_flush = vmx_hv_remote_flush_tlb;
+	    && enable_ept) {
+		kvm_x86_ops->tlb_remote_flush = hv_remote_flush_tlb;
+		kvm_x86_ops->tlb_remote_flush_with_range =
+				hv_remote_flush_tlb_with_range;
+	}
 #endif
 
 	if (!cpu_has_vmx_ple()) {
@@ -11567,6 +11594,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = -1ull;
 
+	vmx->ept_pointer = INVALID_PAGE;
+
 	vmx->msr_ia32_feature_control_valid_bits = FEATURE_CONTROL_LOCKED;
 
 	/*
-- 
2.14.4
