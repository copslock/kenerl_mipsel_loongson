Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2018 14:22:44 +0200 (CEST)
Received: from vrout10-bl2.yaziba.net ([185.56.204.56]:60201 "EHLO
        vrout10.yaziba.net" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S23993016AbeH3MWj2Is6S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Aug 2018 14:22:39 +0200
Received: from mtaout10.int.yaziba.net (mtaout10.int.yaziba.net [10.4.20.36])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by vrout10.yaziba.net (mx10.yaziba.net) with ESMTPS id C7A14521D3;
        Thu, 30 Aug 2018 14:22:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaout10.int.yaziba.net (Postfix) with ESMTP id D04EC160484;
        Thu, 30 Aug 2018 14:22:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from mtaout10.int.yaziba.net ([127.0.0.1])
        by localhost (mtaout10.int.yaziba.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rEcCAuJv5tKt; Thu, 30 Aug 2018 14:22:38 +0200 (CEST)
Received: from mail34.int.yaziba.net (mail34.int.yaziba.net [10.4.20.82])
        by mtaout10.int.yaziba.net (Postfix) with ESMTP id AF630160467;
        Thu, 30 Aug 2018 14:22:38 +0200 (CEST)
Date:   Thu, 30 Aug 2018 14:22:38 +0200 (CEST)
From:   Philippe REYNES <philippe.reynes@softathome.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <236153873.582890.1535631758594.JavaMail.zimbra@softathome.com>
In-Reply-To: <20180829180130.21463-1-paul.burton@mips.com>
References: <20180829175747.bo4l36aptncduyuc@pburton-laptop> <20180829180130.21463-1-paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Use a custom elf-entry program to find kernel
 entry point
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.6.0_GA_1194 (ZimbraWebClient - FF61 (Linux)/8.6.0_GA_1194)
Thread-Topic: MIPS: Use a custom elf-entry program to find kernel entry point
Thread-Index: p6vHQgl7YpnNMfd8Ydcx+hlugwwPdQ==
X-DRWEB-SCAN: ok
X-VRSPAM-SCORE: -100
X-VRSPAM-STATE: legit
X-VRSPAM-CAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrgeekgdehtdcutefuodetggdotefrucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffkjghfufggtgfgofhtsehtqhgttdertdejnecuhfhrohhmpefrhhhilhhiphhpvgcutffgjgfpgffuuceophhhihhlihhpphgvrdhrvgihnhgvshesshhofhhtrghthhhomhgvrdgtohhmqeenucfrrghrrghmpehmohguvgepshhmthhpohhuth
X-VRSPAM-EXTCAUSE: mhhouggvpehsmhhtphhouhht
Return-Path: <philippe.reynes@softathome.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe.reynes@softathome.com
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

Hi Paul,

----- Le 29 Aoû 18, à 20:01, Paul Burton paul.burton@mips.com a écrit :

> For a long time arch/mips/Makefile used nm to discover the kernel entry
> point by looking for the address of the kernel_entry symbol. This
> doesn't work for systems which make use of bit 0 of the PC to reflect
> the ISA mode - ie. microMIPS (and MIPS16, but we don't support building
> kernels that target MIPS16 anyway).
> 
> So for a while with commit 5fc9484f5e41 ("MIPS: Set ISA bit in entry-y
> for microMIPS kernels") we manually modified the last nibble of the
> output from nm, which worked but wasn't particularly pretty.
> 
> Commit 27c524d17430 ("MIPS: Use the entry point from the ELF file
> header") then cleaned this up by using objdump to print the ELF entry
> point which includes the ISA bit, rather than using nm to print the
> address of the kernel_entry symbol which doesn't. That removed the ugly
> replacement of the last nibble, but added its own ugliness by needing to
> manually sign extend in the 32 bit case.
> 
> Unfortunately it has been pointed out that objdump's output is
> localised, and therefore grepping for its "start address" output doesn't
> work when the user's language settings are such that objdump doesn't
> print in English.
> 
> We could simply revert commit 27c524d17430 ("MIPS: Use the entry point
> from the ELF file header") and return to the manual replacement of the
> last nibble of entry-y, but it seems that was found sufficiently
> unpalatable to avoid. We could attempt to force the language used by
> objdump by setting an environment variable such as LC_ALL, but that
> seems fragile. Instead we add a small tool named elf-entry which simply
> prints out the entry point of the kernel in the format we require.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Philippe Reynes <philippe.reynes@softathome.com>
> Fixes: 27c524d17430 ("MIPS: Use the entry point from the ELF file header")
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

I've tested on my "french" machine, and it works fine.

Tested-by: Philippe Reynes <philippe.reynes@softathome.com>

> ---
> arch/mips/Makefile | 9 +---
> arch/mips/tools/.gitignore | 1 +
> arch/mips/tools/Makefile | 5 ++
> arch/mips/tools/elf-entry.c | 96 +++++++++++++++++++++++++++++++++++++
> 4 files changed, 104 insertions(+), 7 deletions(-)
> create mode 100644 arch/mips/tools/.gitignore
> create mode 100644 arch/mips/tools/Makefile
> create mode 100644 arch/mips/tools/elf-entry.c
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index d74b3742fa5d..053e1c314f9e 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -13,6 +13,7 @@
> #
> 
> archscripts: scripts_basic
> + $(Q)$(MAKE) $(build)=arch/mips/tools elf-entry
> $(Q)$(MAKE) $(build)=arch/mips/boot/tools relocs
> 
> KBUILD_DEFCONFIG := 32r2el_defconfig
> @@ -257,13 +258,7 @@ ifdef CONFIG_PHYSICAL_START
> load-y = $(CONFIG_PHYSICAL_START)
> endif
> 
> -# Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
> -entry-y = $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
> - | sed -n '/^start address / { \
> - s/^.* //; \
> - s/0x\([0-7].......\)$$/0x00000000\1/; \
> - s/0x\(........\)$$/0xffffffff\1/; p }')
> -
> +entry-y = $(shell $(objtree)/arch/mips/tools/elf-entry vmlinux)
> cflags-y += -I$(srctree)/arch/mips/include/asm/mach-generic
> drivers-$(CONFIG_PCI) += arch/mips/pci/
> 
> diff --git a/arch/mips/tools/.gitignore b/arch/mips/tools/.gitignore
> new file mode 100644
> index 000000000000..56d34ccccce4
> --- /dev/null
> +++ b/arch/mips/tools/.gitignore
> @@ -0,0 +1 @@
> +elf-entry
> diff --git a/arch/mips/tools/Makefile b/arch/mips/tools/Makefile
> new file mode 100644
> index 000000000000..3baee4bc6775
> --- /dev/null
> +++ b/arch/mips/tools/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +hostprogs-y := elf-entry
> +PHONY += elf-entry
> +elf-entry: $(obj)/elf-entry
> + @:
> diff --git a/arch/mips/tools/elf-entry.c b/arch/mips/tools/elf-entry.c
> new file mode 100644
> index 000000000000..adde79ce7fc0
> --- /dev/null
> +++ b/arch/mips/tools/elf-entry.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <byteswap.h>
> +#include <elf.h>
> +#include <endian.h>
> +#include <inttypes.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#ifdef be32toh
> +/* If libc provides [bl]e{32,64}toh() then we'll use them */
> +#elif BYTE_ORDER == LITTLE_ENDIAN
> +# define be32toh(x) bswap_32(x)
> +# define le32toh(x) (x)
> +# define be64toh(x) bswap_64(x)
> +# define le64toh(x) (x)
> +#elif BYTE_ORDER == BIG_ENDIAN
> +# define be32toh(x) (x)
> +# define le32toh(x) bswap_32(x)
> +# define be64toh(x) (x)
> +# define le64toh(x) bswap_64(x)
> +#endif
> +
> +__attribute__((noreturn))
> +static void die(const char *msg)
> +{
> + fputs(msg, stderr);
> + exit(EXIT_FAILURE);
> +}
> +
> +int main(int argc, const char *argv[])
> +{
> + uint64_t entry;
> + size_t nread;
> + FILE *file;
> + union {
> + Elf32_Ehdr ehdr32;
> + Elf64_Ehdr ehdr64;
> + } hdr;
> +
> + if (argc != 2)
> + die("Usage: elf-entry <elf-file>\n");
> +
> + file = fopen(argv[1], "r");
> + if (!file) {
> + perror("Unable to open input file");
> + return EXIT_FAILURE;
> + }
> +
> + nread = fread(&hdr, 1, sizeof(hdr), file);
> + if (nread != sizeof(hdr)) {
> + perror("Unable to read input file");
> + return EXIT_FAILURE;
> + }
> +
> + if (memcmp(hdr.ehdr32.e_ident, ELFMAG, SELFMAG))
> + die("Input is not an ELF\n");
> +
> + switch (hdr.ehdr32.e_ident[EI_CLASS]) {
> + case ELFCLASS32:
> + switch (hdr.ehdr32.e_ident[EI_DATA]) {
> + case ELFDATA2LSB:
> + entry = le32toh(hdr.ehdr32.e_entry);
> + break;
> + case ELFDATA2MSB:
> + entry = be32toh(hdr.ehdr32.e_entry);
> + break;
> + default:
> + die("Invalid ELF encoding\n");
> + }
> +
> + /* Sign extend to form a canonical address */
> + entry = (int64_t)(int32_t)entry;
> + break;
> +
> + case ELFCLASS64:
> + switch (hdr.ehdr32.e_ident[EI_DATA]) {
> + case ELFDATA2LSB:
> + entry = le64toh(hdr.ehdr64.e_entry);
> + break;
> + case ELFDATA2MSB:
> + entry = be64toh(hdr.ehdr64.e_entry);
> + break;
> + default:
> + die("Invalid ELF encoding\n");
> + }
> + break;
> +
> + default:
> + die("Invalid ELF class\n");
> + }
> +
> + printf("0x%016" PRIx64 "\n", entry);
> + return EXIT_SUCCESS;
> +}
> --
> 2.18.0
