Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11EkI204723
	for linux-mips-outgoing; Fri, 1 Feb 2002 06:46:18 -0800
Received: from outboundx.mv.meer.net (outboundx.mv.meer.net [209.157.152.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11EkCd04719
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 06:46:12 -0800
Received: from meer.meer.net (mail.meer.net [209.157.152.14])
	by outboundx.mv.meer.net (8.11.6/8.11.6) with ESMTP id g11Dk7h90984;
	Fri, 1 Feb 2002 05:46:07 -0800 (PST)
	(envelope-from weasel@meer.net)
Received: from localhost.meer.net (ptn-130.mv.meer.net [209.157.137.130])
	by meer.meer.net (8.9.3/8.9.3/meer) with ESMTP id FAA4109180;
	Fri, 1 Feb 2002 05:45:20 -0800 (PST)
To: binutils@sources.redhat.com, linux-mips@oss.sgi.com
Subject: me vs gas mips64 relocation
From: d p chang <weasel@meer.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Reply-To: weasel@cs.stanford.edu
Date: 01 Feb 2002 05:45:19 -0800
Message-ID: <m2vgdh5n9s.fsf@meer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi there, I'm trying to figure out if i've just misconfigured
something here or if there is a real problem in gas. I did some
grovelling through the mailing list archives, but really am still
catching up.

Anyway, here at home i grabbed the current cvs binutils and configured
(i thought successfully since I only checked the assembly before the
final link and hadn't been looking at the reloc bits) it to cross
compile from macos x to mips64-linux. It appeared to be successful but
it wasn't until i had written the rest of my chipset startup logic
that I noticed a problem.

My test case looks like this:

    .text
    .comm   my_test_global, 8, 8

    LEAF(reloc_hi_test)

    ld      t0, my_test_global      ; my problem

    lui     t0, %hi(my_test_global) ; works
    addiu   t0, %lo(my_test_global)

    END(reloc_hi_test)

    .end

i compile this w/ (i only just added all the verbosity flags).

    mips64-linux-gcc  -I /Volumes/Homey/dpc/Devel/linux-2.4.17/include/asm/gcc -D__KERNEL__ -I/Volumes/Homey/dpc/Devel/linux-2.4.17/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mips4 -mmad -Wa,-march=r5231 -mlong64 -mgp64 -mfp64 -ffreestanding -mabi=n32 reloc.S -c -o reloc.o -Wa,-acdhls -v -Wa,-v -Wa,-O0 

and I get this from objdump:

    reloc.o:     file format elf32-tradbigmips

    Disassembly of section .text:

    00000000 <reloc_hi_test>:
       0:   3c0c0000        lui     t0,0x0
       4:   258c0000        addiu   t0,t0,0
                            4: R_MIPS_LO16  my_test_global
       8:   3c0c0000        lui     t0,0x0
                            8: R_MIPS_HI16  my_test_global
       c:   258c0000        addiu   t0,t0,0
                            c: R_MIPS_LO16  my_test_global

Anyway, the missing R_MIPS_HI16 relocation at offset 0 is my
problem. I had expected the two to generate the same code. am i
mistaken, did i screw something up configuring, is this a bug, or
something else?

\p
