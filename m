Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 18:38:36 +0200 (CEST)
Received: from real.realitydiluted.com ([208.242.241.164]:4331 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S1123253AbSJYQig>; Fri, 25 Oct 2002 18:38:36 +0200
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 1857Te-0003cg-00; Fri, 25 Oct 2002 11:38:26 -0500
Message-ID: <3DB97381.8070501@realitydiluted.com>
Date: Fri, 25 Oct 2002 11:38:25 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: binutils@sources.redhat.com
Subject: Problems generating shared library for MIPS using binutils-2.13...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Greetings.

I'm doing something stupid here, so please help me out. I am trying
to create a shared library with gcc passing parameters to the linker
and it is not working.

I compiled all the object files with '-mips2' and then I attempt to
create the shared library with:

    mipsel-linux-gcc -shared -Wl,-Amips2,-soname,libz.so.1 \
       -o libz.so.1.1.4 adler32.o compress.o crc32.o gzio.o \
       uncompr.o deflate.o trees.o zutil.o inflate.o infblock.o \
       inftrees.o infcodes.o infutil.o inffast.o

The object files are all mips2, but the generated '.so' object
is mips1?! What am I not understanding? I am using binutils-2.13,
gcc-3.2 and uClibc-0.9.15. The use of uClibc is not the problem.

-Steve
