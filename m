Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 07:20:18 +0000 (GMT)
Received: from pop.gmx.net ([IPv6:::ffff:213.165.64.20]:38052 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8224914AbVBHHUB>;
	Tue, 8 Feb 2005 07:20:01 +0000
Received: (qmail invoked by alias); 08 Feb 2005 07:19:35 -0000
Received: from c178209.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.178.209)
  by mail.gmx.net (mp014) with SMTP; 08 Feb 2005 08:19:35 +0100
X-Authenticated: #947741
Message-ID: <42086846.9060709@gmx.net>
Date:	Tue, 08 Feb 2005 08:20:38 +0100
From:	TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Kernel crash on yosemite
References: <4207F163.4010605@gmx.net> <20050208013000.GA6131@linux-mips.org> <42081A2C.5060503@mvista.com> <20050208015155.GB15336@linux-mips.org> <42081DA0.6070301@mvista.com> <20050208023349.GC15336@linux-mips.org> <42082C2C.5020703@mvista.com>
In-Reply-To: <42082C2C.5020703@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Hi,

I'm sorry, but all the discussion on this thread did'n help me to solve 
my problem. Since more than a month I'm waitig to get a yosemite board 
with 1.2 version. This still stops my development, when I can't use the 
yosemite with 1.1 version.

In another therad we discuss to create a patch (slowpath) for the titan 
version 1.1. the patch I apply to the the newer kernel sources 
(2.6.11.rc1) but, I have the same problems. So I think the problem could 
be the slowpath thing.

Have anybody an idee how to figure out what could be the problem when I 
make "cp foo foo1" (foo is a lage file ~3,5 Mb)?

Best regards
TheNop



Manish Lachwani wrote:

> Ralf Baechle wrote:
>
>> On Mon, Feb 07, 2005 at 06:02:08PM -0800, Manish Lachwani wrote:
>>
>>  
>>
>>> I completely agree. In any case, I dont think the CVS sources ever 
>>> supported SMP for Titan < 1.2, correct?
>>>   
>>
>>
>> No, that would have either meant taking a heavy performance penalty or
>> hacking mm in very ugly ways. 
>
>
> How would I not know this? After all, I was the one who actually put 
> this code together to get SMP to work on Titan 1.0 and 1.1, remember? 
> ;) And you are right, there is no reason to put such hacks.
>
> Manish Lachwani
>
>
>> And due to the probably low numbers of
>> the early silicon and the availability of later revisions the reason
>> for such hacks was low anyway.
>>
>>  Ralf
>>
>>  
>>
>
>
>
>
