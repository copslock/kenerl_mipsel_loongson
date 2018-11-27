Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2018 12:59:38 +0100 (CET)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:34950
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993846AbeK0L7ehGqh2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2018 12:59:34 +0100
Received: by mail-pg1-x542.google.com with SMTP id s198so7774196pgs.2;
        Tue, 27 Nov 2018 03:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xqBmdV1KrJJv0B9iHP5cNl7CqHVS4upK6gVCSVI+ZI=;
        b=c1Lx6LpZH/yPprmnEWs4u6NhdSCBPyeOH9118ZY2b6cZNC7Et21UYZwNvuUiVGDHP8
         ZK9SFW99FI4EEcp0uzxdhilbI0lFXMGe5yuRoNHjRGPv/Yw/zl/X/dNAmeOo3gTTGV6F
         W6HTPQq/yW5Sni31xbxbdqFkempvum3k/DkDmC3ExeyLM1Up0ciDLzbps9xWdXNsoUVk
         IYWIUnUU51wMVhLH6udW0BH9GOLZlRsciXl5kh4/hGWWXEudx5q7fmVuBHxpgju6ylQa
         Ny5wJF0N74JqddDerFDkrb0D2g3mQEXVDMYGaPa164oG7I70PpzK2QVHBjGJfM55Lp2R
         wgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xqBmdV1KrJJv0B9iHP5cNl7CqHVS4upK6gVCSVI+ZI=;
        b=B8n3j9qVht68pNQR6bVNKummZVJET0+cRnhQuDXHtyWyLZBhw/MMboAo+vobwtDY1q
         C2s6kHbwNwrCm0aa/QZMsVtTFA9l26S4kBL5vqZj57T0SjI5OnBtg1/w6WHm/uVHQ4em
         Z2euF8CG6dFNM4Azj1d6TENATpgWFefAfVFLNhUCp0qTzMVih3CPA/if4fY4Zmv1ltm6
         +xa/LOigYYgt0MwU+uIaEtfnBbTo1QLs91ipNpYNZPXS9/U2zp2CaG/hm8V8QClyYLev
         jSFFcQQEYFgLbLxkT1ttep59173AwPi3f0fKyJ3XVgSitrhv6UBToOZFqa7fL2pLlM9H
         fuYA==
X-Gm-Message-State: AA+aEWYLuHSVRaz7B1MwhpVf4hmIEyq9VHCK2LEP5bHT5qpdEdUgZDMj
        5MSgrvKm7xhsWA/8Kd7Df6rQKU87QS8WjLd5nkA=
X-Google-Smtp-Source: AFSGD/WXX5qNh8s3rNMBCSeQIP+Im5TmXgATCKNYCCr+FTckV7o7rA2WS8K1vpw/UmEr72IP4Br6t/JYkVBrDt5iQDw=
X-Received: by 2002:a63:da14:: with SMTP id c20mr27916035pgh.233.1543319973618;
 Tue, 27 Nov 2018 03:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Tue, 27 Nov 2018 19:59:22 +0800
Message-ID: <CAOLK0pyvtfhoGM+D7h=gXwNpNjXGZiDJKpuVi9HOwb++4asCXw@mail.gmail.com>
Subject: Re: [PATCH V5 00/10] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
To:     =?UTF-8?B?5aSp5a6HIOiTnQ==?= <lantianyu1986@gmail.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, benh@kernel.crashing.org,
        bp@alien8.de, catalin.marinas@arm.com, christoffer.dall@arm.com,
        devel@linuxdriverproject.org, haiyangz@microsoft.com,
        "H. Peter Anvin" <hpa@zytor.com>, jhogan@kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        kvm <kvm@vger.kernel.org>, kys@microsoft.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        marc.zyngier@arm.com, Ingo Molnar <mingo@redhat.com>,
        mpe@ellerman.id.au, paul.burton@mips.com, paulus@ozlabs.org,
        Paolo Bonzini <pbonzini@redhat.com>, ralf@linux-mips.org,
        Radim Krcmar <rkrcmar@redhat.com>, sthemmin@microsoft.com,
        Thomas Gleixner <tglx@linutronix.de>, will.deacon@arm.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67526
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

Gentile Ping...

