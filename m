Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 17:30:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:42741 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224807AbVBGRaY>; Mon, 7 Feb 2005 17:30:24 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id B1DEA187F9; Mon,  7 Feb 2005 09:30:21 -0800 (PST)
Message-ID: <4207A5AD.6090806@mvista.com>
Date:	Mon, 07 Feb 2005 09:30:21 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Titan ethernet and little endian
References: <42023C54.7060801@schenk.isar.de> <420269C1.6050701@mvista.com> <42071C29.3030507@schenk.isar.de>
In-Reply-To: <42071C29.3030507@schenk.isar.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Rojhalat Ibrahim wrote:

> Manish Lachwani wrote:
>
>> Hi !
>>
>> So, have you got the titan to work in the LE mode? Are you using the 
>> Yosemite board? Does this patch break BE?
>>
>> Please do let us know.
>>
>> Thanks
>> Manish Lachwani
>>
>>
>
> Hi!
>
> Yes I have got the titan work in LE mode. And yes I am using the
> Yosemite board. And no this patch does not break BE. I haven't
> actually tested that but all the changes I made are between
> #ifdef LITTLE_ENDIAN and #endif.
>
> Thanks
> Rojhalat Ibrahim
>
>
Ok, as long as the changes are in #ifdef. Although, your patch did not 
indicate the "#ifdef LITTLE_ENDIAN"

Thanks
Manish Lachwani
