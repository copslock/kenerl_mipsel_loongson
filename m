Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 22:02:28 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:54805 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365084AbZA1WC0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jan 2009 22:02:26 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4980d5d10000>; Wed, 28 Jan 2009 17:01:53 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Jan 2009 13:52:22 -0800
Received: from [192.168.162.106] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Jan 2009 13:52:22 -0800
Message-ID: <4980D396.5020302@caviumnetworks.com>
Date:	Wed, 28 Jan 2009 13:52:22 -0800
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.14eol) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.13~pre080614i-0etch1)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	Michael Sundius <msundius@cisco.com>, linux-mips@linux-mips.org,
	"VomLehn, David" <dvomlehn@cisco.com>, msundius@sundius.com
Subject: Re: memcpy and prefetch
References: <497F9214.1000609@cisco.com> <497F93C1.3090401@caviumnetworks.com> <4980B1CA.4060505@cisco.com> <4980B7DB.3090304@caviumnetworks.com>
In-Reply-To: <4980B7DB.3090304@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2009 21:52:22.0551 (UTC) FILETIME=[B3064270:01C98192]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

> Michael Sundius wrote:
>> David Daney wrote:
>> 2) It seems as though you always prefectch the first cache line..  what 
>> happens if the memcopy is less than 1 cache line long?
>> wouldn't you risk prefetching beyond the end of the buffer?
> 
> It is a risk we were willing to take.  Cache lines are loaded with 
> unneeded data all the time.

If you assume that the memcpy is going to copy at least one byte, then
it is always safe to prefetch the first source address.

>> 3) why do you only do the "pref   0 offset(src)" and not a prefetch for 
>> the destination?
> 
> I don't know.  But the interaction between the writeback buffers, the 
> cache and RAM are somewhat complicated.  It may not be enough of a win 
> to overcome the cost of the code that would determine when to do it.

Octeon's write buffer merges all writes to single store transactions.
Since this store contains a full cache line, the L2 controller
automatically optimizes for it. With Octeon, the prepare to store
operations normally slow things down by creating needless bus traffic.
There are a few times where it is useful, but a generic memcpy isn't one
of them.

>> 4) on line 244 you check to see if len is less than 128. while on the 
>> other checks you check for (offset)+1
>> why would you not do the prefetch if len was exactly 256 bytes? (or 128 
>> in the case of line 196)?
> 
> We are always prefetching 256 bytes ahead of the current position.  If 
> we prefetch beyound the end of the buffer it is truly wasting memory 
> bandwidth, also if we prefetch to memory addresses where there is no 
> physical memory, bad things happen.

We prefetch 256 bytes ahead on every 128 bytes copied except for the
last two. Since we are fetching two lines ahead, the last two iterations
don't need prefetches. I think the code stops prefetching at the correct
time, but there is always the possibility that I messed up...

Chad
