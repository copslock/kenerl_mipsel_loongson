Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 17:06:27 +0000 (GMT)
Received: from [IPv6:::ffff:203.145.184.221] ([IPv6:::ffff:203.145.184.221]:29968
	"EHLO naturesoft.net") by linux-mips.org with ESMTP
	id <S8226098AbTAIPcT> convert rfc822-to-8bit; Thu, 9 Jan 2003 15:32:19 +0000
Received: from [192.168.0.15] (helo=krishna.royalchallenge.com)
	by naturesoft.net with esmtp (Exim 3.35 #1)
	id 18Weem-0000qg-00; Thu, 09 Jan 2003 21:01:44 +0530
Content-Type: text/plain;
  charset="iso-8859-1"
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
To: "Indukumar Ilangovan" <iilangov@cisco.com>
Subject: Re: [OT] cross-compiler problem
Date: Thu, 9 Jan 2003 21:01:12 +0530
User-Agent: KMail/1.4.1
References: <040b01c2b7f2$56ff0f40$a78b4d0a@apac.cisco.com>
In-Reply-To: <040b01c2b7f2$56ff0f40$a78b4d0a@apac.cisco.com>
Cc: <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301092101.12871.krishnakumar@naturesoft.net>
Return-Path: <krishnakumar@naturesoft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1112
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krishnakumar@naturesoft.net
Precedence: bulk
X-list: linux-mips

Hi,

Have you changed the /usr/src/linux/include/asm 
link to point to the asm-mips.
IMHO you should do it.

Hope it helps
Regards
KK





On Thursday 09 January 2003 08:48 pm, you wrote:
> Hi All,
>
> I tried to build cross compiler on Red Hat Linux
> Kernel 2.4.2-2 on an i686.
> I use binutils-2.13, gcc-3.2, glibc-2.2.5,
> glibc-2.2.5-mips-build-gmon.diff, glibc-linuxthreads.tar.gz.
> I followed the instructions from
> http://www.ltc.com/~brad/mips/mipsel-linux-cross-toolchain-building.txt
>
> I installed binutils  without any problems.
>
> While compiling glibc2.2.5 I get the following error.
>
> ../sysdeps/unix/syscall.S: Assembler messages:
> ../sysdeps/unix/syscall.S:28: Error: absolute expression required `li'
> make[2]: *** [/home/iilangov/crossGCC/mips/mips-glibc/misc/syscall.o] Error
> 1
> make[2]: Leaving directory `/home/iilangov/crossGCC/mips/glibc-2.2.5/misc'
> make[1]: *** [misc/subdir_lib] Error 2
> make[1]: Leaving directory `/home/iilangov/crossGCC/mips/glibc-2.2.5'
> make: *** [all] Error 2
>
> I have "asm/unistd.h" in the include path, still this problem is happening.
> Do you guys have any clue ?
>
> Thanks in Advance !
> Indu
>
>
> ----- Original Message -----
> From: "Alexandre Oliva" <aoliva@redhat.com>
> To: "Khantharat Anekboon" <dfos1@hotmail.com>
> Cc: <crossgcc@sources.redhat.com>
> Sent: Saturday, December 28, 2002 12:22 PM
> Subject: Re: cross-compiler problem
>
> | On Dec 28, 2002, "Khantharat Anekboon" <dfos1@hotmail.com> wrote:
> | > ../sysdeps/unix/syscall.S:28: Error: absolute expression required 'li'
> |
> | Looks like you're missing the kernel headers where the syscall numbers
> | are defined.  (.../include/asm/unistd.h)
> |
> | --
> | Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
> | Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
> | CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
> | Free Software Evangelist                Professional serial bug killer
> |
> | ------
> | Want more information?  See the CrossGCC FAQ,
>
> http://www.objsw.com/CrossGCC/
>
> | Want to unsubscribe? Send a note to
>
> crossgcc-unsubscribe@sources.redhat.com
>
> ********************************************************
> Indukumar Ilangovan
> HCL-Cisco Offshore development center,
> 49-50, Nelson Manickam Road, Chennai - 600029 ,  India .
> TEL:  +91-44-2374 1939 x 2215 FAX: +91-44-3741038
> Email :iilangov@cisco.com
