Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 13:20:22 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:35719 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8224991AbVHXMUH>; Wed, 24 Aug 2005 13:20:07 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 24 Aug 2005 08:25:08 -0400
Message-ID: <430C673E.4070502@timesys.com>
Date:	Wed, 24 Aug 2005 08:25:34 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: 24K malta
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org>
In-Reply-To: <20050810140243.GD2840@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2005 12:25:08.0703 (UTC) FILETIME=[DDAC6EF0:01C5A8A6]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Wed, Aug 10, 2005 at 09:40:36AM -0400, Greg Weeks wrote:
>
>  
>
>>I'm seeing something strange on a 24K malta and I'm wondering if anyone 
>>else has ran into something like it.
>>
>>This is a 2.6.12 based kernel. I've not had a chance to try the current 
>>CVS yet. The last time I checked the current CVS didn't boot as is on a 
>>4Kc malta so I've not been keeping current with CVS.
>>
>>When I try a simple
>>
>>strace ls
>>
>>I either hang or seg fault on a 24Kc or 24Kec processor, but a 4Kc or 
>>4Kec works. If I turn off the cache on the 24K it works as well. Without 
>>cache it's unbearably slow of course. This is the same exact build of 
>>the kernel and root file system for all boards.
>>    
>>
>
>I cannot reproduce this problem on 24KEc Malta, sorry.
>  
>
What patch are you using to get current CVS to boot on a malta? I've 
been disabling prefetch in memcpy, but if you're doing something else I 
want to try that. About 1 out of 3 "strace ls" either hangs or seg 
faults on me still.

Greg Weeks
