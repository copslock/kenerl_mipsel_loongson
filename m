Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 20:08:06 +0000 (GMT)
Received: from web40411.mail.yahoo.com ([IPv6:::ffff:66.218.78.108]:31349 "HELO
	web40411.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224939AbTBMUIF>; Thu, 13 Feb 2003 20:08:05 +0000
Message-ID: <20030213200757.92340.qmail@web40411.mail.yahoo.com>
Received: from [157.165.41.125] by web40411.mail.yahoo.com via HTTP; Thu, 13 Feb 2003 12:07:57 PST
Date: Thu, 13 Feb 2003 12:07:57 -0800 (PST)
From: Long Li <long21st@yahoo.com>
Subject: memcpy embedded in gcc?
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <long21st@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: long21st@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I am using a gcc 3.0.4 MIPS crosscompiler on Redhat. I
found something interesting: when I use specifly -O1
for compilation, and I can use memcpy function even I
did not tell the compiler where I declard it or define
it. However, when I specify -O0, then the compiler
tells me undefined reference to this memcpy function.
So my questions are:

1. Is memcpy a built-in function for gcc? But why not
for optimization level 0?

2. Besides memcpy, is there any other functions built
in too?


Thanks a lot!


Long


__________________________________________________
Do you Yahoo!?
Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com
