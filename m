Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 08:43:36 +0000 (GMT)
Received: from web40407.mail.yahoo.com ([IPv6:::ffff:66.218.78.104]:7452 "HELO
	web40407.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225263AbSLQInf>; Tue, 17 Dec 2002 08:43:35 +0000
Message-ID: <20021217084303.20121.qmail@web40407.mail.yahoo.com>
Received: from [12.234.201.50] by web40407.mail.yahoo.com via HTTP; Tue, 17 Dec 2002 00:43:03 PST
Date: Tue, 17 Dec 2002 00:43:03 -0800 (PST)
From: Long Li <long21st@yahoo.com>
Subject: .reginfo and .mdebug section
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <long21st@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: long21st@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi, 

I have some problems after building a linux-mips cross
compiler on Red Hat7.1. 

1. I tried to compile some c code targetting mips4k,
which is 32-bit ISA. However, the map file tells me
that the compiled code are 64-bit, since the address
are 64-bit.

2. When I compiled the c code, I found in the mapfile
that there are some sections called .reginfo and
.mdebug. What are those sections? I would like to get
rid of them. However, they still exists even if I
deleted the '-g' option for gcc. Is there a way I can
avoid the .reginfo and .mdebug sections?


Thanks a lot!


Long


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
