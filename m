Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 12:53:46 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:55404 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27033564AbcE2Kxmw3WCv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 May 2016 12:53:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A58B3B91D88;
        Sun, 29 May 2016 12:53:41 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.0.2] (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id CD72DB91D74;
        Sun, 29 May 2016 12:53:30 +0200 (CEST)
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        linux-mips@linux-mips.org
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
 <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
Cc:     hauke@hauke-m.de, openwrt@kresin.me, antonynpavlov@gmail.com
From:   Jonas Gorski <jogo@openwrt.org>
Message-ID: <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
Date:   Sun, 29 May 2016 12:53:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On 27.05.2016 23:06, Daniel Gimpelevich wrote:
> On Mon, 23 May 2016 22:32:10 -0700
> Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> wrote:
>> On Mon, 2016-05-23 at 15:12 -0700, Daniel Gimpelevich wrote:
>>> On Mon, 2016-05-23 at 23:34 +0200, Hauke Mehrtens wrote:
>>>> On 05/23/2016 11:14 PM, Hauke Mehrtens wrote:
>>>>> Section 3 of this document defines some interfaces how a boot loader
>>>>> could forward a command line *or* a device tree to the kernel:
>>>>> http://wiki.prplfoundation.org/w/images/4/42/UHI_Reference_Manual.pdf
>>>>> This allows only a device tree *or* a command line, not both.
>>>>>
>>>>> The Linux kernel also supports an appended device tree. In this case the
>>>>> early code overwrites the fw_args to look like the boot loader added a
>>>>> device tree. This is done when CONFIG_MIPS_RAW_APPENDED_DTB is activated.
>>>>>
>>>>> The problem is when we use an appended device tree and the boot loader
>>>>> adds some important information in the kernel command line. In this case
>>>>> the command line gets overwritten and we do not get this information.
>>>>> This is the case for some lantiq devices were the boot loader provides
>>>>> the mac address to the kernel via the kernel command line.
>>>>>
>>>>> My proposal to solve this problem is to extend the interface and add a
>>>>> option to provide the kernel command line *and* a device tree from the
>>>>> boot loader to the kernel.
>>>>>
>>>>> a) use fw_arg0 ($a0) = -2 and fill the unused registers fw_arg2 ($a2)
>>>>> and fw_arg3 ($a3) with argv and envp.
>>>>>
>>>>> b) add a new boot protocol $a0 = -3 with $a1 = DT address, $a2 = argv
>>>>> and $a3 = envp.
>>>>
>>>> I just looked a little bit more closely and saw that the command line
>>>> uses 3 args. One for the count, one argv and one envp.
>>>>
>>>> I would then only support device tree + count and argv, so the new
>>>> interface would not support envp.
>>>>
>>>>>
>>>>> I would prefer solution b).
>>>>>
>>>>> This way we would not loose the kernel command line when appending a
>>>>> device tree and this could also be used by the boot loader if someone
>>>>> wants to.
>>>>>
>>>>> Should I send a patch for this?
>>>>>
>>>>> Hauke
>>>
>>> It was because I looked through the above-linked UHI spec that I became
>>> concerned about CONFIG_MIPS_RAW_APPENDED_DTB only mimicking, rather than
>>> fully implementing, real UHI. In the upstream kernel, the new $a0 == -2
>>> code can be a starting point for adding UHI argv/envp parsing for when a
>>> UHI-compliant bootloader is used. However, on the head.S side, what I
>>> propose for the lantiq target is to remove CONFIG_MIPS_RAW_APPENDED_DTB
>>> from the kernel config, and reintroduce this as a platform patch:
>>> https://github.com/openwrt/openwrt/blob/b3158f781f24ac2ec1c0da86479bfc156c52c80b/target/linux/lantiq/patches-4.4/0036-owrt-generic-dtb-image-hack.patch
>>> The brcm63xx target could then retain CONFIG_MIPS_RAW_APPENDED_DTB, or
>>> not, depending on bootloader specifics there, which I have not
>>> investigated, and likewise the various other targets to which
>>> CONFIG_MIPS_RAW_APPENDED_DTB has since been extended even though it was
>>> apparently initially only an expedient hack only for brcm63xx.
>>>
>>> Using $a0 = -3 is expressly prohibited in the above UHI document, and
>>> using $a2/$a3 "would risk becoming incompatible with existing UHI
>>> compliant implementations."
>>
>> I have come up with a more elegant solution: Simply move the register
>> substitution from head.S to just before it matters. You can still
>> override the boot args using CONFIG_MIPS_CMDLINE_FROM_DTB.
> 
> Resending with only the changes Antonyn requested, since Hauke doesn't seem to
> be following up on his concerns anymore. Thanks go to both of them.
> 
> Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
> ---
>  arch/mips/bmips/setup.c          |  7 +++++++
>  arch/mips/boot/compressed/head.S | 16 ----------------
>  arch/mips/include/asm/prom.h     |  5 +++++
>  arch/mips/kernel/head.S          | 16 ----------------
>  arch/mips/lantiq/prom.c          |  7 +++++++
>  5 files changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index f146d12..3a327d4 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -160,6 +160,13 @@ void __init plat_mem_setup(void)
>  	ioport_resource.end = ~0;
>  
>  	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
> +#if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB)) ||\
> +		(IS_ENABLED(CONFIG_MIPS_ZBOOT_APPENDED_DTB))
> +	if (be32_to_cpup((__be32 *)__appended_dtb) == OF_DT_HEADER) {
> +		fw_arg0 = -2;
> +		fw_arg1 = (unsigned long)__appended_dtb;
> +	}
> +#endif

