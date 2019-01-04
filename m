Return-Path: <SRS0=/SDL=PM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07128C43612
	for <linux-mips@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84D2206C0
	for <linux-mips@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7OB0Rv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfADIyU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:54:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46960 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADIyU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 4 Jan 2019 03:54:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so17983049pfe.13;
        Fri, 04 Jan 2019 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s54CWoMBwC/zNmAKjZOvrFS4zL5cc4VeheWOnWbsbcs=;
        b=X7OB0Rv6x6K201MwLVR0NTSf1nCzTgQvzvZlrHC9jbh5Yn/NUxF7S9JpxOff2/a67c
         /3NkSl0D7Dactf3miq3lgBXrXbLPGEYwZVcNhlX9gbH+ahhnogWtMfnIir2t1FU8P0Ep
         Bd8uWIIrc5Y/CScBFsHSrpZCa+TXWV2fnc2zaG8foh9m/Ngph5755U9dYDS7+Hb/1hB/
         XaiDrEZD3zQ8RXSYE5FyIYQ4/xzDvNRbFkPIuonph7cd8cx7O6TAG7GpskNlktUtzTaz
         gvohfnLVuQvGbT8ubil3v+QMn68aLirQOnws2NCk1cvyGbQihEcAF2esmC+//BFrOhJs
         bGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s54CWoMBwC/zNmAKjZOvrFS4zL5cc4VeheWOnWbsbcs=;
        b=irwQTWdJXE5rWAr7Mzceqj6ehGwG+y5SRLMV/yXRZYfJyEcdRfrtt2UT3j8FPMuwIv
         4Iz2oJEd45wfwfHaPK7IEIpURKHPBg52S7NyTtqBQP5xFxkulgc70SLBAPv9s80zdCM1
         aHITkrdot0qSrN8fKg4QvvrQTimRMjzqHTFqAsimJBBIdw4r2ZYgRhR6tPRKqiX2O6NP
         E9PInmaGvB24Kz5TeSY6SojYpHbD26Vrkv6bx2qtC2A+jAErL++6Eyg1rPGEUtfuBpnj
         sNuCwUAiM8e/pGPYd1cMisfIyYS8s57Tuln5P5XTNrUzwkLS453PygYaCeYVWsbVqehe
         5kmQ==
X-Gm-Message-State: AJcUukczbCthDyPW5odla5RXKNWnxpKI3Ji+EZ3X0g+DjKDFj8e93pKA
        uRZjn2aHEeJu6T/EM42Jcoc=
X-Google-Smtp-Source: ALg8bN6TKO/FbJdy9H6pHPilkdPA0uBYPyFKYsWoLiF0HM2Gb0AxFE+KDE3IQXIY+upyYE2K8qdZag==
X-Received: by 2002:a63:554b:: with SMTP id f11mr923300pgm.37.1546592059172;
        Fri, 04 Jan 2019 00:54:19 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:54:18 -0800 (PST)
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
        rkrcmar@redhat.com, sthemmin@microsoft.com, tglx@linutronix.de,
        will.deacon@arm.com, x86@kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH 00/11] X86/KVM/Hyper-V: Add HV ept tlb range list flush support in KVM
Date:   Fri,  4 Jan 2019 16:53:54 +0800
Message-Id: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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

Lan Tianyu (11):
  X86/Hyper-V: Add parameter offset for
    hyperv_fill_flush_guest_mapping_list()
  KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
  KVM: Add spte's point in the struct kvm_mmu_page
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM/MMU: Flush tlb with range list in sync_page()
  KVM: Remove redundant check in the kvm_get_dirty_log_protect()
  KVM: Make kvm_arch_mmu_enable_log_dirty_pt_masked() return value
  KVM/MMU: Flush tlb in the kvm_mmu_write_protect_pt_masked()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Flush tlb in the kvm_age_rmapp()

 arch/arm/include/asm/kvm_host.h     |  3 +-
 arch/arm64/include/asm/kvm_host.h   |  3 +-
 arch/mips/include/asm/kvm_host.h    |  3 +-
 arch/mips/kvm/mmu.c                 |  8 +++-
 arch/powerpc/include/asm/kvm_host.h |  3 +-
 arch/powerpc/kvm/book3s.c           |  3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            |  4 +-
 arch/x86/include/asm/kvm_host.h     | 11 +++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 73 ++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/paging_tmpl.h          | 18 ++++++++-
 arch/x86/kvm/vmx/vmx.c              | 18 ++++++++-
 include/linux/kvm_host.h            |  2 +-
 virt/kvm/arm/mmu.c                  |  8 +++-
 virt/kvm/kvm_main.c                 | 18 ++++-----
 16 files changed, 141 insertions(+), 39 deletions(-)

-- 
2.14.4

