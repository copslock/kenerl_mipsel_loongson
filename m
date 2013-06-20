Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 15:38:12 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:55437 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819547Ab3FTNiJ7b0Y6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 15:38:09 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r5KDc2lN025757
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Jun 2013 06:38:02 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.2.342.3; Thu, 20 Jun 2013
 06:38:01 -0700
Message-ID: <51C305E4.4080705@windriver.com>
Date:   Thu, 20 Jun 2013 09:38:44 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] mips: delete __cpuinit/__CPUINIT usage from MIPS code
References: <1371566339-18336-1-git-send-email-paul.gortmaker@windriver.com> <51C22E75.3020001@gmail.com> <20130620002806.GA15693@windriver.com> <20130620021550.GA17009@linux-mips.org>
In-Reply-To: <20130620021550.GA17009@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.146.65]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On 13-06-19 10:15 PM, Ralf Baechle wrote:
> On Wed, Jun 19, 2013 at 08:28:07PM -0400, Paul Gortmaker wrote:
> 
>> I am literally in the middle of typing up a mail to linux-arch that
>> explains this, and that the no-op step comes in at the beginning of the
>> merge window, and that the big purge comes at the end.
>>
>> However, I do not want that process to be set in stone ; as Ralf indicated,
>> he expected some changes to the mips tree and wanted to deal with the
>> conflicts himself (which is fine by me!) and so we can do that at the
>> expense of some temporary section warnings.  This is why I explicitly
>> called them out in the above commit log.
>>
>>> Once that is working, we would make a second pass and remove the
>>> symbols themselves.
>>
>> Yep, thanks for looking at things; it sounds like we are in alignment
>> with how to proceed here -- only that I wasn't quick enough in getting
>> the steps published and the no-op phase into linux-next.
> 
> And I having come to the same conclusion have spent the last few hours
> running a test build with the following patch applied.  It does
> 
>  - make __cpuinit, __cpuinitdata, __cpuinitconst, __cpuexit, __cpuexitdata
>    and __cpuexitconst nops.
>  - with .cpuinit.* and .cpuexit.* sections now being unused support for
>    these sections in linker scripts and modpost is no longer required.

Thanks!  I realized I'd not cleaned up modpost last night while writing
up the linux-arch mail (not yet sent) and added it to the patch queue:

http://git.kernel.org/cgit/linux/kernel/git/paulg/cpuinit-delete.git/log/

I had the dummied out init in the patch queue, but I didn't have linker
script change yet -- I'll add that in today.

Paul.
--

> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  include/asm-generic/vmlinux.lds.h | 20 ---------------
>  include/linux/init.h              | 18 +++++++-------
>  scripts/mod/modpost.c             | 52 +++++++--------------------------------
>  3 files changed, 18 insertions(+), 72 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index eb58d2d..eab362e 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -76,14 +76,6 @@
>  #define DEV_DISCARD(sec) *(.dev##sec)
>  #endif
>  
> -#ifdef CONFIG_HOTPLUG_CPU
> -#define CPU_KEEP(sec)    *(.cpu##sec)
> -#define CPU_DISCARD(sec)
> -#else
> -#define CPU_KEEP(sec)
> -#define CPU_DISCARD(sec) *(.cpu##sec)
> -#endif
> -
>  #if defined(CONFIG_MEMORY_HOTPLUG)
>  #define MEM_KEEP(sec)    *(.mem##sec)
>  #define MEM_DISCARD(sec)
> @@ -184,8 +176,6 @@
>  	*(.data..shared_aligned) /* percpu related */			\
>  	DEV_KEEP(init.data)						\
>  	DEV_KEEP(exit.data)						\
> -	CPU_KEEP(init.data)						\
> -	CPU_KEEP(exit.data)						\
>  	MEM_KEEP(init.data)						\
>  	MEM_KEEP(exit.data)						\
>  	*(.data.unlikely)						\
> @@ -374,8 +364,6 @@
>  		*(.ref.rodata)						\
>  		DEV_KEEP(init.rodata)					\
>  		DEV_KEEP(exit.rodata)					\
> -		CPU_KEEP(init.rodata)					\
> -		CPU_KEEP(exit.rodata)					\
>  		MEM_KEEP(init.rodata)					\
>  		MEM_KEEP(exit.rodata)					\
>  	}								\
> @@ -418,8 +406,6 @@
>  		*(.ref.text)						\
>  	DEV_KEEP(init.text)						\
>  	DEV_KEEP(exit.text)						\
> -	CPU_KEEP(init.text)						\
> -	CPU_KEEP(exit.text)						\
>  	MEM_KEEP(init.text)						\
>  	MEM_KEEP(exit.text)						\
>  		*(.text.unlikely)
> @@ -504,7 +490,6 @@
>  #define INIT_DATA							\
>  	*(.init.data)							\
>  	DEV_DISCARD(init.data)						\
> -	CPU_DISCARD(init.data)						\
>  	MEM_DISCARD(init.data)						\
>  	KERNEL_CTORS()							\
>  	MCOUNT_REC()							\
> @@ -512,7 +497,6 @@
>  	FTRACE_EVENTS()							\
>  	TRACE_SYSCALLS()						\
>  	DEV_DISCARD(init.rodata)					\
> -	CPU_DISCARD(init.rodata)					\
>  	MEM_DISCARD(init.rodata)					\
>  	CLK_OF_TABLES()							\
>  	CLKSRC_OF_TABLES()						\
> @@ -522,22 +506,18 @@
>  #define INIT_TEXT							\
>  	*(.init.text)							\
>  	DEV_DISCARD(init.text)						\
> -	CPU_DISCARD(init.text)						\
>  	MEM_DISCARD(init.text)
>  
>  #define EXIT_DATA							\
>  	*(.exit.data)							\
>  	DEV_DISCARD(exit.data)						\
>  	DEV_DISCARD(exit.rodata)					\
> -	CPU_DISCARD(exit.data)						\
> -	CPU_DISCARD(exit.rodata)					\
>  	MEM_DISCARD(exit.data)						\
>  	MEM_DISCARD(exit.rodata)
>  
>  #define EXIT_TEXT							\
>  	*(.exit.text)							\
>  	DEV_DISCARD(exit.text)						\
> -	CPU_DISCARD(exit.text)						\
>  	MEM_DISCARD(exit.text)
>  
>  #define EXIT_CALL							\
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 8618147..a4eefc1 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -94,12 +94,12 @@
>  #define __exit          __section(.exit.text) __exitused __cold notrace
>  
>  /* Used for HOTPLUG_CPU */
> -#define __cpuinit        __section(.cpuinit.text) __cold notrace
> -#define __cpuinitdata    __section(.cpuinit.data)
> -#define __cpuinitconst   __constsection(.cpuinit.rodata)
> -#define __cpuexit        __section(.cpuexit.text) __exitused __cold notrace
> -#define __cpuexitdata    __section(.cpuexit.data)
> -#define __cpuexitconst   __constsection(.cpuexit.rodata)
> +#define __cpuinit
> +#define __cpuinitdata
> +#define __cpuinitconst
> +#define __cpuexit
> +#define __cpuexitdata
> +#define __cpuexitconst
>  
>  /* Used for MEMORY_HOTPLUG */
>  #define __meminit        __section(.meminit.text) __cold notrace
> @@ -118,9 +118,9 @@
>  #define __INITRODATA	.section	".init.rodata","a",%progbits
>  #define __FINITDATA	.previous
>  
> -#define __CPUINIT        .section	".cpuinit.text", "ax"
> -#define __CPUINITDATA    .section	".cpuinit.data", "aw"
> -#define __CPUINITRODATA  .section	".cpuinit.rodata", "a"
> +#define __CPUINIT
> +#define __CPUINITDATA
> +#define __CPUINITRODATA
>  
>  #define __MEMINIT        .section	".meminit.text", "ax"
>  #define __MEMINITDATA    .section	".meminit.data", "aw"
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index a4be8e1..3acbf080 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -861,24 +861,23 @@ static void check_section(const char *modname, struct elf_info *elf,
>  
>  
>  #define ALL_INIT_DATA_SECTIONS \
> -	".init.setup$", ".init.rodata$", \
> -	".cpuinit.rodata$", ".meminit.rodata$", \
> -	".init.data$", ".cpuinit.data$", ".meminit.data$"
> +	".init.setup$", ".init.rodata$", ".meminit.rodata$", \
> +	".init.data$", ".meminit.data$"
>  #define ALL_EXIT_DATA_SECTIONS \
> -	".exit.data$", ".cpuexit.data$", ".memexit.data$"
> +	".exit.data$", ".memexit.data$"
>  
>  #define ALL_INIT_TEXT_SECTIONS \
> -	".init.text$", ".cpuinit.text$", ".meminit.text$"
> +	".init.text$", ".meminit.text$"
>  #define ALL_EXIT_TEXT_SECTIONS \
> -	".exit.text$", ".cpuexit.text$", ".memexit.text$"
> +	".exit.text$", ".memexit.text$"
>  
>  #define ALL_PCI_INIT_SECTIONS	\
>  	".pci_fixup_early$", ".pci_fixup_header$", ".pci_fixup_final$", \
>  	".pci_fixup_enable$", ".pci_fixup_resume$", \
>  	".pci_fixup_resume_early$", ".pci_fixup_suspend$"
>  
> -#define ALL_XXXINIT_SECTIONS CPU_INIT_SECTIONS, MEM_INIT_SECTIONS
> -#define ALL_XXXEXIT_SECTIONS CPU_EXIT_SECTIONS, MEM_EXIT_SECTIONS
> +#define ALL_XXXINIT_SECTIONS MEM_INIT_SECTIONS
> +#define ALL_XXXEXIT_SECTIONS MEM_EXIT_SECTIONS
>  
>  #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
>  #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
> @@ -887,11 +886,9 @@ static void check_section(const char *modname, struct elf_info *elf,
>  #define TEXT_SECTIONS ".text$"
>  
>  #define INIT_SECTIONS      ".init.*"
> -#define CPU_INIT_SECTIONS  ".cpuinit.*"
>  #define MEM_INIT_SECTIONS  ".meminit.*"
>  
>  #define EXIT_SECTIONS      ".exit.*"
> -#define CPU_EXIT_SECTIONS  ".cpuexit.*"
>  #define MEM_EXIT_SECTIONS  ".memexit.*"
>  
>  /* init data sections */
> @@ -979,48 +976,20 @@ const struct sectioncheck sectioncheck[] = {
>  	.mismatch = DATA_TO_ANY_EXIT,
>  	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
>  },
> -/* Do not reference init code/data from cpuinit/meminit code/data */
> +/* Do not reference init code/data from meminit code/data */
>  {
>  	.fromsec = { ALL_XXXINIT_SECTIONS, NULL },
>  	.tosec   = { INIT_SECTIONS, NULL },
>  	.mismatch = XXXINIT_TO_SOME_INIT,
>  	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
>  },
> -/* Do not reference cpuinit code/data from meminit code/data */
> -{
> -	.fromsec = { MEM_INIT_SECTIONS, NULL },
> -	.tosec   = { CPU_INIT_SECTIONS, NULL },
> -	.mismatch = XXXINIT_TO_SOME_INIT,
> -	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
> -},
> -/* Do not reference meminit code/data from cpuinit code/data */
> -{
> -	.fromsec = { CPU_INIT_SECTIONS, NULL },
> -	.tosec   = { MEM_INIT_SECTIONS, NULL },
> -	.mismatch = XXXINIT_TO_SOME_INIT,
> -	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
> -},
> -/* Do not reference exit code/data from cpuexit/memexit code/data */
> +/* Do not reference exit code/data from memexit code/data */
>  {
>  	.fromsec = { ALL_XXXEXIT_SECTIONS, NULL },
>  	.tosec   = { EXIT_SECTIONS, NULL },
>  	.mismatch = XXXEXIT_TO_SOME_EXIT,
>  	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
>  },
> -/* Do not reference cpuexit code/data from memexit code/data */
> -{
> -	.fromsec = { MEM_EXIT_SECTIONS, NULL },
> -	.tosec   = { CPU_EXIT_SECTIONS, NULL },
> -	.mismatch = XXXEXIT_TO_SOME_EXIT,
> -	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
> -},
> -/* Do not reference memexit code/data from cpuexit code/data */
> -{
> -	.fromsec = { CPU_EXIT_SECTIONS, NULL },
> -	.tosec   = { MEM_EXIT_SECTIONS, NULL },
> -	.mismatch = XXXEXIT_TO_SOME_EXIT,
> -	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
> -},
>  /* Do not use exit code/data from init code */
>  {
>  	.fromsec = { ALL_INIT_SECTIONS, NULL },
> @@ -1089,8 +1058,6 @@ static const struct sectioncheck *section_mismatch(
>   * Pattern 2:
>   *   Many drivers utilise a *driver container with references to
>   *   add, remove, probe functions etc.
> - *   These functions may often be marked __cpuinit and we do not want to
> - *   warn here.
>   *   the pattern is identified by:
>   *   tosec   = init or exit section
>   *   fromsec = data section
> @@ -1249,7 +1216,6 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
>  /*
>   * Convert a section name to the function/data attribute
>   * .init.text => __init
> - * .cpuinit.data => __cpudata
>   * .memexitconst => __memconst
>   * etc.
>   *
> 
