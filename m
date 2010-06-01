Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 17:28:08 +0200 (CEST)
Received: from pqueueb.post.tele.dk ([193.162.153.10]:36708 "EHLO
        pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491130Ab0FAP2D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 17:28:03 +0200
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
        by pqueueb.post.tele.dk (Postfix) with ESMTP id D6B5E830D;
        Tue,  1 Jun 2010 17:28:02 +0200 (CEST)
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id 33DB6F84048;
        Tue,  1 Jun 2010 17:27:50 +0200 (CEST)
Date:   Tue, 1 Jun 2010 17:27:50 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH v3] MIPS: Clean up the calculation of
        VMLINUZ_LOAD_ADDRESS
Message-ID: <20100601152750.GA5131@merkur.ravnborg.org>
References: <616317d6d889537d03c3c0860231da9a2cce0b69.1275372093.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616317d6d889537d03c3c0860231da9a2cce0b69.1275372093.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 26968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 463

On Tue, Jun 01, 2010 at 10:06:41PM +0800, Wu Zhangjin wrote:
> Changes:
> 
> v2 -> v3: (feedback from Alexander Clouter)
>   o Drop the unneeded variable n
>   o Replace the last "unsigned long long" by uint64_t
> 
> v1 -> v2: (feedback from Alexander Clouter)
>   o make it more portable
>     use EXIT_SUCCESS and EXIT_FAILURE as the return value, and use uint64_t
>     instead of "unsigned long long".
>   o add a missing return value
>     return EXIT_FAILURE if sscanf not return 1.
> 
> We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is indecipherable. This
> patch rewrites it in C.

I prefer the C version too as it allow better abstraction
and easier to understand calculations.

> diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
> index 4667a5f..f210b09 100644
> --- a/arch/mips/boot/.gitignore
> +++ b/arch/mips/boot/.gitignore
> @@ -3,3 +3,4 @@ elf2ecoff
>  vmlinux.*
>  zImage
>  zImage.tmp
> +calc_vmlinuz_load_addr

Does this do any good in this file?
I had assumed this covered only the same dir as the .gitignore file
is stored. But I may be wrong.

> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 7204dfc..cd9ee04 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
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

The line seriously fail the 80 char limit.
Something like this:

load_addr = $(shell $(obj)/calc_vmlinuz_load_addr \
                    $(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS)
quiet_cmd_zld = LD      $@
      cmd_zld = $(LD) $(LDFLAGS) -Ttext $(load-addr) -T $< $(vmlinuzobjs-y) -o $@

Note: The load_addr local variable _must_ use "=" asignment

> +vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/calc_vmlinuz_load_addr
> +	$(call cmd,zld)
>  	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@

Does objcopy support equally named input and out files?
If this is the case you could use:
$(call cmd,objcopy) as the last line.

> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	struct stat sb;
> +	uint64_t vmlinux_size, vmlinux_load_addr, vmlinuz_load_addr;
> +
> +	if (argc != 3) {
> +		fprintf(stderr, "Usage: %s <pathname> <vmlinux_load_addr>\n",
> +				argv[0]);
> +		return EXIT_FAILURE;
> +	}
> +
> +	if (stat(argv[1], &sb) == -1) {
> +		perror("stat");
> +		return EXIT_FAILURE;
> +	}
> +
> +	/* Convert hex characters to dec number */
> +	errno = 0;
> +	if (sscanf(argv[2], "%llx", &vmlinux_load_addr) != 1) {
> +		if (errno != 0)
> +			perror("sscanf");
> +		else
> +			fprintf(stderr, "No matching characters\n");
> +
> +		return EXIT_FAILURE;
> +	}
> +
> +	vmlinux_size = (uint64_t)sb.st_size;
> +	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
> +
> +	/* Align with 65536 */
> +	vmlinuz_load_addr += (65536 - vmlinux_size % 65536);

You have plenty of rooms for a comment about why you do this.
Would be good to use this possibility.

	Sam
