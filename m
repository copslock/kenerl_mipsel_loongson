Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 09:57:07 +0000 (GMT)
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:61354 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23740232AbYKRJ5E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2008 09:57:04 +0000
Received: from OMTA02.emeryville.ca.mail.comcast.net ([76.96.30.19])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id gZrv1a0050QkzPwA2Zwu8q; Tue, 18 Nov 2008 09:56:54 +0000
Received: from [10.0.0.109] ([24.6.28.106])
	by OMTA02.emeryville.ca.mail.comcast.net with comcast
	id gZwq1a0032HMlxk8NZwryw; Tue, 18 Nov 2008 09:56:52 +0000
X-Authority-Analysis: ??
Message-ID: <49229165.80000@notav8.com>
Date:	Tue, 18 Nov 2008 01:56:53 -0800
From:	Chris Rhodin <chris@notav8.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: gdb configuration
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chris@notav8.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@notav8.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to debug 32-bit linux over a serial port with gdb.  I'm able 
to connect to the target and everything looks good until I examine the 
registers.  What's there is obviously wrong.  I've examined the stack 
and found the register data structure.  Each register in this structure 
is 32 bits.  When I compare the structure to the registers that gdb 
displays I can see that gdb is expecting each register to occupy 64 
bits.  I've tried setting "abi", "saved-gpreg-size", and 
"stack-arg-size" to 32 bits without success.  Can someone point out my 
obvious mistake?

Thanks,


Chris Rhodin