On Thu, Nov 8, 2018 at 10:43 PM <lantianyu1986@gmail.com> wrote:
>
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> Sorry. Some patches was blocked and I try to resend via another account.
>
> For nested memory virtualization, Hyper-v doesn't set write-protect
> L1 hypervisor EPT page directory and page table node to track changes
> while it relies on guest to tell it changes via HvFlushGuestAddressLlist
> hypercall. HvFlushGuestAddressLlist hypercall provides a way to flush
> EPT page table with ranges which are specified by L1 hypervisor.
>
> If L1 hypervisor uses INVEPT or HvFlushGuestAddressSpace hypercall to
> flush EPT tlb, Hyper-V will invalidate associated EPT shadow page table
> and sync L1's EPT table when next EPT page fault is triggered.
> HvFlushGuestAddressLlist hypercall helps to avoid such redundant EPT
> page fault and synchronization of shadow page table.
>
> This patchset is rebased on the Linux 4.20-rc1 and Patch "KVM/VMX: Check
> ept_pointer before flushing ept tlb".(https://www.mail-archive.com/linux
> -kernel@vger.kernel.org/msg1798827.html).
>
> Change since v4:
>        1) Split flush address and flush list patches. This patchset only contains
>        flush address patches. Will post flush list patches later.
>        2) Expose function hyperv_fill_flush_guest_mapping_list()
>        out of hyperv file
>        3) Adjust parameter of hyperv_flush_guest_mapping_range()
>        4) Reorder patchset and move Hyper-V and VMX changes ahead.
>
> Change since v3:
>         1) Remove code of updating "tlbs_dirty" in kvm_flush_remote_tlbs_with_range()
>         2) Remove directly tlb flush in the kvm_handle_hva_range()
>         3) Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
>         4) Combine Vitaly's "don't pass EPT configuration info to
> vmx_hv_remote_flush_tlb()" fix
>
> Change since v2:
>        1) Fix comment in the kvm_flush_remote_tlbs_with_range()
>        2) Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
>         hyperv-tlfs.h.
>        3) Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
>        4) Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
>         struct hv_guest_mapping_flush_list.
>
> Change since v1:
>        1) Convert "end_gfn" of struct kvm_tlb_range to "pages" in order
>           to avoid confusion as to whether "end_gfn" is inclusive or exlusive.
>        2) Add hyperv tlb range struct and replace kvm tlb range struct
>           with new struct in order to avoid using kvm struct in the hyperv
>           code directly.
>
>
> Lan Tianyu (10):
>   KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
>   x86/hyper-v: Add HvFlushGuestAddressList hypercall support
>   x86/Hyper-v: Add trace in the
>     hyperv_nested_flush_guest_mapping_range()
>   KVM/VMX: Add hv tlb range flush support
>   KVM/MMU: Add tlb flush with range helper function
>   KVM: Replace old tlb flush function with new one to flush a specified
>     range.
>   KVM: Make kvm_set_spte_hva() return int
>   KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to
>     kvm_mmu_notifier_change_pte()
>   KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
>   KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
>
>  arch/arm/include/asm/kvm_host.h     |  2 +-
>  arch/arm64/include/asm/kvm_host.h   |  2 +-
>  arch/mips/include/asm/kvm_host.h    |  2 +-
>  arch/mips/kvm/mmu.c                 |  3 +-
>  arch/powerpc/include/asm/kvm_host.h |  2 +-
>  arch/powerpc/kvm/book3s.c           |  3 +-
>  arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
>  arch/x86/hyperv/nested.c            | 80 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h  | 32 +++++++++++++
>  arch/x86/include/asm/kvm_host.h     |  9 +++-
>  arch/x86/include/asm/mshyperv.h     | 15 ++++++
>  arch/x86/include/asm/trace/hyperv.h | 14 ++++++
>  arch/x86/kvm/mmu.c                  | 96 +++++++++++++++++++++++++++++--------
>  arch/x86/kvm/paging_tmpl.h          |  3 +-
>  arch/x86/kvm/vmx.c                  | 69 ++++++++++++++++++--------
>  virt/kvm/arm/mmu.c                  |  6 ++-
>  virt/kvm/kvm_main.c                 |  5 +-
>  17 files changed, 295 insertions(+), 51 deletions(-)
>
> --
> 2.14.4
>


-- 
Best regards
Tianyu Lan
