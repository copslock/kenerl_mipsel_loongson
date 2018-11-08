Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 15:44:07 +0100 (CET)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:44528
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991062AbeKHOnZghZ6v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 15:43:25 +0100
Received: by mail-pl1-x642.google.com with SMTP id s5-v6so9616568plq.11;
        Thu, 08 Nov 2018 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vxBQF0dRycqPAI+VQ2b6lcauq3UFaNK9t6RBJmGboRo=;
        b=qiMOeM1/SRnEzVb1mu+meJt7JF3I6SihxbCjYz54cN7aYc1GeW9WAG1BcWzdp1k0g5
         U665cC9UHDXeEyUC0FSFYRdRlDWtZy/gXeVtopYcvhNOD709R+KNEDpZmC4wdEFyQKHl
         vSaATeWrsftXGX1/Erf7WeQOWtLn5a1u/A1Pb4rdFeOIee/gOrstDCBsS0cZ3WDtVlSz
         +u/q96UzlBdCFqJ/DX2pUQvtzXkXdqF6qG089Veox6w7Z94K5GfPpvPppN0LdwyGUYDL
         +bLmYnGMybj3EoncTSNIAu8v1auR72MHtoCo1pb1ZMTe37+5dSDLeUpruebW8DT0zsH9
         UM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vxBQF0dRycqPAI+VQ2b6lcauq3UFaNK9t6RBJmGboRo=;
        b=OGu1gZiu9FITMUlnvQdpezMGhUNQhK8JmBMtO3AoyGPppQgy0OItArFZ4HJqv4OBh+
         1KJWvejGIv2AoAc8ZN97Gu3HkeH0qqFxe9kAkcArJba+8oPL8fSd6iyulhdKnK6nr9E6
         X0dLN5uqA+vYtgHjuL86iZUWgKCCHaoLBd/jAqTsJRpP1NE754FUUYqbCDuoerX/pAAN
         1l1Zc8o4tqyFKNzdD2AyzpsShIpIRWHQ2YqrRcNNIVSvJHOkK3r5Yl9jUY/6didZouAK
         /yGB+PEgj9dy+WW9VPA90a/gcQzKmbYeG9J9b/dcE3oKfLj6o+10H2wwnJSUJoJz4ea6
         4unQ==
X-Gm-Message-State: AGRZ1gIP8WOFAxwXo7Jf+6OwUDXl29uXjubSlCFjfEG75I4Yc1mzHeXz
        A48qeV11y621DSFkkeK59Xo=
X-Google-Smtp-Source: AJdET5exlz1SZ+ZiRFduKTmQ+stN9ujPhv6GOCDd3Pk1/rZFJygsbx+IqcZ1JrQMsjVlfARg3K4wdw==
X-Received: by 2002:a17:902:8689:: with SMTP id g9-v6mr4736173plo.44.1541688204606;
        Thu, 08 Nov 2018 06:43:24 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id p62-v6sm4053565pfp.111.2018.11.08.06.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:43:23 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, benh@kernel.crashing.org,
        bp@alien8.de, catalin.marinas@arm.com, christoffer.dall@arm.com,
        devel@linuxdriverproject.org, haiyangz@microsoft.com,
        hpa@zytor.com, jhogan@kernel.org, kvmarm@lists.cs.columbia.edu,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, kys@microsoft.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, marc.zyngier@arm.com,
        mingo@redhat.com, mpe@ellerman.id.au, paul.burton@mips.com,
        paulus@ozlabs.org, pbonzini@redhat.com, ralf@linux-mips.org,
        rkrcmar@redhat.com, sthemmin@microsoft.com, tglx@linutronix.de,
        will.deacon@arm.com, x86@kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V5 00/10] x86/KVM/Hyper-v: Add HV ept tlb range flush hypercall support in KVM
Date:   Thu,  8 Nov 2018 22:42:59 +0800
Message-Id: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lantianyu1986@gmail.com
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

Sorry. Some patches was blocked and I try to resend via another account.

For nested memory virtualization, Hyper-v doesn't set write-protect
L1 hypervisor EPT page directory and page table node to track changes 
while it relies on guest to tell it changes via HvFlushGuestAddressLlist
hypercall. HvFlushGuestAddressLlist hypercall provides a way to flush
EPT page table with ranges which are specified by L1 hypervisor.

If L1 hypervisor uses INVEPT or HvFlushGuestAddressSpace hypercall to
flush EPT tlb, Hyper-V will invalidate associated EPT shadow page table
and sync L1's EPT table when next EPT page fault is triggered.
HvFlushGuestAddressLlist hypercall helps to avoid such redundant EPT
page fault and synchronization of shadow page table.

This patchset is rebased on the Linux 4.20-rc1 and Patch "KVM/VMX: Check
ept_pointer before flushing ept tlb".(https://www.mail-archive.com/linux
-kernel@vger.kernel.org/msg1798827.html).

Change since v4:
       1) Split flush address and flush list patches. This patchset only contains
       flush address patches. Will post flush list patches later.
       2) Expose function hyperv_fill_flush_guest_mapping_list()
       out of hyperv file
       3) Adjust parameter of hyperv_flush_guest_mapping_range()
       4) Reorder patchset and move Hyper-V and VMX changes ahead.

Change since v3:
        1) Remove code of updating "tlbs_dirty" in kvm_flush_remote_tlbs_with_range()
        2) Remove directly tlb flush in the kvm_handle_hva_range()
        3) Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
        4) Combine Vitaly's "don't pass EPT configuration info to
vmx_hv_remote_flush_tlb()" fix

Change since v2:
       1) Fix comment in the kvm_flush_remote_tlbs_with_range()
       2) Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
        hyperv-tlfs.h.
       3) Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
       4) Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
        struct hv_guest_mapping_flush_list.

Change since v1:
       1) Convert "end_gfn" of struct kvm_tlb_range to "pages" in order
          to avoid confusion as to whether "end_gfn" is inclusive or exlusive.
       2) Add hyperv tlb range struct and replace kvm tlb range struct
          with new struct in order to avoid using kvm struct in the hyperv
          code directly.


Lan Tianyu (10):
  KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
  x86/hyper-v: Add HvFlushGuestAddressList hypercall support
  x86/Hyper-v: Add trace in the
    hyperv_nested_flush_guest_mapping_range()
  KVM/VMX: Add hv tlb range flush support
  KVM/MMU: Add tlb flush with range helper function
  KVM: Replace old tlb flush function with new one to flush a specified
    range.
  KVM: Make kvm_set_spte_hva() return int
  KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to
    kvm_mmu_notifier_change_pte()
  KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
  KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()

 arch/arm/include/asm/kvm_host.h     |  2 +-
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/mips/include/asm/kvm_host.h    |  2 +-
 arch/mips/kvm/mmu.c                 |  3 +-
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/powerpc/kvm/book3s.c           |  3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            | 80 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  | 32 +++++++++++++
 arch/x86/include/asm/kvm_host.h     |  9 +++-
 arch/x86/include/asm/mshyperv.h     | 15 ++++++
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++
 arch/x86/kvm/mmu.c                  | 96 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/paging_tmpl.h          |  3 +-
 arch/x86/kvm/vmx.c                  | 69 ++++++++++++++++++--------
 virt/kvm/arm/mmu.c                  |  6 ++-
 virt/kvm/kvm_main.c                 |  5 +-
 17 files changed, 295 insertions(+), 51 deletions(-)

-- 
2.14.4
