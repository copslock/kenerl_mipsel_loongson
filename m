Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 13:31:09 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:15015 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8224914AbVDFMay>; Wed, 6 Apr 2005 13:30:54 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 6 Apr 2005 08:26:45 -0400
Message-ID: <4253D67C.4010705@timesys.com>
Date:	Wed, 06 Apr 2005 08:30:52 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: memcpy prefetch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Apr 2005 12:26:45.0937 (UTC) FILETIME=[E5CC2A10:01C53AA3]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

In trying to understand the prefetch code in memcpy it looks like it's 
prefetching too far out in front of the loop. In the main aligned loop 
the loop copies 32 or 64 bytes of data and the prefetch is trying to 
prefetch 256 bytes ahead of the current copy. The prefetches should also 
pay attention to cache line size and they currently don't. If the line 
size is less than the copy size we are skipping prefetches that should 
be done. For the 4kc the line size is only 16 bytes. We should be doing 
a prefetch for each line. The src_unaligned_dst_aligned loop is even 
worse as it prefetches 288 bytes ahead of the copy and only copies 16 or 
32 bytes at a time.

Have I totally misunderstood the code?

Greg Weeks
