Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2003 11:23:08 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8224821AbTHTKXG>; Wed, 20 Aug 2003 11:23:06 +0100
Date: Wed, 20 Aug 2003 11:23:06 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org, Michael Dosser <mic@nethack.at>
Subject: Re: mips64
Message-ID: <20030820112306.A2620@ftp.linux-mips.org>
References: <20030820100339.GO15525@nethack.at> <20030820101509.GA16419@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030820101509.GA16419@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Wed, Aug 20, 2003 at 12:15:09PM +0200
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 20, 2003 at 12:15:09PM +0200, Thiemo Seufer wrote:
> Michael Dosser wrote:
> > Hi,
> > 
> > I'm successfully running Debian/GNU Linux on a SGI Indy R4600PC@100Mhz
> > for over a year now. I'm very happy with the stability of Linux on that
> > machine. But since the machine is relatively slow (currently 30-35 
> > shell user continuosly connected), I bought an Indigo2 R4400SC@250Mhz.
> > 
> > I thought of putting a mips64 kernel on the new machine: Got the rpm's
> > from ftp.linux-mips.org, converted them with alien to debs and installed 
> > them on my quad xeon Debian box - checked out the linux source and 
> > started compiling:
> 
> The 64bit IP22 Kernel was broken for quite some time, I don't know if
> this changed in the meanwhile.

It works now.

> [snip]
> > Error message with gcc version egcs-2.91.66 19990314 (egcs-1.1.2
> > release)
> > 
> > [...]
> > make[2]: Entering directory `/usr/local/src/mips/linux/arch/mips/math-emu'
> > mips64-linux-gcc -D__KERNEL__ -I/usr/local/src/mips/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I /usr/local/src/mips/linux/include/asm/gcc -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r4600 -mips3 -Wa,-32 -Wa,-mgp64   -nostdinc -iwithprefix include -DKBUILD_BASENAME=cp1emu  -c -o cp1emu.o cp1emu.c
> > cp1emu.c: In function `fpu_emulator_cop1Handler':
> > cp1emu.c:1328: internal error--unrecognizable insn:
> > (insn 310 33 25 (set (reg:SI 159)
> >         (reg/v:DI 87)) -1 (insn_list:REG_DEP_ANTI 28 (insn_list 33 (nil)))
> >     (nil))
> > ../../gcc/toplev.c:1367: Internal compiler error in function fatal_insn
> 
> egcs is known to be broken WRT, and horribly outdated anyway.
> 
> [snip]
> > Error with gcc version 2.95.4 20010319 (prerelease):
> > 
> > [...]
> > mips64-linux-ld --oformat elf32-tradbigmips   -r -o kernel.o sched.o
> > dma.o fork.o exec_domain.o panic.o printk.o module.o exit.o itimer.o
> > info.o time.o softirq.o resource.o sysctl.o acct.o capability.o ptrace.o
> > timer.o user.o signal.o sys.o kmod.o context.o ksyms.o
> > mips64-linux-ld: target elf32-tradbigmips not found
> > make[2]: *** [kernel.o] Error 1
> > make[2]: Leaving directory `/usr/local/src/mips/linux/kernel'
> > make[1]: *** [first_rule] Error 2
> > make[1]: Leaving directory `/usr/local/src/mips/linux/kernel'
> > make: *** [_dir_kernel] Error 2
> > #
> > 
> > Ok, the latter seems to be related to objdump, right?
> 
> No, this ld is too old to handle elf32-tradbigmips.
> You'll need a more up to date toolchain.

gcc-2.95.4 and binutils-2.14 works ok for me.

ladis
