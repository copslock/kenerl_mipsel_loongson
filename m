Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 17:50:40 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54797 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824104Ab3ETPueKRBIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 17:50:34 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl13so5807306pab.34
        for <multiple recipients>; Mon, 20 May 2013 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NhYK1fU964Xg9wDOTAW5m1xrmXssMfwl47/ywjSXfmI=;
        b=ae8UFU0jO31n4SHD99Zr8vUNu8ikAOYh38sywCki9Z4RLUHO7DISAkZZUt0XZWR/g+
         HAhx/qp2mpK+ptTo38XWXZypRxuV1J/BMlPjuh8RobN14opRSprbIuFWYEBK8whH4vWJ
         juAFB/O676h/PzdiXqnLUHolPDTUB89l0kJhj4jUZdeVBPh5wf8KuVZQQY1hlATPual3
         wtU8cqOv2BeLxxdMGVcxJ7tViJadGl55WQ7k5Rs4sIjvfPBLMd1UoQXV7YQuRFbmBS+q
         joGuN8WGgC0+CEmPdtAI6pqMxruSGqnGJ9eBis/Yij5qmDBvJ4XXeQmWOwdxgBxLsuzm
         N8hQ==
X-Received: by 10.66.159.168 with SMTP id xd8mr61024515pab.146.1369065027040;
        Mon, 20 May 2013 08:50:27 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cp1sm24579613pbc.42.2013.05.20.08.50.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 08:50:26 -0700 (PDT)
Message-ID: <519A4640.6060202@gmail.com>
Date:   Mon, 20 May 2013 08:50:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 00/18] KVM/MIPS32: Support for the new Virtualization
 ASE (VZ-ASE)
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36483
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

On 05/18/2013 10:47 PM, Sanjay Lal wrote:
> The following patch set adds support for the recently announced virtualization
> extensions for the MIPS32 architecture and allows running unmodified kernels in
> Guest Mode.
>
> For more info please refer to :
> 	MIPS Document #: MD00846
> 	Volume IV-i: Virtualization Module of the MIPS32 Architecture
>
> which can be accessed @: http://www.mips.com/auth/MD00846-2B-VZMIPS32-AFP-01.03.pdf
>
> The patch is agains Linux-3.10-rc1.
>
> KVM/MIPS now supports 2 modes of operation:
>
> (1) VZ mode: Unmodified kernels running in Guest Mode.  The processor now provides
>      an almost complete COP0 context in Guest mode. This greatly reduces VM exits.

Two questions:

1) How are you handling not clobbering the Guest K0/K1 registers when a 
Root exception occurs?  It is not obvious to me from inspecting the code.

2) What environment are you using to test this stuff?

David Daney


>
> (2) Trap and Emulate: Runs minimally modified guest kernels in UM and uses binary patching
>      to minimize the number of traps and improve performance. This is used for processors
>      that do not support the VZ-ASE.
>
> --
> Sanjay Lal (18):
>    Revert "MIPS: microMIPS: Support dynamic ASID sizing."
>    Revert "MIPS: Allow ASID size to be determined at boot time."
>    KVM/MIPS32: Export min_low_pfn.
>    KVM/MIPS32-VZ: MIPS VZ-ASE related register defines and helper
>      macros.
>    KVM/MIPS32-VZ: VZ-ASE assembler wrapper functions to set GuestIDs
>    KVM/MIPS32-VZ: VZ-ASE related callbacks to handle guest exceptions
>      that trap to the Root context.
>    KVM/MIPS32: VZ-ASE related CPU feature flags and options.
>    KVM/MIPS32-VZ: Entry point for trampolining to the guest and trap
>      handlers.
>    KVM/MIPS32-VZ: Add support for CONFIG_KVM_MIPS_VZ option
>    KVM/MIPS32-VZ: Add API for VZ-ASE Capability
>    KVM/MIPS32-VZ: VZ: Handle Guest TLB faults that are handled in Root
>      context
>    KVM/MIPS32-VZ: VM Exit Stats, add VZ exit reasons.
>    KVM/MIPS32-VZ: Top level handler for Guest faults
>    KVM/MIPS32-VZ: Guest exception batching support.
>    KVM/MIPS32: Add dummy trap handler to catch unexpected exceptions and
>      dump out useful info
>    KVM/MIPS32-VZ: Add VZ-ASE support to KVM/MIPS data structures.
>    KVM/MIPS32: Revert to older method for accessing ASID parameters
>    KVM/MIPS32-VZ: Dump out additional info about VZ features as part of
>      /proc/cpuinfo
>
>   arch/mips/include/asm/cpu-features.h |   36 ++
>   arch/mips/include/asm/cpu-info.h     |   21 +
>   arch/mips/include/asm/cpu.h          |    5 +
>   arch/mips/include/asm/kvm_host.h     |  244 ++++++--
>   arch/mips/include/asm/mipsvzregs.h   |  494 +++++++++++++++
>   arch/mips/include/asm/mmu_context.h  |   95 ++-
>   arch/mips/kernel/genex.S             |    2 +-
>   arch/mips/kernel/mips_ksyms.c        |    6 +
>   arch/mips/kernel/proc.c              |   11 +
>   arch/mips/kernel/smtc.c              |   10 +-
>   arch/mips/kernel/traps.c             |    6 +-
>   arch/mips/kvm/Kconfig                |   14 +-
>   arch/mips/kvm/Makefile               |   14 +-
>   arch/mips/kvm/kvm_locore.S           | 1088 ++++++++++++++++++----------------
>   arch/mips/kvm/kvm_mips.c             |   73 ++-
>   arch/mips/kvm/kvm_mips_dyntrans.c    |   24 +-
>   arch/mips/kvm/kvm_mips_emul.c        |  236 ++++----
>   arch/mips/kvm/kvm_mips_int.h         |    5 +
>   arch/mips/kvm/kvm_mips_stats.c       |   17 +-
>   arch/mips/kvm/kvm_tlb.c              |  444 +++++++++++---
>   arch/mips/kvm/kvm_trap_emul.c        |   68 ++-
>   arch/mips/kvm/kvm_vz.c               |  786 ++++++++++++++++++++++++
>   arch/mips/kvm/kvm_vz_locore.S        |   74 +++
>   arch/mips/lib/dump_tlb.c             |    5 +-
>   arch/mips/lib/r3k_dump_tlb.c         |    7 +-
>   arch/mips/mm/tlb-r3k.c               |   20 +-
>   arch/mips/mm/tlb-r4k.c               |    2 +-
>   arch/mips/mm/tlb-r8k.c               |    2 +-
>   arch/mips/mm/tlbex.c                 |   82 +--
>   include/uapi/linux/kvm.h             |    1 +
>   30 files changed, 2906 insertions(+), 986 deletions(-)
>   create mode 100644 arch/mips/include/asm/mipsvzregs.h
>   create mode 100644 arch/mips/kvm/kvm_vz.c
>   create mode 100644 arch/mips/kvm/kvm_vz_locore.S
>
