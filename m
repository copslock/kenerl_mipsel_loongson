Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 11:04:59 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:38922 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817318Ab3FUJE4QfHfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jun 2013 11:04:56 +0200
Received: from localhost ([127.0.0.1] helo=[172.123.10.21])
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <bigeasy@linutronix.de>)
        id 1UpxGh-0004t7-0N; Fri, 21 Jun 2013 11:04:31 +0200
Message-ID: <51C4171C.9050908@linutronix.de>
Date:   Fri, 21 Jun 2013 11:04:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130518 Icedove/17.0.5
MIME-Version: 1.0
To:     Santosh Shilimkar <santosh.shilimkar@ti.com>
CC:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        arm@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>, robherring2@gmail.com,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
In-Reply-To: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bigeasy@linutronix.de
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

On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 0a2c68f..62e2e8f 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -		unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (unsigned long)__va(start);
>  	initrd_end = (unsigned long)__va(end);

I think it would better to go here for phys_addr_t instead of u64. This
would force you in of_flat_dt_match() to check if the value passed from
DT specifies a memory address outside of 32bit address space and the
kernel can't deal with this because its phys_addr_t is 32bit only due
to a Kconfig switch.

For x86, the initrd has to remain in the 32bit address space so passing
the initrd in the upper range would violate the ABI. Not sure if this
is true for other archs as well (ARM obviously not).

Sebastian
