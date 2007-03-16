Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 02:38:59 +0000 (GMT)
Received: from real.realitydiluted.com ([66.43.201.61]:50307 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20022554AbXCPCiz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 02:38:55 +0000
Received: from atlas.inter.net ([10.0.0.3])
	by real.realitydiluted.com with esmtp (Exim 4.63)
	(envelope-from <sjhill@realitydiluted.com>)
	id 1HS2J8-00037x-TJ; Thu, 15 Mar 2007 21:36:43 -0500
Message-ID: <45FA027E.2080901@realitydiluted.com>
Date:	Thu, 15 Mar 2007 21:35:42 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070306)
MIME-Version: 1.0
To:	bug-binutils@gnu.org
CC:	linux-mips@linux-mips.org, hjl@lucon.org
Subject: 'final link failed: Bad value' when building Linux/MIPS kernels.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Greetings.

I have been chasing down a binutils regression that is preventing me from
building a Linux/MIPS kernel using a gcc-4.2 based toolchain. Here is the
snippet of output when building a 2.6.12 kernel for my platform:

     LD      drivers/mtd/maps/built-in.o
     LD      drivers/mtd/nand/built-in.o
     LD      drivers/mtd/built-in.o
   mipsel-linux-uclibc-ld: final link failed: Bad value
   make[1]: *** [drivers/mtd/built-in.o] Error 1
   make: *** [_module_drivers/mtd] Error 2

The versions were:

   binutils-2.17.50.0.12
   gcc-4.2-20070131
   linux-headers-2.6.12

Using the release version of binutils-2.17 works fine and does not
produce the error above. However, binutils-HEAD out of today's CVS
and all of H.J. Lu's development releases > 2.17.50.0.3 will produce
the error. The regression appeared in binutils-2.17.50.0.4 and still
exists. The simple patch is:

   --- binutils-2.17.50.0.12/bfd/elfxx-mips.c
   +++ binutils-2.17.50.0.12-patched/bfd/elfxx-mips.c
   @@ -3603,12 +3603,9 @@
                             const Elf_Internal_Rela *relocation,
                             const Elf_Internal_Rela *relend)
    {
   -  unsigned long r_symndx = ELF_R_SYM (abfd, relocation->r_info);
   -
      while (relocation < relend)
        {
   -      if (ELF_R_TYPE (abfd, relocation->r_info) == r_type
   -         && ELF_R_SYM (abfd, relocation->r_info) == r_symndx)
   +      if (ELF_R_TYPE (abfd, relocation->r_info) == r_type)
           return relocation;

          ++relocation;

I applied to binutils-HEAD and was then able to build a valid Linux/MIPS
kernel and applications. I need to move on to other items, but if someone
could comment or have a look at this, it would be much appreciated. If a
better formatted bug report should be submitted somewhere, just let me
know. Thanks.

-Steve
