Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 22:23:45 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37793 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903346Ab2ILUXi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 22:23:38 +0200
Received: by obbta17 with SMTP id ta17so3443552obb.36
        for <multiple recipients>; Wed, 12 Sep 2012 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LAg63+2yvHZORhQUOjlpS9uYpijGQI3981O7/ek8vtU=;
        b=mZdJncWwtBCqrZrCwf0s2J9jsW4/PPa2jyHorSjFZV5bpOLUvnBomwlJfr5o7Li/S0
         pKsMRT2O6bGD82cMJEEzr3u4tGPpnc7XlflmBK1JD8a4zvo2RrHuQSU7RP8/XPQprquz
         9R8sW2zBe/6jJDAmLzAtLRRsE72GrsffPUPxWJqj52S2tXSbQlihKZETWhjVZ4tLe0b5
         vqwm8AXkiFtUl1s7/wJO5qFRtHMpH0H0qFk5YJf2fkxRNW2r01BGY4Lhacl4YDxEgplb
         bCH++pl03l3sc+aF8SjqQ7o40EuXVJLyxrXU0qV3sWXcMN/1rFfXjz76MEgLUWviwInC
         S7fg==
Received: by 10.60.171.138 with SMTP id au10mr24825772oec.39.1347481411344;
        Wed, 12 Sep 2012 13:23:31 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPS id 2sm21227455obi.20.2012.09.12.13.23.28
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 13:23:30 -0700 (PDT)
Message-ID: <5050EF3F.6030003@gmail.com>
Date:   Wed, 12 Sep 2012 15:23:27 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     Cyril Chemparathy <cyril@ti.com>
CC:     devicetree-discuss@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux@openrisc.net, linuxppc-dev@lists.ozlabs.org,
        microblaze-uclinux@itee.uq.edu.au, x86@kernel.org,
        david.daney@cavium.com, benh@kernel.crashing.org,
        bigeasy@linutronix.de, grant.likely@secretlab.ca,
        paul.gortmaker@windriver.com, paulus@samba.org, hpa@zytor.com,
        m.szyprowski@samsung.com, jonas@southpole.se,
        linux@arm.linux.org.uk, nico@linaro.org, a-jacquiot@ti.com,
        mingo@redhat.com, suzuki@in.ibm.com, mahesh@linux.vnet.ibm.com,
        linus.walleij@linaro.org, arnd@arndb.de, msalter@redhat.com,
        rob.herring@calxeda.com, tglx@linutronix.de, blogic@openwrt.org,
        dhowells@redhat.com, monstr@monstr.eu, ralf@linux-mips.org,
        tj@kernel.org
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
In-Reply-To: <1347465937-7056-1-git-send-email-cyril@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34485
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/12/2012 11:05 AM, Cyril Chemparathy wrote:
> On some PAE architectures, the entire range of physical memory could reside
> outside the 32-bit limit.  These systems need the ability to specify the
> initrd location using 64-bit numbers.
> 
> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> use 64-bit numbers instead of the current unsigned long.

S-o-B?

> ---
>  arch/arm/mm/init.c            |    2 +-
>  arch/c6x/kernel/devicetree.c  |    3 +--
>  arch/microblaze/kernel/prom.c |    3 +--
>  arch/mips/kernel/prom.c       |    3 +--
>  arch/openrisc/kernel/prom.c   |    3 +--
>  arch/powerpc/kernel/prom.c    |    3 +--
>  arch/x86/kernel/devicetree.c  |    3 +--
>  drivers/of/fdt.c              |   10 ++++++----
>  include/linux/of_fdt.h        |    3 +--
>  9 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index ad722f1..579792c 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
>  __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>  
>  #ifdef CONFIG_OF_FLATTREE
> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)

phys_initrd_start/size need to change too. Not sure about similar things
on other arches.

Does u-boot need similar fixes?

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
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 4a764cc..cecd42c 100644
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
> index 028f6f8..e37e0dc 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -41,8 +41,7 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
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
> index 37725e8..ac15f63 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -549,8 +549,7 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
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
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 91a375f..2ff8b7a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -554,7 +554,8 @@ int __init of_flat_dt_match(unsigned long node, const char *const *compat)
>   */
>  void __init early_init_dt_check_for_initrd(unsigned long node)
>  {
> -	unsigned long start, end, len;
> +	u64 start, end;
> +	unsigned long len;
>  	__be32 *prop;
>  
>  	pr_debug("Looking for initrd properties... ");
> @@ -562,15 +563,16 @@ void __init early_init_dt_check_for_initrd(unsigned long node)
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