This will break/won't compile for ZBOOT_APPENDED_DTB as __appended_dtb is
part of the wrapping decompressor, and the kernel has no knowledge of this
this symbol.

>  	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
>  		dtb = phys_to_virt(fw_arg2);
>  	else if (fw_arg0 == -2) /* UHI interface */
> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index c580e85..409cb48 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -25,22 +25,6 @@ start:
>  	move	s2, a2
>  	move	s3, a3
>  
> -#ifdef CONFIG_MIPS_ZBOOT_APPENDED_DTB
> -	PTR_LA	t0, __appended_dtb
> -#ifdef CONFIG_CPU_BIG_ENDIAN
> -	li	t1, 0xd00dfeed
> -#else
> -	li	t1, 0xedfe0dd0
> -#endif
> -	lw	t2, (t0)
> -	bne	t1, t2, not_found
> -	 nop
> -
> -	move	s1, t0
> -	PTR_LI	s0, -2
> -not_found:
> -#endif
> -

For the ZBOOT appended dtb, maybe the following way would be better:
(completely not compile tested, just as "pseudo code")

--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -36,6 +36,10 @@ extern void puthex(unsigned long long val);
 #define puthex(val) do {} while (0)
 #endif
 
+#ifdef CONFIG_MIPS_APPENDED_DTB
+extern char __appended_dtb[];
+#endif
+
 void error(char *x)
 {
 	puts("\n\n");
@@ -87,7 +91,7 @@ void __stack_chk_fail(void)
 
 void decompress_kernel(unsigned long boot_heap_start)
 {
-	unsigned long zimage_start, zimage_size;
+	unsigned long zimage_start, zimage_size, uncompressed_size;
 
 	__stack_chk_guard_setup();
 
@@ -112,7 +116,17 @@ void decompress_kernel(unsigned long boot_heap_start)
 
 	/* Decompress the kernel with according algorithm */
 	__decompress((char *)zimage_start, zimage_size, 0, 0,
-		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, 0, error);
+		   (void *)VMLINUX_LOAD_ADDRESS_ULL, &uncompressed_size, 0,
+		   error);
+
+#ifdef CONFIG_MIPS_APPENDED_DTB
+	if (be32_to_cpup((void *)__appended_dtb) == 0xd00dfeed) {
+		long size = be32_to_cpup((void *)__appended_dtb + 4);
+
+		memcpy(VMLINUX_LOAD_ADDRESS_ULL + uncompressed_size,
+		       __appended_dtb, size);
+	}
+#endif
 
 	/* FIXME: should we flush cache here? */
 	puts("Now, booting the kernel...\n");

Then we don't need to have ZBOOT_APPENDED_DTB at all, and it would work
like the normal APPENDED_DTB case (and wouldn't touch a0~a3).

>  	/* Clear BSS */
>  	PTR_LA	a0, _edata
>  	PTR_LA	a2, _end
> diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
> index 0b4b668..6c29697 100644
> --- a/arch/mips/include/asm/prom.h
> +++ b/arch/mips/include/asm/prom.h
> @@ -28,6 +28,11 @@ extern int __dt_register_buses(const char *bus0, const char *bus1);
>  static inline void device_tree_init(void) { }
>  #endif /* CONFIG_OF */
>  
> +#if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB)) ||\
> +		(IS_ENABLED(CONFIG_MIPS_ZBOOT_APPENDED_DTB))
> +extern const char __appended_dtb[];
> +#endif
> +
>  extern char *mips_get_machine_name(void);
>  extern void mips_set_machine_name(const char *name);
>  
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index 56e8fed..766205c 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -93,22 +93,6 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
>  	jr	t0
>  0:
>  
> -#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
> -	PTR_LA		t0, __appended_dtb
> -
> -#ifdef CONFIG_CPU_BIG_ENDIAN
> -	li		t1, 0xd00dfeed
> -#else
> -	li		t1, 0xedfe0dd0
> -#endif
> -	lw		t2, (t0)
> -	bne		t1, t2, not_found
> -	 nop
> -
> -	move		a1, t0
> -	PTR_LI		a0, -2
> -not_found:
> -#endif

Maybe a better solution here would be to create a new symbol
fw_passed_dtb and let the code store a1 in there if a0 is -2, or
__appended_dtb in case it is valid? Then we wouldn't need to special
case APPENDED_DTB for any mach wanting to use it, and they can just
check fw_passed_dtb.

something like:

arch/mips/kernel/head.S:
...

#ifdef CONFIG_USE_OF
	li		t1, -2
	beq		a0, t1, dtb_found
	move		t0, a0

#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
	PTR_LA		t0, __appended_dtb

#ifdef CONFIG_CPU_BIG_ENDIAN
	li		t1, 0xd00dfeed
#else
	li		t1, 0xedfe0dd0
#endif
	lw		t2, (t0)
	bne		t1, t2, no_dtb_found
	 nop

#endif
no_dtb_found:
	li		t0, 0
dtb_found:
	LONG_S		t0, fw_passed_dtb
#endif

then all that needs to be done for e.g. bmips is:

--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -162,8 +162,8 @@ void __init plat_mem_setup(void)
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
-	else if (fw_arg0 == -2) /* UHI interface */
-		dtb = (void *)fw_arg1;
+	else if (fw_passed_dtb) /* UHI interface */
+		dtb = (void *)fw_passed_dtb;
 	else if (__dtb_start != __dtb_end)
 		dtb = (void *)__dtb_start;
 	else

and consequently fw_argX remains untouched for either case.


Regards
Jonas
