Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 21:29:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54511 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225262AbULIV3f>; Thu, 9 Dec 2004 21:29:35 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 8774518303; Thu,  9 Dec 2004 13:29:33 -0800 (PST)
Message-ID: <41B8C3BD.3080109@mvista.com>
Date: Thu, 09 Dec 2004 13:29:33 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muruga Ganapathy <gmuruga@gdatech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Forcing IDE to work in PIO mode
References: <200412092102.iB9L2aQ04660@gdatech.com>
In-Reply-To: <200412092102.iB9L2aQ04660@gdatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Please point me to the 2.4.26 or 2.4.27 code that you are referring to

Thanks
Manish Lachwani

Muruga Ganapathy wrote:
> Manish, 
> 
> Thanks for the pointer.
> 
> I am looking for the PCMCIA-IDE driver for the SWARM board in 2.6.x
> I did see this driver in 2.4.26/27 but not in 2.6.10.
> 
> Do you have any suggestions on porting the PCMCIA-IDE driver from 2.4.27
> to 2.6.x?
> 
> Regards
> G.Muruganandam
> 
> 
>>I had posted a patch to this mailing list a few days back. The patch 
>>applies cleanly to the current tree and is currently checked in: 
>>drivers/ide/mips/swarm.c
>>
>>Using this patch, Broadcom SWARM IDE works well
>>
>>Thanks
>>Manish Lachwani
>>
>>Muruga Ganapathy wrote:
>>
>>>Thanks Manish for the information.  
>>> 
>>>BTW, do you have patch to make the swarm IDE work in 2.6.6-rc3 
>>> 
>>>Regards 
>>>G.Muruganandam 
>>> 
>>> 
>>>
>>>
>>>>Muruga Ganapathy wrote: 
>>>>
>>>>
>>>>>Hello,  
>>>>>
>>>>>How do I force the IDE to work in the PIO mode by including the  
>>>>>option like "hdb=noprobe" in the setup.c? 
>>>>>
>>>>>
>>>>>My kernel version is 2.6.6 
>>>>>
>>>>>Thanks 
>>>>>G.Muruganandam 
>>>>>
>>>>
>>>>
>>>>Hello ! 
>>>>
>>>>I would have thought "ide=nodma" at the command line would have 
>>>
>>>worked 
>>>
>>>
>>>>Thanks 
>>>>Manish Lachwani 
>>>>
>>>>
>>>
>>> 
>>>************************************************************* 
>>>GDA Technologies, Inc.		 
>>>1010 Rincon Circle  
>>>San Jose CA, 95131 
>>>Phone	(408) 432-3090 
>>>Fax	(408) 432-3091 
>>> 
>>>Accelerate Your Innovation	 
>>>************************************************************** 
>>
>>
> 
> *************************************************************
> GDA Technologies, Inc.		
> 1010 Rincon Circle 
> San Jose CA, 95131
> Phone	(408) 432-3090
> Fax	(408) 432-3091
> 
> Accelerate Your Innovation	
> **************************************************************
