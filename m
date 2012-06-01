Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2012 18:59:25 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55388 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903608Ab2FAQ7S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2012 18:59:18 +0200
Received: by pbbrq13 with SMTP id rq13so3532389pbb.36
        for <multiple recipients>; Fri, 01 Jun 2012 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wbLRlIRQ0gm2LiNUXyElqCgrygSzoMO1bWGOWHNTWAU=;
        b=k11OuMGjCTvzNh7rawnPmS2K5WIql00y9kaZD4WQWJLRXsPGND0H3p3rNDMwzRSM0G
         ph9Ir6uoyrpm6xkUHhCT8tSlwiqsQO9F9c/MhIsn9sTGqIFXIjjJ53CTARKetscIr19I
         tbuv0wxHjsSHXrjqd/x6QzNFMMQwZPGNFjQdNNpshZAN+BaWOzG0jDlNXn1Laf9gQuCH
         7IyKsU3xnUZB7WQE4QPFCSikauRaFAUU0g5B2CG+JfqZLffQgc+OVi3JozuYa5ljCUcC
         MglRUGNeeptRwGaVtNHLIJzApwoyVPCKbIJvthFKESUsrh5lLEmRf/E1quc1Fet+D1UQ
         Nbkg==
Received: by 10.68.240.105 with SMTP id vz9mr4905000pbc.119.1338569951304;
        Fri, 01 Jun 2012 09:59:11 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ua6sm3303728pbc.20.2012.06.01.09.59.08
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jun 2012 09:59:09 -0700 (PDT)
Message-ID: <4FC8F4DB.2070906@gmail.com>
Date:   Fri, 01 Jun 2012 09:59:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
CC:     tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au,
        mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org,
        vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jeremy Fitzhardinge <jeremy@goop.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mike Frysinger <vapier@gentoo.org>,
        Venkatesh Pallipadi <venki@google.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xensource.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 03/27] smpboot: Define and use cpu_state per-cpu variable
 in generic code
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091038.31979.67878.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601091038.31979.67878.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33505
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

On 06/01/2012 02:10 AM, Srivatsa S. Bhat wrote:
> The per-cpu variable cpu_state is used in x86 and also used in other
> architectures, to track the state of the cpu during bringup and hotplug.
> Pull it out into generic code.
>
> Cc: Tony Luck<tony.luck@intel.com>
> Cc: Fenghua Yu<fenghua.yu@intel.com>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Paul Mundt<lethal@linux-sh.org>
> Cc: Chris Metcalf<cmetcalf@tilera.com>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Ingo Molnar<mingo@redhat.com>
> Cc: "H. Peter Anvin"<hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Konrad Rzeszutek Wilk<konrad.wilk@oracle.com>
> Cc: Jeremy Fitzhardinge<jeremy@goop.org>
> Cc: Peter Zijlstra<a.p.zijlstra@chello.nl>
> Cc: Andrew Morton<akpm@linux-foundation.org>
> Cc: Mike Frysinger<vapier@gentoo.org>
> Cc: Yong Zhang<yong.zhang0@gmail.com>
> Cc: Venkatesh Pallipadi<venki@google.com>
> Cc: Suresh Siddha<suresh.b.siddha@intel.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Srivatsa S. Bhat<srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>   arch/ia64/include/asm/cpu.h   |    2 --
>   arch/ia64/kernel/process.c    |    1 +
>   arch/ia64/kernel/smpboot.c    |    6 +-----
>   arch/mips/cavium-octeon/smp.c |    4 +---
>   arch/powerpc/kernel/smp.c     |    6 +-----
>   arch/sh/include/asm/smp.h     |    2 --
>   arch/sh/kernel/smp.c          |    4 +---
>   arch/tile/kernel/smpboot.c    |    4 +---
>   arch/x86/include/asm/cpu.h    |    2 --
>   arch/x86/kernel/smpboot.c     |    4 +---
>   arch/x86/xen/smp.c            |    1 +
>   include/linux/smpboot.h       |    1 +
>   kernel/smpboot.c              |    4 ++++
>   13 files changed, 13 insertions(+), 28 deletions(-)
>
[...]
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 97e7ce9..93cd4b0 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -13,6 +13,7 @@
>   #include<linux/kernel_stat.h>
>   #include<linux/sched.h>
>   #include<linux/module.h>
> +#include<linux/smpboot.h>
>
>   #include<asm/mmu_context.h>
>   #include<asm/time.h>
> @@ -252,9 +253,6 @@ static void octeon_cpus_done(void)
>
>   #ifdef CONFIG_HOTPLUG_CPU
>
> -/* State of each CPU. */
> -DEFINE_PER_CPU(int, cpu_state);
> -
>   extern void fixup_irqs(void);
>
>   static DEFINE_SPINLOCK(smp_reserve_lock);

The Octeon bit:

Acked-by: David Daney <david.daney@cavium.com>


FWIW, the rest looks good too.
