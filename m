Return-Path: <SRS0=+ky4=QI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B6C282DB
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4646820870
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VclUM1Gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfBAOsn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:48:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39988 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfBAOsn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Feb 2019 09:48:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so3315454plq.7;
        Fri, 01 Feb 2019 06:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
        b=VclUM1Gr6vplH2lc6Ex2uMcst7OpLUwzYdrhBjSpiDgIZg76ZHVjpKJ4U4SExjF3QV
         Od3ncVcWLzN8HgUVQB3KUYeup4HFmP2iE1LT+/OtaQTbCvbGUwggPiD6Pm/POl+Qa6BJ
         Md0Xm3LYjrStc9gxfllVcDGzfzcB78fp+FLJTEFRLG/J+Vi+TlYL2STO78l/1+ysLbe9
         gHtU5rJNNQMbJbNDj9yPz7VuQ6bZrSfnwP1kjrFJlgoKfVOTkOp5Qj/mst+wK1BwGFRm
         5YHV9KRzExaWbwjLj7uIzqTVFmXCxOB44fYAqN5swmaQaifUYQagLR1fr/V7merQuAco
         YdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
        b=BPBTE+k+mBJIIPnA9iHGhE4zFkXANsvmagI7mcP5/kR4ReiXRtpPZuxffMj/jbbge5
         pHOtIEmUv5n9p7EMdVwfhM14uOE1NySnYOr0XQUmabo5rlIicSJOM9gI2MEisxPuUO3c
         SOQs108e1rA/Zu3UfBnW/wWeDaiXA8fUj54rOTCZXt8GgQTFukVN2souWatEWp/n1bxc
         Q0LeXOudzph3OimI0hWVwewVVOiU+Zh4xCzCA4Q7iPVHQO6W7p3ICOD82dvz0xX/c8Jy
         a9RPg3PhrWTqPzp4X8YBv/tRAbZ4d927LkRWi92pCQwWsVhcg+5eHPUhmyhtpqLSOvIk
         z0Ag==
X-Gm-Message-State: AJcUukdT4lJDqCK27oaCOJVKaZhsfn897jmlxpLi7XIVHdUDh+lTVA9H
        ob43wRMYUdLPcHu0aAGY8CtSfMCxusg=
X-Google-Smtp-Source: ALg8bN5eyyO1GjD67omoBBXbC4wUV9Hny7kZddb4cDJA6juGAKguzsu8tLq3FRvPinM9K65VT/+xzg==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr39725750plt.159.1549032522270;
        Fri, 01 Feb 2019 06:48:42 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id n74sm2309674pfi.163.2019.02.01.06.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:48:41 -0800 (PST)
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
Date:   Fri,  1 Feb 2019 22:48:12 +0800
Message-Id: <20190201144821.50409-1-Tianyu.Lan@microsoft.com>
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

