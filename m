Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 02:14:23 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17658 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224989AbVCKCOI>; Fri, 11 Mar 2005 02:14:08 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id A9E2018BA1; Thu, 10 Mar 2005 18:14:05 -0800 (PST)
Message-ID: <4230FEED.9090402@mvista.com>
Date:	Thu, 10 Mar 2005 18:14:05 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ppopov@embeddedalley.com
Cc:	Linux Mailinglist <mailinglist.linux@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Linux 2.6 support for Brecis MSP2100 processor !
References: <77fd3fe0050308202654a4432a@mail.gmail.com>	 <20050309173044.GA18688@linux-mips.org> <77fd3fe00503101746fed176b@mail.gmail.com> <4230FAC9.6040304@embeddedalley.com>
In-Reply-To: <4230FAC9.6040304@embeddedalley.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

4Km is a 4Kc without TLB. I think this is supported.

Thanks
Manish Lachwani


Pete Popov wrote:

> Linux Mailinglist wrote:
>
>> Hi Ralf !
>>
>> Thanks, but the problem with this SOC is that it does not have MMU. I
>> would like to know wheather we have the port for Mips 4Km processor
>> without MMU ?
>
>
> Take a look at uclinux.org. That's the MMU-less project. I don't know 
> what the MIPS statis is though.
>
> Pete
>
>>
>> Thanks in advance. Srinivasan
>>
>>
>> On Wed, 9 Mar 2005 17:30:44 +0000, Ralf Baechle <ralf@linux-mips.org> 
>> wrote:
>>
>>> On Tue, Mar 08, 2005 at 08:26:40PM -0800, Linux Mailinglist wrote:
>>>
>>>
>>>> Is anybody have a port of Linux 2.6 kernel on Brecis MSP2100 
>>>> processor ?
>>>
>>>
>>> That's not a processor but a whole SOC and the processor is a 4Km which
>>> is supported.
>>>
>>> Ralf
>>>
>>
>>
>>
>
>
