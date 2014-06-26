Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 21:28:49 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:64590 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860040AbaFZT2qMjr7k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 21:28:46 +0200
Received: by mail-ig0-f173.google.com with SMTP id uq10so1119139igb.6
        for <multiple recipients>; Thu, 26 Jun 2014 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Jea0R1Hqw1s+E2ISCIR4p37zcDPMYRjS/6GXrw5vRJI=;
        b=rwdsfDjfVXGTj9KkUCq+ZsxIpA7B54QE1DTZJ9ovJlNUvUfMU+xwerTUt7XNvOK+b+
         8FBJ2kRuuueaO5FOsZX1F6MQaKtdYPmJo95Xez+BuV9wLv4MNkOa7r5HzGJHEt5CiFI5
         veRP9VeyfcwsrpMysa8YsW06gXvbBo07gqyXyvMryDXbHa7CnJqwUYMCO9/y6buBMh/G
         GjBUgQtFA/vhMhb6sRM2AeHoNA7vzsNvJLzka5JL1RuN7tQyvncL4E6HRVyXyS0ZZLtQ
         5xGT0TviAfZA3awMw9GPKledMpwFOG0mggehe6wANXtaKEjNQww9Q6GKqa0kvUoLkz/q
         CWLQ==
X-Received: by 10.50.134.73 with SMTP id pi9mr6990402igb.25.1403810919975;
        Thu, 26 Jun 2014 12:28:39 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id t18sm6688392igr.18.2014.06.26.12.28.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 12:28:39 -0700 (PDT)
Message-ID: <53AC7466.6070401@gmail.com>
Date:   Thu, 26 Jun 2014 12:28:38 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     pbonzini@redhat.com, gleb@kernel.org, kvm@vger.kernel.org,
        sanjayl@kymasys.com, james.hogan@imgtec.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v4 5/7] MIPS: KVM: Rename files to remove the prefix "kvm_"
 and "kvm_mips_"
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com> <1403809900-17454-6-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1403809900-17454-6-git-send-email-dengcheng.zhu@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40859
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

On 06/26/2014 12:11 PM, Deng-Cheng Zhu wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>
> Since all the files are in arch/mips/kvm/, there's no need of the prefixes
> "kvm_" and "kvm_mips_".
>

I don't like this change.

It will leads me to confuse arch/mips/kvm/interrupt.h with 
include/linux/interrupt.h

x86 calls these things irq.c and irq.h, perhaps that would be a little 
better.

There is precedence in x86 for some of the names though.

But really why churn up the code in the first place?  the kvm_mips 
prefix does tell us exactly what we are dealing with.

> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> ---
>   arch/mips/kvm/Makefile                            | 8 ++++----
>   arch/mips/kvm/{kvm_cb.c => callback.c}            | 0
>   arch/mips/kvm/{kvm_mips_commpage.c => commpage.c} | 2 +-
>   arch/mips/kvm/{kvm_mips_comm.h => commpage.h}     | 0
>   arch/mips/kvm/{kvm_mips_dyntrans.c => dyntrans.c} | 2 +-
>   arch/mips/kvm/{kvm_mips_emul.c => emulate.c}      | 6 +++---
>   arch/mips/kvm/{kvm_mips_int.c => interrupt.c}     | 2 +-
>   arch/mips/kvm/{kvm_mips_int.h => interrupt.h}     | 0
>   arch/mips/kvm/{kvm_locore.S => locore.S}          | 0
>   arch/mips/kvm/{kvm_mips.c => mips.c}              | 6 +++---
>   arch/mips/kvm/{kvm_mips_opcode.h => opcode.h}     | 0
>   arch/mips/kvm/{kvm_mips_stats.c => stats.c}       | 0
>   arch/mips/kvm/{kvm_tlb.c => tlb.c}                | 0
>   arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c}    | 4 ++--
>   14 files changed, 15 insertions(+), 15 deletions(-)
>   rename arch/mips/kvm/{kvm_cb.c => callback.c} (100%)
>   rename arch/mips/kvm/{kvm_mips_commpage.c => commpage.c} (97%)
>   rename arch/mips/kvm/{kvm_mips_comm.h => commpage.h} (100%)
>   rename arch/mips/kvm/{kvm_mips_dyntrans.c => dyntrans.c} (99%)
>   rename arch/mips/kvm/{kvm_mips_emul.c => emulate.c} (99%)
>   rename arch/mips/kvm/{kvm_mips_int.c => interrupt.c} (99%)
>   rename arch/mips/kvm/{kvm_mips_int.h => interrupt.h} (100%)
>   rename arch/mips/kvm/{kvm_locore.S => locore.S} (100%)
>   rename arch/mips/kvm/{kvm_mips.c => mips.c} (99%)
>   rename arch/mips/kvm/{kvm_mips_opcode.h => opcode.h} (100%)
>   rename arch/mips/kvm/{kvm_mips_stats.c => stats.c} (100%)
>   rename arch/mips/kvm/{kvm_tlb.c => tlb.c} (100%)
>   rename arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c} (99%)
>
> diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
> index 78d87bb..401fe02 100644
> --- a/arch/mips/kvm/Makefile
> +++ b/arch/mips/kvm/Makefile
> @@ -5,9 +5,9 @@ common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
>
>   EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
>
> -kvm-objs := $(common-objs) kvm_mips.o kvm_mips_emul.o kvm_locore.o \
> -	    kvm_mips_int.o kvm_mips_stats.o kvm_mips_commpage.o \
> -	    kvm_mips_dyntrans.o kvm_trap_emul.o
> +kvm-objs := $(common-objs) mips.o emulate.o locore.o \
> +	    interrupt.o stats.o commpage.o \
> +	    dyntrans.o trap_emul.o
>
>   obj-$(CONFIG_KVM)	+= kvm.o
> -obj-y			+= kvm_cb.o kvm_tlb.o
> +obj-y			+= callback.o tlb.o
> diff --git a/arch/mips/kvm/kvm_cb.c b/arch/mips/kvm/callback.c
> similarity index 100%
> rename from arch/mips/kvm/kvm_cb.c
> rename to arch/mips/kvm/callback.c
> diff --git a/arch/mips/kvm/kvm_mips_commpage.c b/arch/mips/kvm/commpage.c
> similarity index 97%
> rename from arch/mips/kvm/kvm_mips_commpage.c
> rename to arch/mips/kvm/commpage.c
> index 4b5612b..61b9c04 100644
> --- a/arch/mips/kvm/kvm_mips_commpage.c
> +++ b/arch/mips/kvm/commpage.c
> @@ -22,7 +22,7 @@
>
>   #include <linux/kvm_host.h>
>
> -#include "kvm_mips_comm.h"
> +#include "commpage.h"
>
>   void kvm_mips_commpage_init(struct kvm_vcpu *vcpu)
>   {
> diff --git a/arch/mips/kvm/kvm_mips_comm.h b/arch/mips/kvm/commpage.h
> similarity index 100%
> rename from arch/mips/kvm/kvm_mips_comm.h
> rename to arch/mips/kvm/commpage.h
> diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/dyntrans.c
> similarity index 99%
> rename from arch/mips/kvm/kvm_mips_dyntrans.c
> rename to arch/mips/kvm/dyntrans.c
> index fa7184d..521121b 100644
> --- a/arch/mips/kvm/kvm_mips_dyntrans.c
> +++ b/arch/mips/kvm/dyntrans.c
> @@ -18,7 +18,7 @@
>   #include <linux/bootmem.h>
>   #include <asm/cacheflush.h>
>
> -#include "kvm_mips_comm.h"
> +#include "commpage.h"
>
>   #define SYNCI_TEMPLATE  0x041f0000
>   #define SYNCI_BASE(x)   (((x) >> 21) & 0x1f)
> diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/emulate.c
> similarity index 99%
> rename from arch/mips/kvm/kvm_mips_emul.c
> rename to arch/mips/kvm/emulate.c
> index f9b4f0f..1a60688 100644
> --- a/arch/mips/kvm/kvm_mips_emul.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -29,9 +29,9 @@
>   #include <asm/r4kcache.h>
>   #define CONFIG_MIPS_MT
>
> -#include "kvm_mips_opcode.h"
> -#include "kvm_mips_int.h"
> -#include "kvm_mips_comm.h"
> +#include "opcode.h"
> +#include "interrupt.h"
> +#include "commpage.h"
>
>   #include "trace.h"
>
> diff --git a/arch/mips/kvm/kvm_mips_int.c b/arch/mips/kvm/interrupt.c
> similarity index 99%
> rename from arch/mips/kvm/kvm_mips_int.c
> rename to arch/mips/kvm/interrupt.c
> index d458c04..9b44459 100644
> --- a/arch/mips/kvm/kvm_mips_int.c
> +++ b/arch/mips/kvm/interrupt.c
> @@ -20,7 +20,7 @@
>
>   #include <linux/kvm_host.h>
>
> -#include "kvm_mips_int.h"
> +#include "interrupt.h"
>
>   void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
>   {
> diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/interrupt.h
> similarity index 100%
> rename from arch/mips/kvm/kvm_mips_int.h
> rename to arch/mips/kvm/interrupt.h
> diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/locore.S
> similarity index 100%
> rename from arch/mips/kvm/kvm_locore.S
> rename to arch/mips/kvm/locore.S
> diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/mips.c
> similarity index 99%
> rename from arch/mips/kvm/kvm_mips.c
> rename to arch/mips/kvm/mips.c
> index 289b4d2..d687c6e 100644
> --- a/arch/mips/kvm/kvm_mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -21,8 +21,8 @@
>
>   #include <linux/kvm_host.h>
>
> -#include "kvm_mips_int.h"
> -#include "kvm_mips_comm.h"
> +#include "interrupt.h"
> +#include "commpage.h"
>
>   #define CREATE_TRACE_POINTS
>   #include "trace.h"
> @@ -1188,7 +1188,7 @@ int __init kvm_mips_init(void)
>   	/*
>   	 * On MIPS, kernel modules are executed from "mapped space", which
>   	 * requires TLBs. The TLB handling code is statically linked with
> -	 * the rest of the kernel (kvm_tlb.c) to avoid the possibility of
> +	 * the rest of the kernel (tlb.c) to avoid the possibility of
>   	 * double faulting. The issue is that the TLB code references
>   	 * routines that are part of the the KVM module, which are only
>   	 * available once the module is loaded.
> diff --git a/arch/mips/kvm/kvm_mips_opcode.h b/arch/mips/kvm/opcode.h
> similarity index 100%
> rename from arch/mips/kvm/kvm_mips_opcode.h
> rename to arch/mips/kvm/opcode.h
> diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/stats.c
> similarity index 100%
> rename from arch/mips/kvm/kvm_mips_stats.c
> rename to arch/mips/kvm/stats.c
> diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/tlb.c
> similarity index 100%
> rename from arch/mips/kvm/kvm_tlb.c
> rename to arch/mips/kvm/tlb.c
> diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/trap_emul.c
> similarity index 99%
> rename from arch/mips/kvm/kvm_trap_emul.c
> rename to arch/mips/kvm/trap_emul.c
> index bd2f6bc..fd7257b 100644
> --- a/arch/mips/kvm/kvm_trap_emul.c
> +++ b/arch/mips/kvm/trap_emul.c
> @@ -16,8 +16,8 @@
>
>   #include <linux/kvm_host.h>
>
> -#include "kvm_mips_opcode.h"
> -#include "kvm_mips_int.h"
> +#include "opcode.h"
> +#include "interrupt.h"
>
>   static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
>   {
>
