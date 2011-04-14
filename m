Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2011 21:41:05 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:41877 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491768Ab1DNTlC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2011 21:41:02 +0200
Received: by iyb39 with SMTP id 39so2081203iyb.36
        for <linux-mips@linux-mips.org>; Thu, 14 Apr 2011 12:40:54 -0700 (PDT)
Received: by 10.42.150.8 with SMTP id y8mr1602952icv.471.1302810054719;
        Thu, 14 Apr 2011 12:40:54 -0700 (PDT)
Received: from localhost.localdomain ([122.172.162.249])
        by mx.google.com with ESMTPS id c1sm1388286ibe.0.2011.04.14.12.40.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 12:40:53 -0700 (PDT)
Message-ID: <4DA74DFE.7030905@mvista.com>
Date:   Fri, 15 Apr 2011 01:11:50 +0530
From:   Philby John <pjohn@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
CC:     David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
References: <1302710833.14458.1.camel@localhost.localdomain>     <4DA5DF7A.1030207@caviumnetworks.com> <1302803815.3322.4.camel@localhost.localdomain>
In-Reply-To: <1302803815.3322.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <pjohn@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips

Another finding to be noted about this approach is that, booting works
fine with just these lines of code

+#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
 	NOTES :text :note
+#else
+	NOTES :text
+#endif

And IMHO we should be just using this, which is what you get if one were
to use the command
$mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux

So with just the above lines of code or with the strip command above
readelf shows this output

Elf file type is EXEC (Executable file)
Entry point 0xffffffff81105d10
There are 2 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000010000 0xffffffff81100000 0xffffffff81100000
                 0x000000000098be00 0x0000000000a00000  RWE    10000
  NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  R      8

 Section to Segment mapping:
  Segment Sections...
   00     .text __ex_table .notes .rodata .pci_fixup __ksymtab
__ksymtab_gpl __ksymtab_strings __init_rodata __param .data .init.text
.init.data .exit.text .data.percpu .bss .bss.superpage_aligned
   01

Where as if one were to remove the PT_NOTE section readelf would show ...

Elf file type is EXEC (Executable file)
Entry point 0xffffffff81105d10
There are 1 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000010000 0xffffffff81100000 0xffffffff81100000
                 0x000000000098be00 0x0000000000a00000  RWE    10000

 Section to Segment mapping:
  Segment Sections...
   00     .text __ex_table .notes .rodata .pci_fixup __ksymtab
__ksymtab_gpl __ksymtab_strings __init_rodata __param .data .init.text
.init.data .exit.text .data.percpu .bss .bss.superpage_aligned


Shouldn't we just follow what strip does?

Regards,
Philby

On 04/14/2011 11:26 PM, philby john wrote:
> From: David Daney <ddaney@caviumnetworks.com>
> Date: Wed, 13 Apr 2011 20:46:32 +0530
> Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
> 
> Some early Octeon bootloaders cannot process PT_NOTE program
> headers as reported in numerous sections of the web, here is
> an example http://www.spinics.net/lists/mips/msg37799.html
> Loading usually fails with such an error ...
> Error allocating memory for elf image!
> 
> The work around usually is to strip the .notes section by using
> such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
> It is expected that the vmlinux image got after compilation be
> bootable. Add a Kconfig option to ignore the PT_NOTE section.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Philby John <pjohn@mvista.com>
> ---
>  arch/mips/cavium-octeon/Kconfig |    8 ++++++++
>  arch/mips/kernel/vmlinux.lds.S  |    6 ++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index caae228..ddecee3 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -90,6 +90,14 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
>  	help
>  	  Lock the kernel's implementation of memcpy() into L2.
>  
> +config DISABLE_ELF_NOTE_HEADER
> +       bool "Disable the creation of the ELF PT_NOTE program header in vmlinux"
> +       depends on CPU_CAVIUM_OCTEON
> +       help
> +         Some early Octeon bootloaders cannot process PT_NOTE program
> +         headers.  Select y to omit these headers so that the kernel
> +         can be loaded with older bootloaders.
> +
>  config ARCH_SPARSEMEM_ENABLE
>  	def_bool y
>  	select SPARSEMEM_STATIC
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index 832afbb..0536910 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -8,7 +8,9 @@ OUTPUT_ARCH(mips)
>  ENTRY(kernel_entry)
>  PHDRS {
>  	text PT_LOAD FLAGS(7);	/* RWX */
> +#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
>  	note PT_NOTE FLAGS(4);	/* R__ */
> +#endif
>  }
>  
>  #ifdef CONFIG_32BIT
> @@ -62,7 +64,11 @@ SECTIONS
>  		__stop___dbe_table = .;
>  	}
>  
> +#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
>  	NOTES :text :note
> +#else
> +	NOTES :text
> +#endif
>  	.dummy : { *(.dummy) } :text
>  
>  	RODATA
