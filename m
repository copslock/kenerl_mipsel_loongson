Received:  by oss.sgi.com id <S553721AbRCLV5V>;
	Mon, 12 Mar 2001 13:57:21 -0800
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:43219
        "HELO nilpferd.fachschaften.tu-muenchen.de") by oss.sgi.com with SMTP
	id <S553692AbRCLV47>; Mon, 12 Mar 2001 13:56:59 -0800
Received: (qmail 11805 invoked from network); 12 Mar 2001 21:56:57 -0000
Received: from mimas.fachschaften.tu-muenchen.de (HELO mimas) (129.187.176.26)
  by nilpferd.fachschaften.tu-muenchen.de with SMTP; 12 Mar 2001 21:56:57 -0000
Date:   Mon, 12 Mar 2001 22:56:40 +0100 (CET)
From:   Adrian Bunk <bunk@fs.tum.de>
X-X-Sender:  <bunk@mimas.fachschaften.tu-muenchen.de>
To:     <linux-mips@oss.sgi.com>
Subject: Compile error with current CVS kernel
Message-ID: <Pine.NEB.4.33.0103122252170.23935-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

I checked out the kernel source from oss.sgi.com at about two hours ago,
but the build for my DECstation 5000/240 failed with:


mipsel-linux-gcc -I /home/bunk/Ringo/linux/include/asm/gcc -D__KERNEL__ -I/home/bunk/Ringo/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe  -c strnlen_user.S -o strnlen_user.o
mipsel-linux-gcc -I /home/bunk/Ringo/linux/include/asm/gcc -D__KERNEL__ -I/home/bunk/Ringo/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe    -c -o r3k_dump_tlb.o r3k_dump_tlb.c
rm -f lib.a
mipsel-linux-ar  rcs lib.a csum_partial.o csum_partial_copy.o rtc-std.o rtc-no.o memcpy.o memset.o watch.o strlen_user.o strncpy_user.o strnlen_user.o r3k_dump_tlb.o
make[2]: Leaving directory `/home/bunk/Ringo/linux/arch/mips/lib'
make[1]: Leaving directory `/home/bunk/Ringo/linux/arch/mips/lib'
sed -e 's/@@OUTPUT_FORMAT@@/elf32-littlemips/' \
    -e 's/@@LOADADDR@@/0x80040000/' <arch/mips/ld.script.in >arch/mips/ld.script
mipsel-linux-ld -static -G 0 -T arch/mips/ld.script arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o arch/mips/dec/dec.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/scsi/scsidrv.o drivers/video/video.o drivers/tc/tc.a \
        net/network.o \
        arch/mips/lib/lib.a /home/bunk/Ringo/linux/lib/lib.a arch/mips/dec/prom/rexlib.a \
        --end-group \
        -o vmlinux
mipsel-linux-nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/home/bunk/Ringo/linux/arch/mips/boot'
gcc -o elf2ecoff elf2ecoff.c
./elf2ecoff /home/bunk/Ringo/linux/vmlinux vmlinux.ecoff -a
wrote 20 byte file header.
wrote 56 byte a.out header.
wrote 240 bytes of section headers.
wrote 4 byte pad.
writing 1848 bytes...
Intersegment gap (-2147239736 bytes) too large.
make[1]: *** [vmlinux.ecoff] Error 1
make[1]: Leaving directory `/home/bunk/Ringo/linux/arch/mips/boot'
make: *** [boot] Error 2


I'm using for cross-compiling from i386:

$ mipsel-linux-ld -v
GNU ld version 2.10.91 (with BFD 2.10.91.0.2)
$ mipsel-linux-gcc -v
Reading specs from /usr/lib/gcc-lib/mipsel-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)
$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.3/specs
gcc version 2.95.3 20010219 (prerelease)
$


cu
Adrian

-- 

Nicht weil die Dinge schwierig sind wagen wir sie nicht,
sondern weil wir sie nicht wagen sind sie schwierig.
