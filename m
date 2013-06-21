Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 06:39:52 +0200 (CEST)
Received: from alvesta.synopsys.com ([198.182.60.77]:35921 "EHLO
        alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816409Ab3FUEjncAp4a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jun 2013 06:39:43 +0200
Received: from mailhost.synopsys.com (unknown [10.9.202.240])
        by alvesta.synopsys.com (Postfix) with ESMTP id 46800149A0;
        Thu, 20 Jun 2013 21:39:33 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1E19D61F;
        Thu, 20 Jun 2013 21:39:33 -0700 (PDT)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id DC7B1608;
        Thu, 20 Jun 2013 21:39:28 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.2.298.4; Thu, 20 Jun 2013 21:39:28 -0700
Received: from [10.12.197.14] (10.12.197.14) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.2.298.4; Fri, 21 Jun 2013 10:09:24 +0530
Message-ID: <51C3D8E7.5030601@synopsys.com>
Date:   Fri, 21 Jun 2013 10:09:03 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Santosh Shilimkar <santosh.shilimkar@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        <arm@kernel.org>, Chris Zankel <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        "Rob Herring" <rob.herring@calxeda.com>, <bigeasy@linutronix.de>,
        <robherring2@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-mips@linux-mips.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-xtensa@linux-xtensa.org>,
        <devicetree-discuss@lists.ozlabs.org>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
In-Reply-To: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.12.197.14]
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

Hi Santosh,

On 06/21/2013 06:22 AM, Santosh Shilimkar wrote:
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: x86@kernel.org
> Cc: arm@kernel.org
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: bigeasy@linutronix.de
> Cc: robherring2@gmail.com
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: devicetree-discuss@lists.ozlabs.org
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arc/mm/init.c            |    3 +--
>  arch/arm/mm/init.c            |    2 +-
>  arch/arm64/mm/init.c          |    3 +--
>  arch/c6x/kernel/devicetree.c  |    3 +--
>  arch/metag/mm/init.c          |    3 +--
>  arch/microblaze/kernel/prom.c |    3 +--
>  arch/mips/kernel/prom.c       |    3 +--
>  arch/openrisc/kernel/prom.c   |    3 +--
>  arch/powerpc/kernel/prom.c    |    3 +--
>  arch/x86/kernel/devicetree.c  |    3 +--
>  arch/xtensa/kernel/setup.c    |    3 +--
>  drivers/of/fdt.c              |   10 ++++++----
>  include/linux/of_fdt.h        |    3 +--
>  13 files changed, 18 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index 4a17736..3640c74 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -157,8 +157,7 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
>  #endif
>  
>  #ifdef CONFIG_OF_FLATTREE
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -					    unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	pr_err("%s(%lx, %lx)\n", __func__, start, end);
>  }

To avoid gcc warnings, you need to fix the print format specifiers too.

Thx,
-Vineet
