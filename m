Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2005 08:44:09 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:36136 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224909AbVBJInx>;
	Thu, 10 Feb 2005 08:43:53 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1A8hCH17425;
	Thu, 10 Feb 2005 09:43:12 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1A8hBc29457;
	Thu, 10 Feb 2005 09:43:12 +0100
Message-ID: <420B1E9F.1060206@schenk.isar.de>
Date:	Thu, 10 Feb 2005 09:43:11 +0100
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
X-archive-position: 7221
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

I have actually tested it also in BE mode now.
Is there any remaining reason not to apply this patch?

Thanks
Rojhalat Ibrahim
