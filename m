Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2003 07:55:04 +0100 (BST)
Received: from bay8-f125.bay8.hotmail.com ([IPv6:::ffff:64.4.27.125]:40210
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225211AbTEFGzC>; Tue, 6 May 2003 07:55:02 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 5 May 2003 23:54:53 -0700
Received: from 159.226.39.179 by by8fd.bay8.hotmail.msn.com with HTTP;
	Tue, 06 May 2003 06:54:52 GMT
X-Originating-IP: [159.226.39.179]
X-Originating-Email: [michael_e_guo@hotmail.com]
From: "Guo Michael" <michael_e_guo@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Which compiler should I use to make mips64 kernel
Date: Tue, 06 May 2003 14:54:52 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <BAY8-F125H3IhA1qfT700013d0f@hotmail.com>
X-OriginalArrivalTime: 06 May 2003 06:54:53.0129 (UTC) FILETIME=[65440B90:01C3139C]
Return-Path: <michael_e_guo@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_e_guo@hotmail.com
Precedence: bulk
X-list: linux-mips

Hello, I want to build mips64el kernel and downloaded the mips64el 
toolchain from ftp://ftp.ds2.pg.gda.pl/pub/macro/ (Maciej W. Rozycki's 
site) and I got following errors:
. scripts/mkversion > .tmpversion
mips64el-linux-gcc -D__KERNEL__ -I/home/michael/linux-working/linux/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -I 
/home/michael/linux-working/linux/include/asm/gcc -mabi=64 -G 0 
-mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r4600 -mips3 -Wa,-32 
-Wa,-mgp64  -DUTS_MACHINE='"mips64"' -DKBUILD_BASENAME=version -c -o 
init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/home/michael/linux-working/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -I /home/michael/linux-working/linux/include/asm/gcc 
-mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r4600 -mips3 
-Wa,-32 -Wa,-mgp64 " -C  arch/mips/tools
make[1]: Entering directory 
`/home/michael/linux-working/linux/arch/mips/tools'
cmp -s offset.h 
/home/michael/linux-working/linux/include/asm-mips64/offset.h || (cp 
offset.h /home/michael/linux-working/linux/include/asm-mips64/offset.h.new 
&& mv /home/michael/linux-working/linux/include/asm-mips64/offset.h.new 
/home/michael/linux-working/linux/include/asm-mips64/offset.h)
make[1]: Leaving directory 
`/home/michael/linux-working/linux/arch/mips/tools'
make CFLAGS="-D__KERNEL__ -I/home/michael/linux-working/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -I /home/michael/linux-working/linux/include/asm/gcc 
-mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r4600 -mips3 
-Wa,-32 -Wa,-mgp64 " -C  kernel
make[1]: Entering directory `/home/michael/linux-working/linux/kernel'
make all_targets
make[2]: Entering directory `/home/michael/linux-working/linux/kernel'
rm -f kernel.o
mips64el-linux-ld  -r -o kernel.o sched.o dma.o fork.o exec_domain.o 
panic.o printk.o module.o exit.o itimer.o info.o time.o softirq.o 
resource.o sysctl.o acct.o capability.o ptrace.o timer.o user.o signal.o 
sys.o kmod.o context.o ksyms.o
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
mips64el-linux-ld: Attempt to do relocateable link with 
elf32-tradlittlemips input and elf64-tradlittlemips output
mips64el-linux-ld: final link failed: File in wrong format
make[2]: *** [kernel.o] Error 1
make[2]: Leaving directory `/home/michael/linux-working/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/michael/linux-working/linux/kernel'
make: *** [_dir_kernel] Error 2

Where should I get the right toolchain or how can I build one?


-Michael

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
