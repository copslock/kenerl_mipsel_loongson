Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jan 2003 18:09:01 +0000 (GMT)
Received: from imo-d06.mx.aol.com ([IPv6:::ffff:205.188.157.38]:20717 "EHLO
	imo-d06.mx.aol.com") by linux-mips.org with ESMTP
	id <S8225262AbTAaRsa>; Fri, 31 Jan 2003 17:48:30 +0000
Received: from Kumba12345@aol.com
	by imo-d06.mx.aol.com (mail_out_v34.13.) id l.11e.1d78c204 (4238)
	 for <linux-mips@linux-mips.org>; Fri, 31 Jan 2003 12:48:16 -0500 (EST)
From: Kumba12345@aol.com
Message-ID: <11e.1d78c204.2b6c10e0@aol.com>
Date: Fri, 31 Jan 2003 12:48:16 EST
Subject: mips64 glitches
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 7.0 for Windows US sub 10634
Return-Path: <Kumba12345@aol.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1286
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kumba12345@aol.com
Precedence: bulk
X-list: linux-mips

These might already be known, but just to be safe, I have two errors I ran 
into building and using a mips64 kernel on an SGI Indigo2 IP-22 system, R4400

First, it appears there's some unfriendliness between the Indy/Indigo2 
Watchdog and the egcs-mips64 compiler:

mips64-linux-gcc -D__KERNEL__ -I/usr/src/t/linux-2.4.20-mips/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -mcpu=r8000 -mips4 -I 
/usr/src/t/linux-2.4.20-mips/include/asm/gcc -mabi=64 -G 0 -mno-abicalls 
-fno-pic -Wa,--trap -pipe -Wa,-32 -Wa,-mgp64   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=indydog  -c -o indydog.o indydog.c
indydog.c: In function `indydog_write':
indydog.c:124: internal error--unrecognizable insn:
(insn 206 61 58 (set (reg:SI 111)
        (reg/v:DI 89)) -1 (insn_list:REG_DEP_ANTI 54 (insn_list 61 (nil)))
    (nil))
../../gcc/toplev.c:1367: Internal compiler error in function fatal_insn
make[3]: *** [indydog.o] Error 1
make[3]: Leaving directory `/usr/src/t/linux-2.4.20-mips/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/t/linux-2.4.20-mips/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/t/linux-2.4.20-mips/drivers'
make: *** [_dir_drivers] Error 2


Second, After removing watchdog support and recompiling, I wound up with a 
compiled kernel.  Attempting to boot it made another error:

Exception: <vector=Normal>
Status register: 0x30044802<CU1,CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL>
Cause register: 0x8028<CE=0,IP8,EXC=II>
Exception PC: 0x881ebeb4, Exception RA: 0x881ec4bc
Reserved Instruction exception, contents of PC = 0x62900b
Local I/O interrupt register 2: 0xc8 <EISA,SLOT0,SLOT1>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: a8740000 88200000 885fff80 88000000
  tmp: a8740000 88239dc8 0 88239e07 881dc000 a87ffc20 a8746f70 9fc5c274
  sve: a8740000 c12dc13a 0 c0f9138a 0 c0edd9c9 0 bf077b8a
  t8 a8740000 t9 c0dcea58 at 0 v0 c0f9138a v1 0 k1 3ff
  gp a8740000 fp abfb7d4f sp 4fd7ff27 ra cf31ffcf

PANIC: Unexpected exception

[Press reset or ENTER to restart.]


I used the linux-mips CVS 2_4 branch, pulled today, and the egcs-mips64 1.1.2 
compiler and it's associated binutils.  As for the kernel, I wonder if this 
has anything to do with the fact the kernel build passed -mcpu=r8000 when I'm 
running an R4400.  I was told mips64 IP22 support should be mostly 
functional, just it's been neglected for some time.

Anyways, if there is anymore information needed, please advise.  This system 
works wonderfully on a 32-bit kernel built off a vanilla + debian patch, but 
I wnated to try out mips64 on it just for kicks.

--Kumba
