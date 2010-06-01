Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 12:56:12 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:49007 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492309Ab0FAK4I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 12:56:08 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id F087383871; Tue,  1 Jun 2010 11:56:06 +0100 (BST)
Date:   Tue, 1 Jun 2010 11:56:06 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
Message-ID: <20100601105606.GD2519@chipmunk>
References: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com> <1275388144-5998-2-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275388144-5998-2-git-send-email-wuzhangjin@gmail.com>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 26959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 265

Hi,

* Wu Zhangjin <wuzhangjin@gmail.com> [2010-06-01 18:29:03+0800]:
>
> We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is awful. This patch
> rewrites it in C.
> 
I really feel that going down the C route is even worse....what's more 
this implementation is broken as it always returns with zero, even when 
sscanf() fails....and 'return -1' is just plain wrong too (look at 
sysexits.h for wisdom[1]).

What is so 'awful' about the shell code version?

The shell lump is shorter in implementation size and I am personally not 
convinced any reasons hinting towards 'clarity' even apply as the shell 
code is well documented plus it is trivial to step through on any POSIX 
shell implementation; which cannot be said for the C code.  I am also 
not too confident 'unsigned long long' is a great idea...maybe 'u64' or 
'uint64_t' if you are relying on C99[1]?

Wise man says, do not use cannonball to kill mosquito :)

Cheers

[1] http://www.gnu.org/software/libc/manual/html_node/Exit-Status.html
[2] http://gcc.gnu.org/onlinedocs/gcc/Long-Long.html

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/boot/.gitignore                          |    1 +
>  arch/mips/boot/compressed/Makefile                 |   22 ++++-----
>  arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   52 ++++++++++++++++++++
>  3 files changed, 63 insertions(+), 12 deletions(-)
>  create mode 100644 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> 
> diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
> index 4667a5f..f210b09 100644
> --- a/arch/mips/boot/.gitignore
> +++ b/arch/mips/boot/.gitignore
> @@ -3,3 +3,4 @@ elf2ecoff
>  vmlinux.*
>  zImage
>  zImage.tmp
> +calc_vmlinuz_load_addr
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 7204dfc..cd9ee04 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -12,14 +12,6 @@
>  # Author: Wu Zhangjin <wuzhangjin@gmail.com>
>  #
>  
> -# compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
> -VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
> -VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo -n $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
> -# VMLINUZ_LOAD_ADDRESS = concat "high32 of VMLINUX_LOAD_ADDRESS" and "(low32 of VMLINUX_LOAD_ADDRESS) + VMLINUX_SIZE"
> -HIGH32 := $(shell A=$(VMLINUX_LOAD_ADDRESS); [ $${\#A} -gt 10 ] && expr substr "$(VMLINUX_LOAD_ADDRESS)" 3 $$(($${\#A} - 10)))
> -LOW32 := $(shell [ -n "$(HIGH32)" ] && A=11 || A=3; expr substr "$(VMLINUX_LOAD_ADDRESS)" $${A} 8)
> -VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" -a -n "$(LOW32)" ] && printf "$(HIGH32)%08x" $$(($(VMLINUX_SIZE) + 0x$(LOW32))))
> -
>  # set the default size of the mallocing area for decompressing
>  BOOT_HEAP_SIZE := 0x400000
>  
> @@ -63,9 +55,15 @@ OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.z \
>  $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.z FORCE
>  	$(call if_changed,objcopy)
>  
> -LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
> -vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/piggy.o
> -	$(call cmd,ld)
> +# Calculate the load address of the compressed kernel
> +hostprogs-y := calc_vmlinuz_load_addr
> +
> +vmlinuzobjs-y += $(obj)/piggy.o
> +
> +quiet_cmd_zld = LD      $@
> +      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(shell $(obj)/calc_vmlinuz_load_addr $(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS)) -T $< $(vmlinuzobjs-y) -o $@
> +vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
> +	$(call cmd,zld)
>  	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@
>  
>  #
> @@ -76,7 +74,7 @@ ifdef CONFIG_MACH_DECSTATION
>  endif
>  
>  # elf2ecoff can only handle 32bit image
> -hostprogs-y := ../elf2ecoff
> +hostprogs-y += ../elf2ecoff
>  
>  ifdef CONFIG_32BIT
>  	VMLINUZ = vmlinuz
> diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> new file mode 100644
> index 0000000..1787dce
> --- /dev/null
> +++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright (C) 2010 "Wu Zhangjin" <wuzhangjin@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	int n;
> +	struct stat sb;
> +	unsigned long long vmlinux_size, vmlinux_load_addr, vmlinuz_load_addr;
> +
> +	if (argc != 3) {
> +		fprintf(stderr, "Usage: %s <pathname> <vmlinux_load_addr>\n",
> +				argv[0]);
> +		return -1;
> +	}
> +
> +	if (stat(argv[1], &sb) == -1) {
> +		perror("stat");
> +		return -1;
> +	}
> +
> +	/* Convert hex characters to dec number */
> +	errno = 0;
> +	n = sscanf(argv[2], "%llx", &vmlinux_load_addr);
> +	if (n != 1) {
> +		if (errno != 0)
> +			perror("sscanf");
> +		else
> +			fprintf(stderr, "No matching characters\n");
> +	}
> +
> +	vmlinux_size = (unsigned long long)sb.st_size;
> +	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
> +
> +	/* Align with 65536 */
> +	vmlinuz_load_addr += (65536 - vmlinux_size % 65536);
> +
> +	printf("0x%llx\n", vmlinuz_load_addr);
> +
> +	return 0;
> +}
> -- 
> 1.6.5
> 

-- 
Alexander Clouter
.sigmonster says: To teach is to learn twice.
                  		-- Joseph Joubert
