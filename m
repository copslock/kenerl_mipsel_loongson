Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 18:56:16 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:2937 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225253AbVHJRz7>; Wed, 10 Aug 2005 18:55:59 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 10 Aug 2005 13:49:54 -0400
Message-ID: <42FA40A2.6010400@timesys.com>
Date:	Wed, 10 Aug 2005 14:00:02 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC:	linux-mips@linux-mips.org
Subject: Re: 24K malta
References: <42FA03D4.5060400@timesys.com>
In-Reply-To: <42FA03D4.5060400@timesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Aug 2005 17:49:54.0515 (UTC) FILETIME=[EA56E230:01C59DD3]
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Greg Weeks wrote:

> I'm seeing something strange on a 24K malta and I'm wondering if 
> anyone else has ran into something like it.
>
> This is a 2.6.12 based kernel. I've not had a chance to try the 
> current CVS yet. The last time I checked the current CVS didn't boot 
> as is on a 4Kc malta so I've not been keeping current with CVS.
>
> When I try a simple
>
> strace ls
>
> I either hang or seg fault on a 24Kc or 24Kec processor, but a 4Kc or 
> 4Kec works. If I turn off the cache on the 24K it works as well. 
> Without cache it's unbearably slow of course. This is the same exact 
> build of the kernel and root file system for all boards.

The memcpy prefetch bug is still there for malta, so I had to build 
another kernel. This is with a CVS sync from this morning.

The first strace ls works now, but the second time I do it it hangs. 
Kill -9 frees it up and the board isn't hanging.

Greg Weeks
