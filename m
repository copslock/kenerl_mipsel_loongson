Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2004 03:02:49 +0000 (GMT)
Received: from law10-f39.law10.hotmail.com ([IPv6:::ffff:64.4.15.39]:42505
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225353AbUBVDCq>; Sun, 22 Feb 2004 03:02:46 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sat, 21 Feb 2004 19:02:39 -0800
Received: from 24.209.41.112 by lw10fd.law10.hotmail.msn.com with HTTP;
	Sun, 22 Feb 2004 03:02:39 GMT
X-Originating-IP: [24.209.41.112]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From:	"Mark and Janice Juszczec" <juszczec@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: r3000 instruction set
Date:	Sun, 22 Feb 2004 03:02:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
X-OriginalArrivalTime: 22 Feb 2004 03:02:39.0476 (UTC) FILETIME=[54C85340:01C3F8F0]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi folks

I'm working with kaffe on a r3912 cpu. I'm getting an illegal instruction
error. I disassembled the kaffe binary and thought I'd find the offending
instruction.

Unfortunately, I found 2 different lists of r3000 assembler instructions at:

http://www.xs4all.nl/~vhouten/mipsel/r3000-isa.html
http://www.xs4all.nl/~vhouten/mipsel/appB.html

and comparing them against the list of disassembled kaffe instructions
gives 2 different results.

So, can someone recommend a definitive list of r3000 assembler instructions?

Any help would be greatly appreciated.

Mark

_________________________________________________________________
Find and compare great deals on Broadband access at the MSN High-Speed 
Marketplace. http://click.atdmt.com/AVE/go/onm00200360ave/direct/01/
