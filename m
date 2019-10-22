Return-Path: <SRS0=Z+4i=YP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87259CA9EAF
	for <linux-mips@archiver.kernel.org>; Tue, 22 Oct 2019 02:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA7A207FC
	for <linux-mips@archiver.kernel.org>; Tue, 22 Oct 2019 02:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfJVCC0 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:02:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:61595 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbfJVB7s (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 21 Oct 2019 21:59:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 18:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; 
   d="scan'208";a="196293834"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2019 18:59:46 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/45] KVM: x86: Remove spurious clearing of async #PF MSR
Date:   Mon, 21 Oct 2019 18:59:01 -0700
Message-Id: <20191022015925.31916-22-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191022015925.31916-1-sean.j.christopherson@intel.com>
References: <20191022015925.31916-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Remove a bogus clearing of apf.msr_val from kvm_arch_vcpu_destroy().

apf.msr_val is only set to a non-zero value by kvm_pv_enable_async_pf(),
which is only reachable by kvm_set_msr_common(), i.e. by writing
MSR_KVM_ASYNC_PF_EN.  KVM does not autonomously write said MSR, i.e.
can only be written via KVM_SET_MSRS or KVM_RUN.  Since KVM_SET_MSRS and
KVM_RUN are vcpu ioctls, they require a valid vcpu file descriptor.
kvm_arch_vcpu_destroy() is only called if KVM_CREATE_VCPU fails, and KVM
declares KVM_CREATE_VCPU successful once the vcpu fd is installed and
thus visible to userspace.  Ergo, apf.msr_val cannot be non-zero when
kvm_arch_vcpu_destroy() is called.

Fixes: 344d9588a9df0 ("KVM: Add PV MSR to enable asynchronous page faults delivery.")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dd667df37d63..dfd5c5244a6b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9097,8 +9097,6 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.apf.msr_val = 0;
-
 	kvm_arch_vcpu_free(vcpu);
 }
 
-- 
2.22.0

