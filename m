Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 12:39:34 +0100 (BST)
Received: from 178.69-56-134.reverse.theplanet.com ([IPv6:::ffff:69.56.134.178]:28311
	"EHLO texas.onkelinx.com") by linux-mips.org with ESMTP
	id <S8225007AbUIPLj3>; Thu, 16 Sep 2004 12:39:29 +0100
Received: from [127.0.0.1] (Office [193.190.11.247])
	(authenticated bits=0)
	by texas.onkelinx.com (8.12.8/8.12.8) with ESMTP id i8GBdQtn016676
	for <linux-mips@linux-mips.org>; Thu, 16 Sep 2004 06:39:28 -0500
Message-ID: <41497B5B.8000402@Linux4.Be>
Date: Thu, 16 Sep 2004 13:39:07 +0200
From: Filip Onkelinx <Filip@Linux4.Be>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: vr4131 : cache/linesize
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Filip@Linux4.Be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Filip@Linux4.Be
Precedence: bulk
X-list: linux-mips

Hi all,

I'm currently trying to get kernel 2.6.8 running on a Casio BE-300, a 
NEC VR4131 (rev1.2) based PDA.

I noticed a (for me) strange result when comparing 2.4 with 2.6,  please 
have a look at the linesize below:
kernel 2.4.18:
   CPU revision is: 00000c80
   Primary instruction cache 16kb, linesize 32 bytes.
   Primary data cache 16kb, linesize 16 bytes.
kernel 2.6.8:
   Primary instruction cache 16kB, physically tagged, 2-way, linesize 16 
bytes.
   Primary data cache 16kB 2-way, linesize 16 bytes.

Any idea why the reported icache linesize is different between2.4 and 
2.6 ? Which one should I trust ?

and from the original botloader it looks like at boot config is set to:
# [4    ] DB: 0= data cache refill size=4 words
# [5    ] IB: 1=instruction cache refill size=8 words
# [6-8  ] DC: 100= data cache size, 16K
# [9-11 ] IC: 101= instruction cache size, 16K.

Is it common to have different dcache/icache  refill sizes ?

Thanks for your time,

Filip.



-- 
----

Do not follow where the path may lead. Go instead where there is no path and leave a trail  - Ralph Waldo Emerson

----

Filip Onkelinx
Heidebloemstraat 20, B-3500 Hasselt, BELGIUM
fax: +32 11 65 65 97, mobile: +32 475 69 47 63
filip@onkelinx.com
