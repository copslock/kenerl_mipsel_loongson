Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 20:13:23 +0100 (CET)
Received: from gateway08.websitewelcome.com ([69.56.142.29]:52975 "HELO
        gateway08.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491101Ab1AXTNU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 20:13:20 +0100
Received: (qmail 964 invoked from network); 24 Jan 2011 19:12:40 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway08.websitewelcome.com with SMTP; 24 Jan 2011 19:12:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=N2xBtX43R+/+Pk7Ahj7aCPL1jw8DgliBxrYVAGKnvcc7RCTITauwTwsLAYCDiG/p6XMpHAUdqlBIjl5a1MyAroVxAf1NuYI3TOulWLQfEM3ecWi1D7cTh4x+ASS0tUFY;
Received: from [216.239.45.4] (port=62280 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PhRqh-0004VL-LC; Mon, 24 Jan 2011 13:13:11 -0600
Message-ID: <4D3DCF4A.1020509@paralogos.com>
Date:   Mon, 24 Jan 2011 11:13:14 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        kernelnewbies@nl.linux.org
Subject: Re: page size change on MIPS
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com> <4D3DCB5A.6060107@caviumnetworks.com>
In-Reply-To: <4D3DCB5A.6060107@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 01/24/11 10:56, David Daney wrote:
> On 01/24/2011 07:02 AM, naveen yadav wrote:
>> Hi All,
>>
>>
>> we are using mips32r2  so I want to know which all pages size it can 
>> support?
>> When I modify arch/mips/Kconfig.  it boot sucessfully on 16KB page
>> size. but hang/not boot crash when change page size to 8KB,32KB and 64
>> KB.
>
> I don't think 8KB and 32KB work on most mips32r2 processors.  You 
> would have to check the processor manual to be sure.

In principle, one should be able to detect this at run-time, by writing 
a sequence of values into the PageMask register and seeing which masks 
'stick'.

/K.
