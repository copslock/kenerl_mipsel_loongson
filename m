Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jan 2003 22:45:51 +0000 (GMT)
Received: from web40414.mail.yahoo.com ([IPv6:::ffff:66.218.78.111]:159 "HELO
	web40414.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225256AbTA3Wpv>; Thu, 30 Jan 2003 22:45:51 +0000
Message-ID: <20030130224543.7903.qmail@web40414.mail.yahoo.com>
Received: from [157.165.41.125] by web40414.mail.yahoo.com via HTTP; Thu, 30 Jan 2003 14:45:43 PST
Date: Thu, 30 Jan 2003 14:45:43 -0800 (PST)
From: Long Li <long21st@yahoo.com>
Subject: How to get the c source code in disassembly?
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <long21st@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: long21st@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi, 

I am having a problem with intermixing the C source
code in the disassembly. I am using a MIPS
crosscompiler on Redhat 7.1, gcc-3.0.4,
binutils-2.11.2. When I compiled the C code, I added
the -g option, and then use 'objdump -Sd' to get the
disassembly. However, I did not see any C code mixed
with the assembly, as said in the objdump manual when
using -S option. Could you give me some help or
suggestions? 

Thanks a lot!


Long


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
