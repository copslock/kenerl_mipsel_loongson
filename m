Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2AC282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F6F218AC
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdRQIC4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfBBBir (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:38:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36157 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfBBBir (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Feb 2019 20:38:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so3760488pgm.3;
        Fri, 01 Feb 2019 17:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
        b=CdRQIC4S3v9jaekUlfJj2NUKf2JzLWQxXFj3Fd3TdTg4/MGH81cKHPUiqNhHOIMCiW
         Im0rrekXokI4GGpj7uVkLsI49ezhpk0BYXENdncD6k4xE6tUoMYnq5WYqWQoESvCB3jm
         hJ39w81Fs3XriZv0OiXUFPHS/OxW2ltunr8FrXplWhNaqAOEx9JLUAygkrmn87OcHOG/
         e2rHZnSqyNpEEHg9LZ4M3pxMM4z15oPtsb2qYuTk9XFGeGPxmrHiGIO1uXnu55IN6Umt
         hxV//loDPRgF7BtN7kBMZhl8S+HCo2Mdv3aSa1anNWkzkfcsQMNYusiLaAEyS7ha4/zl
         ryWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
        b=DJBUZQBxgJmTASJ2AneEURiX3rTDhRMbvFloaYJvte1JsOKeiJqyutbuONanJhzyfI
         Fv1pKQukN1+puBQ/KlTSM7EXO8GC67Un3t6CUxRJCt8aOgf84W4nvHLrkWehdbHeuXfx
         h/W57uDIqFq0XrdEYauIJArMrEpmTIIG0OTN15FYhfLooQdOPjxJQgMAeeec86jWKuOk
         ms5I6VE51lR4tYddEeDkv8aI23zbbS7KCUmU+5TcdJtTlpSTbk+KLYMMXJ1hC2ku4z1x
         DrnvRDiCjWGMgoB6D4sJ526R4D2psvHtHXqUhU2JN7LE4qFX75hEAimpKUMFqgo7cszz
         k2uA==
X-Gm-Message-State: AJcUukcdS5NuEoPT6QTUWzRsIeBdgLIFXCg8/dDSOT2PLt69KKPfYCk8
        lZ8Dn+LuOedQpffvnj+65im1M1/fL/s=
X-Google-Smtp-Source: ALg8bN4wCd8WPbUfjygurTGV+Uh8u7LiH8oJ428GopNarY3WZGPQDPlOah8HB1z/Y8aoBZ10aAbXYw==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr37002796pgc.216.1549071525863;
        Fri, 01 Feb 2019 17:38:45 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:38:44 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, benh@kernel.crashing.org,
        bp@alien8.de, catalin.marinas@arm.com, christoffer.dall@arm.com,
        devel@linuxdriverproject.org, haiyangz@microsoft.com,
        hpa@zytor.com, jhogan@kernel.org, kvmarm@lists.cs.columbia.edu,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, kys@microsoft.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, marc.zyngier@arm.com,
        mingo@redhat.com, mpe@ellerman.id.au, paul.burton@mips.com,
        paulus@ozlabs.org, pbonzini@redhat.com, ralf@linux-mips.org,
        rkrcmar@redhat.com, sashal@kernel.org, sthemmin@microsoft.com,
        tglx@linutronix.de, will.deacon@arm.com, x86@kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V2 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush support in KVM              
Date:   Sat,  2 Feb 2019 09:38:16 +0800
Message-Id: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patchset is to introduce hv ept tlb range list flush function
support in the KVM MMU component. Flushing ept tlbs of several address
range can be done via single hypercall and new list flush function is
used in the kvm_mmu_commit_zap_page() and FNAME(sync_page). This patchset
also adds more hv ept tlb range flush support in more KVM MMU function.

Change since v1:
       1) Make flush list as a hlist instead of list in order to 
       keep struct kvm_mmu_page size.
       2) Add last_level flag in the struct kvm_mmu_page instead
       of spte pointer
       3) Move tlb flush from kvm_mmu_notifier_clear_flush_young() to kvm_age_hva()
       4) Use range flush in the kvm_vm_ioctl_get/clear_dirty_log()

Lan Tianyu (10):
  X86/Hyper-V: Add parameter offset for
    hyperv_fill_flush_guest_mapping_list()
  KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
  KVM/MMU: Add last_level in the struct mmu_spte_page
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Flush tlb with range list in sync_page()
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM: Add kvm_get_memslot() to get memslot via slot id
  KVM: Use tlb range flush in the kvm_vm_ioctl_get/clear_dirty_log()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Use tlb range flush  in the kvm_age_hva()

 arch/arm/include/asm/kvm_host.h     |  3 ++-
 arch/arm64/include/asm/kvm_host.h   |  3 ++-
 arch/mips/include/asm/kvm_host.h    |  3 ++-
 arch/mips/kvm/mmu.c                 | 11 ++++++--
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s.c           | 10 ++++++--
 arch/powerpc/kvm/e500_mmu_host.c    |  3 ++-
 arch/x86/hyperv/nested.c            |  4 +--
 arch/x86/include/asm/kvm_host.h     | 11 +++++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 51 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/mmu.h                  |  7 +++++
 arch/x86/kvm/paging_tmpl.h          | 15 ++++++++---
 arch/x86/kvm/vmx/vmx.c              | 18 +++++++++++--
 arch/x86/kvm/x86.c                  | 16 +++++++++---
 include/linux/kvm_host.h            |  1 +
 virt/kvm/arm/mmu.c                  | 13 ++++++++--
 virt/kvm/kvm_main.c                 | 51 +++++++++++++++----------------------
 18 files changed, 160 insertions(+), 65 deletions(-)

-- 
2.14.4

