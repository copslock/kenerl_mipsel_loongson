Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 16:34:42 +0100 (BST)
Received: from sccrmhc13.comcast.net ([63.240.76.28]:16815 "EHLO
	sccrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133556AbVJGPeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2005 16:34:14 +0100
Received: from buzz (c-67-171-115-157.hsd1.ut.comcast.net[67.171.115.157])
          by comcast.net (sccrmhc13) with SMTP
          id <2005100715340701300bies9e>; Fri, 7 Oct 2005 15:34:07 +0000
From:	"Kyle Unice" <unixe@comcast.net>
To:	<linux-mips@linux-mips.org>
Subject: Cygwin Cross-compile of linux release
Date:	Fri, 7 Oct 2005 09:34:05 -0600
Message-ID: <001901c5cb54$8dfc70f0$0400a8c0@buzz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <unixe@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: unixe@comcast.net
Precedence: bulk
X-list: linux-mips

I checked out the source for mips linux and tried cross-compiling this on
cygwin.  
This is the result:
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
scripts/mod/sumversion.c: In function `md4_final_ascii':
scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
int ar
g (arg 4)
scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
int ar
g (arg 5)
scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
int ar
g (arg 6)
scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
int ar
g (arg 7)
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
scripts/kallsyms.c: In function `compress_symbols':
scripts/kallsyms.c:366: warning: implicit declaration of function `memmem'
scripts/kallsyms.c:366: warning: assignment makes pointer from integer
without a
 cast
scripts/kallsyms.c:385: warning: assignment makes pointer from integer
without a
 cast
/cygdrive/c/DOCUME~1/KYLE~1.BUZ/LOCALS~1/Temp/ccLMGC3l.o:kallsyms.c:(.text+0
x6cb
): undefined reference to `_memmem'
/cygdrive/c/DOCUME~1/KYLE~1.BUZ/LOCALS~1/Temp/ccLMGC3l.o:kallsyms.c:(.text+0
x72d
): undefined reference to `_memmem'
collect2: ld returned 1 exit status
make[1]: *** [scripts/kallsyms] Error 1
make: *** [scripts] Error 2

Kyle@buzz /usr/src/linux
$
