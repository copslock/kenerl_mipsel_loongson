Received:  by oss.sgi.com id <S42222AbQJFNWh>;
	Fri, 6 Oct 2000 06:22:37 -0700
Received: from [206.207.108.63] ([206.207.108.63]:18528 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S42215AbQJFNWZ>; Fri, 6 Oct 2000 06:22:25 -0700
Received: (qmail 29840 invoked from network); 6 Oct 2000 07:22:15 -0600
Received: from gmcnutt-lx.ridgerun.cxm (HELO ridgerun.com) (gmcnutt@192.168.1.17)
  by ridgerun-lx.ridgerun.cxm with SMTP; 6 Oct 2000 07:22:15 -0600
Message-ID: <39DDD206.19443FAB@ridgerun.com>
Date:   Fri, 06 Oct 2000 07:22:14 -0600
From:   Gordon McNutt <gmcnutt@ridgerun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: insmod hates RELA?
References: <Pine.GSO.3.96.1001006121819.26752C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Maciej W. Rozycki" wrote:

> On Fri, 6 Oct 2000, Ralf Baechle wrote:
>
> > A possible explanation would be that you use the wrong binutils, have a
> > corrupt module file or try to load a module for another architecture or
> > modutils being plain broken?
>
>  The linker tends to create empty .rela sections even if there is no input
> for them.  This actually is a minor error and until (unless) we modify the
> linker just use the quick fix for modutils that is available from my FTP
> site (not that these modutils actually work ;-) ).
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

On the advice of a colleague I switched to an older version of gcc (2.90.29)
which got rid of the RELA problem (I was using 2.96). I've now gotten further
toward my goal of inserting a module.

But I'm not there yet. insmod (2.3.9) now complains about a relocation
overflow on all of the kernel symbols. I'm looking at the source for insmod
now. At the moment I'm trying to figure out why insmod wants to relocate
kernel symbols. After patching in the values from ksym, it tries to relocate
kernel symbols along with all the local symbols. Seems like a mismatch
between what insmod expects the ELF to look like and what gcc wants to
generate. Maybe I'm missing a gcc option or something? Here's the options I'm
using to build the module:

/usr/bin/mips-linux-gcc -D__KERNEL__ -DMODULE -I../include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strength-reduce
-DMODVERSIONS  -G 0 -mno-abicalls -mcpu=r5000  -pipe -fno-pic -mips2

I've looked a little more since writing the above. The relocation errors are
occurring in the .bss section, where it appears insmod is iterating over all
references to a symbol and doing a relocation. The type of relocation done
for all symbols is associated with the 'R_MIPS_26' #define (see linux/elf.h).
Does anyone know much about this? Does this mean that symbols will be
relocated to a 26-bit offset from some known base? If so, then how is it
supposed to deal with kernel symbols? The problem appears when insmod
verifies that the symbol's address is within a certain range of the section
header. Not unexpectedly, the ksyms don't satisfy this check. They're way out
of there.

Is this a bug in insmod?

Anyway, thanks for the help
--Gordon
