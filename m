Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 07:30:47 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:33311 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224914AbVBHHab>;
	Tue, 8 Feb 2005 07:30:31 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j187URH32216;
	Tue, 8 Feb 2005 08:30:27 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j187URc12395;
	Tue, 8 Feb 2005 08:30:27 +0100
Message-ID: <42086A92.1020105@schenk.isar.de>
Date:	Tue, 08 Feb 2005 08:30:26 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Manish Lachwani <mlachwani@mvista.com>
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Titan ethernet and little endian
References: <42023C54.7060801@schenk.isar.de> <420269C1.6050701@mvista.com> <42071C29.3030507@schenk.isar.de> <4207A5AD.6090806@mvista.com>
In-Reply-To: <4207A5AD.6090806@mvista.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:
> Rojhalat Ibrahim wrote:
> 
>> Manish Lachwani wrote:
>>
>>> Hi !
>>>
>>> So, have you got the titan to work in the LE mode? Are you using the 
>>> Yosemite board? Does this patch break BE?
>>>
>>> Please do let us know.
>>>
>>> Thanks
>>> Manish Lachwani
>>>
>>>
>>
>> Hi!
>>
>> Yes I have got the titan work in LE mode. And yes I am using the
>> Yosemite board. And no this patch does not break BE. I haven't
>> actually tested that but all the changes I made are between
>> #ifdef LITTLE_ENDIAN and #endif.
>>
>> Thanks
>> Rojhalat Ibrahim
>>
>>
> Ok, as long as the changes are in #ifdef. Although, your patch did not 
> indicate the "#ifdef LITTLE_ENDIAN"
> 
> Thanks
> Manish Lachwani
> 
> 
> 

That's because the #ifdef was already there. The code inbetween
was just not entirely correct.

Thanks
Rojhalat Ibrahim
