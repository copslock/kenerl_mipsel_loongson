Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 18:55:08 +0200 (CEST)
Received: from real.realitydiluted.com ([208.242.241.164]:13547 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S1123253AbSJYQzH>; Fri, 25 Oct 2002 18:55:07 +0200
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 1857jB-0003dT-00; Fri, 25 Oct 2002 11:54:29 -0500
Message-ID: <3DB97744.2010707@realitydiluted.com>
Date: Fri, 25 Oct 2002 11:54:28 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
References: <3DB97381.8070501@realitydiluted.com> <20021025164402.GB6451@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> 
> More information:
> 
> Add -Wl,-v and give us the linker command line.
> 
> Is every object or library mentioned on that line already marked as
> MIPS-2 by readelf?  Even crt*, libc*?
>
I knew I was being stupid, crt* and libc* are mips1 *sigh*. Looks
like I have more work to do for my build system. Below is the verbose
output, but I think that's the problem for sure.

-Steve

mipsel-linux-gcc -shared -Wl,-v,-Amips2,-soname,libz.so.1 -o 
libz.so.1.1.4 adler32.o compress.o crc32.o gzio.o uncompr.o deflate.o 
trees.o zutil.o inflate.o infblock.o inftrees.o infcodes.o infutil.o 
inffast.o
collect2 version 3.2 (MIPSel GNU/Linux with ELF)
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/bin/ld 
--eh-frame-hdr -EL -shared -o libz.so.1.1.4 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib/crti.o 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/crtbeginS.o 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib 
-L/opt/toolchains/uclibc-crosstools-1.0.0/lib/gcc-lib/mipsel-linux/3.2 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib 
-L/opt/toolchains/uclibc-crosstools-1.0.0/lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib 
-L/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../.. -v 
-Amips2 -soname libz.so.1 adler32.o compress.o crc32.o gzio.o uncompr.o 
deflate.o trees.o zutil.o inflate.o infblock.o inftrees.o infcodes.o 
infutil.o inffast.o -lgcc -lc -lgcc 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/crtendS.o 
/opt/toolchains/uclibc/bin/../lib/gcc-lib/mipsel-linux/3.2/../../../../mipsel-linux/lib/crtn.o
GNU ld version 2.13
