Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2003 11:04:02 +0100 (BST)
Received: from daemon.nethack.at ([IPv6:::ffff:62.116.47.92]:6882 "EHLO
	daemon.nethack.at") by linux-mips.org with ESMTP
	id <S8224821AbTHTKD5>; Wed, 20 Aug 2003 11:03:57 +0100
Received: (qmail 32732 invoked by uid 1000); 20 Aug 2003 10:03:41 -0000
Date: Wed, 20 Aug 2003 12:03:40 +0200
From: Michael Dosser <mic@nethack.at>
To: linux-mips@linux-mips.org
Subject: mips64
Message-ID: <20030820100339.GO15525@nethack.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: Nethack.at
X-Operating-System: Linux 2.4.19 mips
X-sig-random-gen: http://cfml.sourceforge.net/perl/chsig.tar.gz
X-spam-note: Sending SPAM is a violation of both Austrian and US law and will at least trigger a complaint at your providers postmaster.
Return-Path: <mic@daemon.nethack.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mic@nethack.at
Precedence: bulk
X-list: linux-mips

Hi,

I'm successfully running Debian/GNU Linux on a SGI Indy R4600PC@100Mhz
for over a year now. I'm very happy with the stability of Linux on that
machine. But since the machine is relatively slow (currently 30-35 
shell user continuosly connected), I bought an Indigo2 R4400SC@250Mhz.

I thought of putting a mips64 kernel on the new machine: Got the rpm's
from ftp.linux-mips.org, converted them with alien to debs and installed 
them on my quad xeon Debian box - checked out the linux source and 
started compiling:

# cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co -r linux_2_4 linux
# cd linux
# make ARCH=mips64 dep
# make ARCH=mips64 clean
# make ARCH=mips64 all

Error message with gcc version egcs-2.91.66 19990314 (egcs-1.1.2
release)

[...]
make[2]: Entering directory `/usr/local/src/mips/linux/arch/mips/math-emu'
mips64-linux-gcc -D__KERNEL__ -I/usr/local/src/mips/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I /usr/local/src/mips/linux/include/asm/gcc -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r4600 -mips3 -Wa,-32 -Wa,-mgp64   -nostdinc -iwithprefix include -DKBUILD_BASENAME=cp1emu  -c -o cp1emu.o cp1emu.c
cp1emu.c: In function `fpu_emulator_cop1Handler':
cp1emu.c:1328: internal error--unrecognizable insn:
(insn 310 33 25 (set (reg:SI 159)
        (reg/v:DI 87)) -1 (insn_list:REG_DEP_ANTI 28 (insn_list 33 (nil)))
    (nil))
../../gcc/toplev.c:1367: Internal compiler error in function fatal_insn
make[2]: *** [cp1emu.o] Error 1
make[2]: Leaving directory `/usr/local/src/mips/linux/arch/mips/math-emu'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/local/src/mips/linux/arch/mips/math-emu'
make: *** [_dir_arch/mips/math-emu] Error 2
# 

Error with gcc version 2.95.4 20010319 (prerelease):

[...]
mips64-linux-ld --oformat elf32-tradbigmips   -r -o kernel.o sched.o
dma.o fork.o exec_domain.o panic.o printk.o module.o exit.o itimer.o
info.o time.o softirq.o resource.o sysctl.o acct.o capability.o ptrace.o
timer.o user.o signal.o sys.o kmod.o context.o ksyms.o
mips64-linux-ld: target elf32-tradbigmips not found
make[2]: *** [kernel.o] Error 1
make[2]: Leaving directory `/usr/local/src/mips/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/local/src/mips/linux/kernel'
make: *** [_dir_kernel] Error 2
#

Ok, the latter seems to be related to objdump, right?
mips64-linux-objdump: supported targets: elf32-bigmips elf32-littlemips
elf64-bigmips elf64-littlemips ecoff-bigmips ecoff-littlemips
elf64-little elf64-big elf32-little elf32-big srec symbolsrec tekhex
binary ihex

The package on linux-mips.org seems not to be including
elf32-tradbigmips ...

Can somebody help me with this? Btw: same errors with co -r linux_2_4_21
...

Thank you,mic

-- 
> Please specifically define where data goes that is sent to /dev/null
[...]
Answer 2.  All the data goes into another dimension, and comes out of
/dev/random.            Stephen Montgomery-Smith on freebsd-hackers
