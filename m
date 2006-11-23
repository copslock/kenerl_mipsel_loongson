Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2006 00:10:31 +0000 (GMT)
Received: from gateway-1237.mvista.com ([63.81.120.158]:16845 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20039407AbWKWAK1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Nov 2006 00:10:27 +0000
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id DBDB11C08B; Wed, 22 Nov 2006 16:10:02 -0800 (PST)
Message-ID: <4564E6DA.1030504@mvista.com>
Date:	Wed, 22 Nov 2006 16:10:02 -0800
From:	mlachwani <mlachwani@mvista.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: request_module: runaway loop modprobe net-pf-1
References: <1164224559.6511.4.camel@sandbar.kenati.com>	 <20061122221712.GB8819@linux-mips.org> <1164239075.6511.13.camel@sandbar.kenati.com>
In-Reply-To: <1164239075.6511.13.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

CONFIG_UNIX is defined in net/unix/Kconfig or simply do a "make 
menuconfig" and search for UNIX.

It depends on CONFIG_NET. Check your .config ...

thanks,
Manish Lachwani


Ashlesha Shintre wrote:
> On Wed, 2006-11-22 at 22:17 +0000, Ralf Baechle wrote:
>   
>> On Wed, Nov 22, 2006 at 11:42:39AM -0800, Ashlesha Shintre wrote:
>>
>>     
>>> During boot up on the Encore M3 board (AU1500 MIPS) of the 2.6.14.6
>>> kernel, the process stops after the NFS filesystem has been mounted,
>>> memory freed  and spits out the following message:
>>>
>>>
>>>       
>>>> request_module: runaway loop modprobe net-pf-1
>>>>         
>> The kernel tried to open UNIX domain socket but because support is not
>> compiled it will load the module instead.  Now, glibc-based programs
>> happen to try to connect to nscd via a UNIX domain socket on startup
>> and the whole show starts all over.  After a few iterations the kernel
>> gets tired of the whole game and prints this friendly message.
>>
>>     
>>> What does the net-pf-1 mean?
>>>       
>> net-pf-1 is PF_UNIX, see the definitions in include/linux/socket.h.  So
>> you should set CONFIG_UNIX to y.  
>>     
>
> Thanks for your reply Ralf, but I dont see he CONFIG_UNIX option in my
> Makefile, so I created one, but still get the same error!
> is there anything else that i should try?
>
> Thanks again,
> Ashlesha.
>   
>> Building it as a module won't work
>> as you just found :).
>>
>>   Ralf
>>     
>
>
>   
