Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jan 2003 21:29:18 +0000 (GMT)
Received: from heffalump.fnal.gov ([IPv6:::ffff:131.225.9.20]:34255 "EHLO
	fnal.gov") by linux-mips.org with ESMTP id <S8225254AbTA3V3R>;
	Thu, 30 Jan 2003 21:29:17 +0000
Received: from ppd89948 ([131.225.55.68])
 by smtp.fnal.gov (PMDF V6.0-24 #37519) with ESMTP id
 <0H9J001CSQCS2Q@smtp.fnal.gov> for linux-mips@linux-mips.org; Thu,
 30 Jan 2003 15:29:16 -0600 (CST)
Date: Thu, 30 Jan 2003 15:29:16 -0600
From: Jason Ormes <jormes@wideopenwest.com>
Subject: compiling mips64 problem
To: linux-mips@linux-mips.org
Message-id: <002801c2c8a6$a41f3470$4437e183@fermi.win.fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook, Build 10.0.4024
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Return-Path: <jormes@wideopenwest.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jormes@wideopenwest.com
Precedence: bulk
X-list: linux-mips

Hello,

I downloaded and installed from ftp.linux-mips.org

binutils-mips64-linux-2.13.1-1.i386.rpm
egcs-mips64-linux-1.1.2-4.i386.rpm

I got the kernel from the cvs repository and configured it for a mips64
kernel.

When I try to build it I get 

arch/mips64/lib/memcpy.S: Assembler messages:
arch/mips64/lib/memcpy.S:220: Error: illegal operands `lw
t4,((4)*4)($5)'
arch/mips64/lib/memcpy.S:221: Error: illegal operands `lw
t7,((5)*4)($5)'
arch/mips64/lib/memcpy.S:230: Error: illegal operands `sw
t4,((-4)*4)($4)'
arch/mips64/lib/memcpy.S:231: Error: illegal operands `sw
t7,((-3)*4)($4)'
make[1]: *** [arch/mips64/lib/memcpy.o] Error 1

could someone throw me a bone and let me know what I'm doing wrong?

Jason Ormes
