Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 08:14:55 +0000 (GMT)
Received: from webmail28.rediffmail.com ([IPv6:::ffff:203.199.83.38]:457 "HELO
	rediffmail.com") by linux-mips.org with SMTP id <S8225195AbTCMIOy>;
	Thu, 13 Mar 2003 08:14:54 +0000
Received: (qmail 13673 invoked by uid 510); 13 Mar 2003 08:14:00 -0000
Date: 13 Mar 2003 08:14:00 -0000
Message-ID: <20030313081400.13672.qmail@webmail28.rediffmail.com>
Received: from unknown (194.175.117.86) by rediffmail.com via HTTP; 13 mar 2003 08:14:00 -0000
MIME-Version: 1.0
From: "Santosh " <ipv6_san@rediffmail.com>
Reply-To: "Santosh " <ipv6_san@rediffmail.com>
To: usagi-users@linux-ipv6.org
Cc: linux-mips@linux-mips.org
Subject: Error compiling Usagi for MIPS
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <ipv6_san@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ipv6_san@rediffmail.com
Precedence: bulk
X-list: linux-mips

I'm trying to compile the Usagi kernel 2.4.20 for MIPS Malta 
board.
(usagi-linux24-sSTABLE200302_20030214.tar from linux-ipv6.org)
My gcc version is 2.95.3

I did
#make ARCH=mips config
#make ARCH=mips dep
#make ARCH=mips clean
#make ARCH=mips CROSS_COMPILE=mipsel-linux- vmlinux

Now i get following error..
mipsel-linux-gcc -D__KERNEL__ 
-I/home/santosh/UsagiKernel/usagi/kernel/linux24/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -I 
/home/santosh/UsagiKernel/usagi/kernel/linux24/include/asm/gcc -G 
0 -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=kbd_no
-c -o kbd-no.o kbd-no.c
rm -f lib.a
mipsel-linux-ar  rcs lib.a csum_partial.o csum_partial_copy.o 
rtc-std.o rtc-no.o memcpy.o memset.o watch.o strlen_user.o 
strncpy_user.o strnlen_user.o dump_tlb.o kbd-std.o kbd-no.o
make[2]: Leaving directory 
`/home/santosh/UsagiKernel/usagi/kernel/linux24/arch/mips/lib'
make[1]: Leaving directory 
`/home/santosh/UsagiKernel/usagi/kernel/linux24/arch/mips/lib'
sed -e 's/@@LOADADDR@@/0x80100000/' <arch/mips/ld.script.in 
 >arch/mips/ld.script
mipsel-linux-ld -G 0 -static  -T arch/mips/ld.script 
arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
         --start-group \
         arch/mips/kernel/kernel.o arch/mips/mm/mm.o 
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o 
arch/mips/math-emu/fpu_emulator.o \
          drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o 
drivers/pci/driver.o drivers/video/video.o \
         net/network.o \
         crypto/crypto.o \
         arch/mips/lib/lib.a 
/home/santosh/UsagiKernel/usagi/kernel/linux24/lib/lib.a 
arch/mips/mips-boards/malta/malta.o 
arch/mips/mips-boards/generic/mipsboards.o \
         --end-group \
         -o vmlinux
kernel/kernel.o: In function `interruptible_sleep_on':
sched.c(__ksymtab+0xde8): undefined reference to `dump_stack'
drivers/pci/driver.o: In function `pci_scan_device':
pci.c(.text+0x5c0): undefined reference to 
`pcibios_enable_device'
make: *** [vmlinux] Error 1
#
#

what is wrong here ??? Is it a bug ???

Regds,
-Santosh
-------------------------------





__________________________________________________________
Great Travel Deals, Airfares, Hotels on
http://r.rediff.com/r?www.journeymart.com/rediff/travel.asp&&sign&&jmart
