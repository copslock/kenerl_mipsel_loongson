Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 23:34:52 +0200 (CEST)
Received: from mail-gh0-f172.google.com ([209.85.160.172]:34288 "EHLO
        mail-gh0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817545Ab3GAVek0ffo4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jul 2013 23:34:40 +0200
Received: by mail-gh0-f172.google.com with SMTP id r18so2202482ghr.31
        for <multiple recipients>; Mon, 01 Jul 2013 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KeIuCLHaXMJpc288qPyYqtwLaIoETp8elhPYHHu79Eg=;
        b=pLGEtDiFMjMp7qWlabGWVPP3YLePIknoNmlKsG9hCEkaJnPnIXYqZBOCWViHLJ4jO2
         oz+lHaff/MKbcrdM/q/pLV6c/rNzkhulAvAO5T331qSFw+xcYIDd/nCHxCaUt5HyHYYZ
         0nwMA6/4cflVIys5htGGf5JVcsrxBgZgMBX/xEkbkhgk/YT71d/YfHRqy6xmR8kjmZ77
         j12fEAbOf2n40zJs7Wq2rTFiALT4wT70nA6kjnCBSXUhVf0lEnrb0omQpggGtX+4sbLC
         5aoPIJsDonkf68On7ONKCHd8aICvdqs0RmlwY0F2WaiTOo9QW951u2PmZxfUhWJfN+IS
         3YBA==
X-Received: by 10.236.70.9 with SMTP id o9mr13350041yhd.35.1372714473693;
        Mon, 01 Jul 2013 14:34:33 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPSA id s80sm35716355yhe.27.2013.07.01.14.34.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 14:34:33 -0700 (PDT)
Message-ID: <51D1F5E2.6070609@gmail.com>
Date:   Mon, 01 Jul 2013 16:34:26 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Santosh Shilimkar <santosh.shilimkar@ti.com>
CC:     grant.likely@linaro.org, Rob Herring <rob.herring@calxeda.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Vineet Gupta <vgupta@synopsys.com>,
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
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v2] of: Specify initrd location using 64-bit
References: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com>
In-Reply-To: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On 07/01/2013 01:20 PM, Santosh Shilimkar wrote:
> On some PAE architectures, the entire range of physical memory could reside
> outside the 32-bit limit.  These systems need the ability to specify the
> initrd location using 64-bit numbers.
> 
> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> use 64-bit numbers instead of the current unsigned long.
> 
> There has been quite a bit of debate about whether to use u64 or phys_addr_t.
> It was concluded to stick to u64 to be consistent with rest of the device
> tree code. As summarized by Geert, "The address to load the initrd is decided
> by the bootloader/user and set at that point later in time. The dtb should not
> be tied to the kernel you are booting"

That was quoting me. Otherwise:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Unless Grant feels compelled to pick this up for 3.11, I think it has to
wait for 3.12.

Rob

