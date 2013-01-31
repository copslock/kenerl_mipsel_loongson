Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 21:12:56 +0100 (CET)
Received: from mail-da0-f43.google.com ([209.85.210.43]:41412 "EHLO
        mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825898Ab3AaUMz7XVsd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jan 2013 21:12:55 +0100
Received: by mail-da0-f43.google.com with SMTP id u36so1432597dak.16
        for <multiple recipients>; Thu, 31 Jan 2013 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=c0oZ25/t5AMMOdl27UNSXoM5A1c5nmtuWXVuoiqIo/w=;
        b=K1fP6Ru1ax+Tui4C6zeInWHgmHeUP9VoR+70TowTVIhEu8mA3yx/z8cVz38JXHhdSq
         4xp0XRM2WsXUz4bT9Mfr4pkLv5uRouQMUPoT7nkrfrCCbFXnd/MmqEyzApY0EKZJlPrv
         iGNhqy0C7zFABw3VIrf3j0GDiV0O1boWSFMgmc4fKsmIJA541TgMJnmLe11gKo8P9b38
         WtsNEHJMx9Z9kUVI73c4iYHEyknbe8RFqlW4Ngnv8CurSaWQUMPgIQgl6xwUdWi9O660
         j15aN/oHWoqJ27ye6Pik6/KYYiXR/E2zC+Lc1HX2EvGIo1jrZwgp9eebz1TvCdPEJbPH
         wMAw==
X-Received: by 10.68.203.137 with SMTP id kq9mr25168750pbc.115.1359663169015;
        Thu, 31 Jan 2013 12:12:49 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ba3sm5895276pbd.29.2013.01.31.12.12.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 12:12:47 -0800 (PST)
Message-ID: <510AD03E.1030105@gmail.com>
Date:   Thu, 31 Jan 2013 12:12:46 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 02/18] KVM/MIPS32: Arch specific KVM data structures.
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com> <1353551656-23579-3-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1353551656-23579-3-git-send-email-sanjayl@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35674
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/21/2012 06:34 PM, Sanjay Lal wrote:
> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/include/asm/kvm.h      |  55 ++++

asm/kvm.h defines the user space ABI, and thus should be placed in 
arch/mips/include/uapi/asm instead.



>   arch/mips/include/asm/kvm_host.h | 669 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 724 insertions(+)
>   create mode 100644 arch/mips/include/asm/kvm.h
>   create mode 100644 arch/mips/include/asm/kvm_host.h
>
> diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
> new file mode 100644
> index 0000000..85789ea
> --- /dev/null
> +++ b/arch/mips/include/asm/kvm.h
> @@ -0,0 +1,55 @@
> +/*
> +* This file is subject to the terms and conditions of the GNU General Public
> +* License.  See the file "COPYING" in the main directory of this archive
> +* for more details.
> +*
> +* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
> +* Authors: Sanjay Lal <sanjayl@kymasys.com>
> +*/
> +
> +#ifndef __LINUX_KVM_MIPS_H
> +#define __LINUX_KVM_MIPS_H
> +
> +#include <linux/types.h>
> +
> +#define __KVM_MIPS
> +
> +#define N_MIPS_COPROC_REGS      32
> +#define N_MIPS_COPROC_SEL   	8
> +
> +/* for KVM_GET_REGS and KVM_SET_REGS */
> +struct kvm_regs {
> +	__u32 gprs[32];

MIPS64 registers are 64 bits wide.  How is this going to work for MIPS64?

It seems a little important to answer this question as this is a 
userspace ABI that really cannot be changed once it is published.


> +	__u32 hi;
> +	__u32 lo;
> +	__u32 pc;
> +
> +	__u32 cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];

Do we really want CP0 regs in here?  Other architectures don't have 
things like this.  They use things like KVM_GET_MSRS and KVM_SET_MSRS 
for this.

> +};
> +
> +/* for KVM_GET_SREGS and KVM_SET_SREGS */
> +struct kvm_sregs {
> +};
> +
> +/* for KVM_GET_FPU and KVM_SET_FPU */
> +struct kvm_fpu {

This is a userspace ABI, and MIPS definitely has a FPU.  That means that 
we cannot change the definition after it is merged, but we know this 
must have the FPU registers in it.

So it cannot be both present and empty.


> +};
> +
> +struct kvm_debug_exit_arch {
> +};
> +
> +/* for KVM_SET_GUEST_DEBUG */
> +struct kvm_guest_debug_arch {
> +};
> +
> +struct kvm_mips_interrupt {
> +	/* in */
> +	__u32 cpu;
> +	__u32 irq;
> +};
> +
> +/* definition of registers in kvm_run */
> +struct kvm_sync_regs {
> +};
> +
> +#endif /* __LINUX_KVM_MIPS_H */
[...]
