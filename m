Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g68HYLRw028170
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 10:34:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g68HYLud028169
	for linux-mips-outgoing; Mon, 8 Jul 2002 10:34:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g68HYFRw028160;
	Mon, 8 Jul 2002 10:34:15 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA12684;
	Mon, 8 Jul 2002 10:38:31 -0700
Message-ID: <3D29CC6B.5090004@mvista.com>
Date: Mon, 08 Jul 2002 10:31:23 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com> <20020704215614.B29422@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Thu, Jul 04, 2002 at 08:18:41PM +0200, Carsten Langgaard wrote:
> 
> 
>>>any power of 2 > PAGE_SIZE.
>>>
>>Ok, I see, but is there any reason for us to be different than the
>>rest of the world ?
>>
> 
> Imho the your question already wrong :-)  Any assumption about the
> constant's value in a piece of code is wrong.
> 
> The reason why the constant's value was choosen are virtually indexed
> caches.  The value allows attaching of shared memory segment without
> any cache flushes.
> 


I think this is also an effective way to avoid cache aliasing.  As long as 
your cache size is less than 256K, you don't get cache aliasing through shared 
memory.  Perhaps other arches don't have cache aliasing?  I know for sure i386 
does not have that effect.

Jun