> 
> More details on the discussion can be found here:
> https://lkml.org/lkml/2013/6/20/690
> https://lkml.org/lkml/2012/9/13/544
> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
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
>  arch/arc/mm/init.c            |    5 ++---
>  arch/arm/mm/init.c            |    2 +-
>  arch/arm64/mm/init.c          |    3 +--
>  arch/c6x/kernel/devicetree.c  |    3 +--
>  arch/metag/mm/init.c          |    5 ++---
>  arch/microblaze/kernel/prom.c |    3 +--
>  arch/mips/kernel/prom.c       |    3 +--
>  arch/openrisc/kernel/prom.c   |    3 +--
>  arch/powerpc/kernel/prom.c    |    3 +--
>  arch/x86/kernel/devicetree.c  |    3 +--
>  arch/xtensa/kernel/setup.c    |    3 +--
>  drivers/of/fdt.c              |   10 ++++++----
>  include/linux/of_fdt.h        |    3 +--
>  13 files changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index 4a17736..7991e08 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -157,9 +157,8 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
>  #endif
>  
>  #ifdef CONFIG_OF_FLATTREE
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -					    unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
> -	pr_err("%s(%lx, %lx)\n", __func__, start, end);
> +	pr_err("%s(%llx, %llx)\n", __func__, start, end);
>  }
>  #endif /* CONFIG_OF_FLATTREE */
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 9a5cdc0..afeaef7 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
>  __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>  
>  #ifdef CONFIG_OF_FLATTREE
> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	phys_initrd_start = start;
>  	phys_initrd_size = end - start;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f497ca7..7047708 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -44,8 +44,7 @@ static unsigned long phys_initrd_size __initdata = 0;
>  
>  phys_addr_t memstart_addr __read_mostly = 0;
>  
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -					    unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	phys_initrd_start = start;
>  	phys_initrd_size = end - start;
> diff --git a/arch/c6x/kernel/devicetree.c b/arch/c6x/kernel/devicetree.c
> index bdb56f0..287d0e6 100644
> --- a/arch/c6x/kernel/devicetree.c
> +++ b/arch/c6x/kernel/devicetree.c
> @@ -33,8 +33,7 @@ void __init early_init_devtree(void *params)
>  
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -		unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (unsigned long)__va(start);
>  	initrd_end = (unsigned long)__va(end);
> diff --git a/arch/metag/mm/init.c b/arch/metag/mm/init.c
> index d05b845..bdc4811 100644
> --- a/arch/metag/mm/init.c
> +++ b/arch/metag/mm/init.c
> @@ -419,10 +419,9 @@ void free_initrd_mem(unsigned long start, unsigned long end)
>  #endif
>  
>  #ifdef CONFIG_OF_FLATTREE
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -					    unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
> -	pr_err("%s(%lx, %lx)\n",
> +	pr_err("%s(%llx, %llx)\n",
>  	       __func__, start, end);
>  }
>  #endif /* CONFIG_OF_FLATTREE */
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
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index 5712bb5..32b8788 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -58,8 +58,7 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -					    unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (unsigned long)__va(start);
>  	initrd_end = (unsigned long)__va(end);
> diff --git a/arch/openrisc/kernel/prom.c b/arch/openrisc/kernel/prom.c
> index 5869e3f..150215a 100644
> --- a/arch/openrisc/kernel/prom.c
> +++ b/arch/openrisc/kernel/prom.c
> @@ -96,8 +96,7 @@ void __init early_init_devtree(void *params)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -		unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (unsigned long)__va(start);
>  	initrd_end = (unsigned long)__va(end);
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 8b6f7a9..2f3e252 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -550,8 +550,7 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -		unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (unsigned long)__va(start);
>  	initrd_end = (unsigned long)__va(end);
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index b158152..2fbad6b 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -52,8 +52,7 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -					    unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (unsigned long)__va(start);
>  	initrd_end = (unsigned long)__va(end);
> diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
> index 6dd25ec..d45e602 100644
> --- a/arch/xtensa/kernel/setup.c
> +++ b/arch/xtensa/kernel/setup.c
> @@ -170,8 +170,7 @@ static int __init parse_tag_fdt(const bp_tag_t *tag)
>  
>  __tagtable(BP_TAG_FDT, parse_tag_fdt);
>  
> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
> -		unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>  {
>  	initrd_start = (void *)__va(start);
>  	initrd_end = (void *)__va(end);
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 808be06..21123b8 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -550,7 +550,8 @@ int __init of_flat_dt_match(unsigned long node, const char *const *compat)
>   */
>  void __init early_init_dt_check_for_initrd(unsigned long node)
>  {
> -	unsigned long start, end, len;
> +	u64 start, end;
> +	unsigned long len;
>  	__be32 *prop;
>  
>  	pr_debug("Looking for initrd properties... ");
> @@ -558,15 +559,16 @@ void __init early_init_dt_check_for_initrd(unsigned long node)
>  	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &len);
>  	if (!prop)
>  		return;
> -	start = of_read_ulong(prop, len/4);
> +	start = of_read_number(prop, len/4);
>  
>  	prop = of_get_flat_dt_prop(node, "linux,initrd-end", &len);
>  	if (!prop)
>  		return;
> -	end = of_read_ulong(prop, len/4);
> +	end = of_read_number(prop, len/4);
>  
>  	early_init_dt_setup_initrd_arch(start, end);
> -	pr_debug("initrd_start=0x%lx  initrd_end=0x%lx\n", start, end);
> +	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n",
> +		 (unsigned long long)start, (unsigned long long)end);
>  }
>  #else
>  inline void early_init_dt_check_for_initrd(unsigned long node)
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index ed136ad..4a17939 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -106,8 +106,7 @@ extern u64 dt_mem_next_cell(int s, __be32 **cellp);
>   * physical addresses.
>   */
>  #ifdef CONFIG_BLK_DEV_INITRD
> -extern void early_init_dt_setup_initrd_arch(unsigned long start,
> -					    unsigned long end);
> +extern void early_init_dt_setup_initrd_arch(u64 start, u64 end);
>  #endif
>  
>  /* Early flat tree scan hooks */
> 
