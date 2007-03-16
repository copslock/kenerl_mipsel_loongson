Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 04:18:52 +0000 (GMT)
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:22193 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021494AbXCPESp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 04:18:45 +0000
Received: (qmail 11276 invoked from network); 16 Mar 2007 04:17:37 -0000
Received: from unknown (HELO lucon.org) (hjjean@sbcglobal.net@75.61.83.235 with login)
  by smtp102.sbc.mail.mud.yahoo.com with SMTP; 16 Mar 2007 04:17:37 -0000
X-YMail-OSG: EfMWgNsVM1nj9dioEKMy3l7OG6sIsaZIcWRsijIJHi.VVRYn2fRjCos_r8bA5fYPh1_8ZwXpaTHaCh0Gymb3qBUAbeLKmwz7528XHtJ1NDqXZTT8nxOj3DnrPbxptKxWqrO4qcBHS_AvreF27T3l5Sw3mub_.9kDqxlMfGK05zLdUo459O28
Received: by lucon.org (Postfix, from userid 500)
	id 08E9546EEB1; Thu, 15 Mar 2007 21:17:37 -0700 (PDT)
Date:	Thu, 15 Mar 2007 21:17:36 -0700
From:	"H. J. Lu" <hjl@lucon.org>
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
Cc:	bug-binutils@gnu.org, linux-mips@linux-mips.org
Subject: Re: 'final link failed: Bad value' when building Linux/MIPS kernels.
Message-ID: <20070316041736.GA29752@lucon.org>
References: <45FA027E.2080901@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45FA027E.2080901@realitydiluted.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 15, 2007 at 09:35:42PM -0500, Steven J. Hill wrote:
> Greetings.
> 
> I have been chasing down a binutils regression that is preventing me from
> building a Linux/MIPS kernel using a gcc-4.2 based toolchain. Here is the
> snippet of output when building a 2.6.12 kernel for my platform:
> 
>      LD      drivers/mtd/maps/built-in.o
>      LD      drivers/mtd/nand/built-in.o
>      LD      drivers/mtd/built-in.o
>    mipsel-linux-uclibc-ld: final link failed: Bad value
>    make[1]: *** [drivers/mtd/built-in.o] Error 1
>    make: *** [_module_drivers/mtd] Error 2
> 
> The versions were:
> 
>    binutils-2.17.50.0.12
>    gcc-4.2-20070131
>    linux-headers-2.6.12
> 
> Using the release version of binutils-2.17 works fine and does not
> produce the error above. However, binutils-HEAD out of today's CVS
> and all of H.J. Lu's development releases > 2.17.50.0.3 will produce
> the error. The regression appeared in binutils-2.17.50.0.4 and still
> exists. The simple patch is:
> 
>    --- binutils-2.17.50.0.12/bfd/elfxx-mips.c
>    +++ binutils-2.17.50.0.12-patched/bfd/elfxx-mips.c
>    @@ -3603,12 +3603,9 @@
>                              const Elf_Internal_Rela *relocation,
>                              const Elf_Internal_Rela *relend)
>     {
>    -  unsigned long r_symndx = ELF_R_SYM (abfd, relocation->r_info);
>    -
>       while (relocation < relend)
>         {
>    -      if (ELF_R_TYPE (abfd, relocation->r_info) == r_type
>    -         && ELF_R_SYM (abfd, relocation->r_info) == r_symndx)
>    +      if (ELF_R_TYPE (abfd, relocation->r_info) == r_type)
>            return relocation;
> 
>           ++relocation;
> 
> I applied to binutils-HEAD and was then able to build a valid Linux/MIPS
> kernel and applications. I need to move on to other items, but if someone
> could comment or have a look at this, it would be much appreciated. If a
> better formatted bug report should be submitted somewhere, just let me
> know. Thanks.

I suggest you open a bug report with all input files for
drivers/mtd/built-in.o and drivers/mtd/.built-in.o.cmd. You can find
input filenames in drivers/mtd/.built-in.o.cmd. 


H.J.
