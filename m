Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 15:18:30 +0000 (GMT)
Received: from sj-msg-core-2.cisco.com ([IPv6:::ffff:171.70.145.30]:14259 "EHLO
	sj-msg-core-2.cisco.com") by linux-mips.org with ESMTP
	id <S8226095AbTAIPS3>; Thu, 9 Jan 2003 15:18:29 +0000
Received: from cisco.com (megha.cisco.com [192.122.173.140])
	by sj-msg-core-2.cisco.com (8.12.2/8.12.2) with ESMTP id h09FIRfm017781;
	Thu, 9 Jan 2003 07:18:27 -0800 (PST)
Received: from IILANGOVW2K ([10.77.139.167])
	by cisco.com (8.8.8/2.6/Cisco List Logging/8.8.8) with SMTP id UAA05081;
	Thu, 9 Jan 2003 20:47:23 +0530 (IST)
Message-ID: <040b01c2b7f2$56ff0f40$a78b4d0a@apac.cisco.com>
From: "Indukumar Ilangovan" <iilangov@cisco.com>
To: <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [OT] cross-compiler problem
Date: Thu, 9 Jan 2003 20:48:18 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <iilangov@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: iilangov@cisco.com
Precedence: bulk
X-list: linux-mips

Hi All,

I tried to build cross compiler on Red Hat Linux
Kernel 2.4.2-2 on an i686.
I use binutils-2.13, gcc-3.2, glibc-2.2.5, glibc-2.2.5-mips-build-gmon.diff,
glibc-linuxthreads.tar.gz.
I followed the instructions from
http://www.ltc.com/~brad/mips/mipsel-linux-cross-toolchain-building.txt

I installed binutils  without any problems.

While compiling glibc2.2.5 I get the following error.

../sysdeps/unix/syscall.S: Assembler messages:
../sysdeps/unix/syscall.S:28: Error: absolute expression required `li'
make[2]: *** [/home/iilangov/crossGCC/mips/mips-glibc/misc/syscall.o] Error
1
make[2]: Leaving directory `/home/iilangov/crossGCC/mips/glibc-2.2.5/misc'
make[1]: *** [misc/subdir_lib] Error 2
make[1]: Leaving directory `/home/iilangov/crossGCC/mips/glibc-2.2.5'
make: *** [all] Error 2

I have "asm/unistd.h" in the include path, still this problem is happening.
Do you guys have any clue ?

Thanks in Advance !
Indu


----- Original Message -----
From: "Alexandre Oliva" <aoliva@redhat.com>
To: "Khantharat Anekboon" <dfos1@hotmail.com>
Cc: <crossgcc@sources.redhat.com>
Sent: Saturday, December 28, 2002 12:22 PM
Subject: Re: cross-compiler problem


| On Dec 28, 2002, "Khantharat Anekboon" <dfos1@hotmail.com> wrote:
|
| > ../sysdeps/unix/syscall.S:28: Error: absolute expression required 'li'
|
| Looks like you're missing the kernel headers where the syscall numbers
| are defined.  (.../include/asm/unistd.h)
|
| --
| Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
| Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
| CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
| Free Software Evangelist                Professional serial bug killer
|
| ------
| Want more information?  See the CrossGCC FAQ,
http://www.objsw.com/CrossGCC/
| Want to unsubscribe? Send a note to
crossgcc-unsubscribe@sources.redhat.com

********************************************************
Indukumar Ilangovan
HCL-Cisco Offshore development center,
49-50, Nelson Manickam Road, Chennai - 600029 ,  India .
TEL:  +91-44-2374 1939 x 2215 FAX: +91-44-3741038
Email :iilangov@cisco.com
