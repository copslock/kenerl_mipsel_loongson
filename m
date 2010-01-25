Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2010 18:39:44 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8924 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492486Ab0AYRjk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2010 18:39:40 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b5dd7610001>; Mon, 25 Jan 2010 09:39:45 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 25 Jan 2010 09:38:48 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 25 Jan 2010 09:38:48 -0800
Message-ID: <4B5DD728.60202@caviumnetworks.com>
Date:   Mon, 25 Jan 2010 09:38:48 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
CC:     linux-mips@linux-mips.org
Subject: Re: 1 GB RAM with RM9000 SOC
References: <4B56475F.8070608@gmail.com> <20100124002352.GB3251@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C020140474B674@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <4B5DD1A9.6020306@caviumnetworks.com> <A7DEA48C84FD0B48AAAE33F328C020140474B761@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C020140474B761@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2010 17:38:48.0750 (UTC) FILETIME=[406DF4E0:01CA9DE5]
X-archive-position: 25653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16095

Anoop P.A. wrote:
> Hi David,
> 
> Thanks for the info. In which version of LMO kernel , I could find your
> working source ?.
> 

I think it was added in 2.6.29

David Daney


> Thanks
> Anoop
> 
>> -----Original Message-----
>> From: David Daney [mailto:ddaney@caviumnetworks.com]
>> Sent: Monday, January 25, 2010 10:45 PM
>> To: Anoop P.A.
>> Cc: linux-mips@linux-mips.org
>> Subject: Re: 1 GB RAM with RM9000 SOC
>>
>> Anoop P.A. wrote:
>>> Hi list,
>>>
>>>
>>>
>>> Any of you successfully used >512MB ram with MIPS SOC's.
>> Does Cavium Octeon count as a MIPS SOC?  If so, then yes.
>>
>> I have many boards with both 2GB and 4GB.  All of them Linux just fine
>> when using all available RAM.
>>
>>> I have a
>>> requirement where I have to use 1 GB ram with RM9000 based SOC.
>>>
>>> I have enabled 64 Bit support and so far it is working with 512 MB
> of
>>> RAM. How ever if I increase memory beyond 512MB I am getting kernel
>>> panic.
>>>
>>>
>>>
>>>  I am adding memory region from 0x00 add_memory_region(0 ,0x40000000
> ,
>>> BOOT_MEM_RAM). (PMON maps RAM from 0x0 to 0x40000000)  Am I wrong
> here?
>>>
>>>
>>> It will be great if you can give some suggestion /point me to a
> working
>>> implementation. I am using 2.6.18 kernel.
>>>
>>>
>>>
>>> Thanks
>>>
>>> Anoop
>>>
>>>
>>>
>>>
> 
> 
