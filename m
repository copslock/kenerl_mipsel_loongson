Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Feb 2003 14:08:22 +0000 (GMT)
Received: from p508B6159.dip.t-dialin.net ([IPv6:::ffff:80.139.97.89]:25219
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225262AbTBANuJ>; Sat, 1 Feb 2003 13:50:09 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h11Do6m25446;
	Sat, 1 Feb 2003 14:50:06 +0100
Date: Sat, 1 Feb 2003 14:50:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumba12345@aol.com
Cc: linux-mips@linux-mips.org
Subject: Re: mips64 glitches
Message-ID: <20030201145006.A31445@linux-mips.org>
References: <11e.1d78c204.2b6c10e0@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11e.1d78c204.2b6c10e0@aol.com>; from Kumba12345@aol.com on Fri, Jan 31, 2003 at 12:48:16PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1288
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 31, 2003 at 12:48:16PM -0500, Kumba12345@aol.com wrote:

>     (nil))
> ../../gcc/toplev.c:1367: Internal compiler error in function fatal_insn
> make[3]: *** [indydog.o] Error 1
> make[3]: Leaving directory `/usr/src/t/linux-2.4.20-mips/drivers/char'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/t/linux-2.4.20-mips/drivers/char'
> make[1]: *** [_subdir_char] Error 2
> make[1]: Leaving directory `/usr/src/t/linux-2.4.20-mips/drivers'
> make: *** [_dir_drivers] Error 2

Know problem; the 64-bit egcs occasionally explodes when compiling some of
the funky macros from <asm/uaccess.h>.

> Second, After removing watchdog support and recompiling, I wound up with a 
> compiled kernel.  Attempting to boot it made another error:
> 
> Exception: <vector=Normal>
> Status register: 0x30044802<CU1,CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL>
> Cause register: 0x8028<CE=0,IP8,EXC=II>
> Exception PC: 0x881ebeb4, Exception RA: 0x881ec4bc
> Reserved Instruction exception, contents of PC = 0x62900b
> Local I/O interrupt register 2: 0xc8 <EISA,SLOT0,SLOT1>
>   Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>   arg: a8740000 88200000 885fff80 88000000
>   tmp: a8740000 88239dc8 0 88239e07 881dc000 a87ffc20 a8746f70 9fc5c274
>   sve: a8740000 c12dc13a 0 c0f9138a 0 c0edd9c9 0 bf077b8a
>   t8 a8740000 t9 c0dcea58 at 0 v0 c0f9138a v1 0 k1 3ff
>   gp a8740000 fp abfb7d4f sp 4fd7ff27 ra cf31ffcf
> 
> PANIC: Unexpected exception

Another known problem.

> I used the linux-mips CVS 2_4 branch, pulled today, and the egcs-mips64 1.1.2 
> compiler and it's associated binutils.  As for the kernel, I wonder if this 
> has anything to do with the fact the kernel build passed -mcpu=r8000 when I'm 
> running an R4400.  I was told mips64 IP22 support should be mostly 
> functional, just it's been neglected for some time.
> 
> Anyways, if there is anymore information needed, please advise.  This system 
> works wonderfully on a 32-bit kernel built off a vanilla + debian patch, but 
> I wnated to try out mips64 on it just for kicks.

There is no advantage of running a 64-bit kernel on an Indy right now.
There are no 64-bit MIPS utilities and libraries shipping so all you could
do is running 32-bit software.

The only reason why I made the 64-bit Indy kernel at all was using it as
a stepping stone when porting Linux to the SGI Origin.

  Ralf
