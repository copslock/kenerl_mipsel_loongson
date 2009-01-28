Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 19:55:32 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18418 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365743AbZA1Tza (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jan 2009 19:55:30 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4980b7f60000>; Wed, 28 Jan 2009 14:54:30 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Jan 2009 11:54:03 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Jan 2009 11:54:02 -0800
Message-ID: <4980B7DB.3090304@caviumnetworks.com>
Date:	Wed, 28 Jan 2009 11:54:03 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Michael Sundius <msundius@cisco.com>
CC:	linux-mips@linux-mips.org, "VomLehn, David" <dvomlehn@cisco.com>,
	msundius@sundius.com
Subject: Re: memcpy and prefetch
References: <497F9214.1000609@cisco.com> <497F93C1.3090401@caviumnetworks.com> <4980B1CA.4060505@cisco.com>
In-Reply-To: <4980B1CA.4060505@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2009 19:54:02.0968 (UTC) FILETIME=[2B57DD80:01C98182]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Michael Sundius wrote:
> David Daney wrote:
[...]
>> The Cavium OCTEON port overrides the default memcpy and does use 
>> prefetch.  It was recently merged (2.6.29-rc2).  Look at octeon-memcpy.S
[...]
> 
> thanks!!! that's really useful. I have a few questions tho:
> 
> 1) So you made this function explicitly for the Octeon.

I didn't personally write the code. But yes, as its name implies, it was 
created specifically for OCTEON.

> and that is 
> because you know the cache-line is 128 bytes long
> on the octeon? is that right?

That and we know exactly how prefetching works on this CPU *and* we know 
we can do unaligned accesses quickly.

> 
> 2) It seems as though you always prefectch the first cache line..  what 
> happens if the memcopy is less than 1 cache line long?
> wouldn't you risk prefetching beyond the end of the buffer?

It is a risk we were willing to take.  Cache lines are loaded with 
unneeded data all the time.

> 
> 3) why do you only do the "pref   0 offset(src)" and not a prefetch for 
> the destination?

I don't know.  But the interaction between the writeback buffers, the 
cache and RAM are somewhat complicated.  It may not be enough of a win 
to overcome the cost of the code that would determine when to do it.

> 
> 4) on line 244 you check to see if len is less than 128. while on the 
> other checks you check for (offset)+1
> why would you not do the prefetch if len was exactly 256 bytes? (or 128 
> in the case of line 196)?

We are always prefetching 256 bytes ahead of the current position.  If 
we prefetch beyound the end of the buffer it is truly wasting memory 
bandwidth, also if we prefetch to memory addresses where there is no 
physical memory, bad things happen.

David Daney
