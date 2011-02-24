Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 22:44:08 +0100 (CET)
Received: from gateway14.websitewelcome.com ([67.18.22.82]:40389 "HELO
        gateway14.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491834Ab1BXVoF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Feb 2011 22:44:05 +0100
Received: (qmail 27611 invoked from network); 24 Feb 2011 21:47:28 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway14.websitewelcome.com with SMTP; 24 Feb 2011 21:47:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=WdYHIlaCy7V2ChT+yFoR8Jq8CwNbRScPmVFMoi/ZLfTzrxL5ydCw7eGy+ppWzCrJatPg1oX7NIvqPXPLuQJC4zkHsUH3n2haWuiLhfaK3DxrUVqYipWRf9aMbr4rq1h3;
Received: from [216.239.45.4] (port=21982 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1Psiyg-0001t1-3N; Thu, 24 Feb 2011 15:44:02 -0600
Message-ID: <4D66D121.7070405@paralogos.com>
Date:   Thu, 24 Feb 2011 13:44:01 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Himanshu Chauhan <hschauhan@nulltrace.org>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: Kernel link address assumption
References: <4D669FCE.8000601@nulltrace.org> <4D66A08F.7050605@paralogos.com> <4D66A1AC.2090007@nulltrace.org>
In-Reply-To: <4D66A1AC.2090007@nulltrace.org>
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
X-archive-position: 29286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 02/24/11 10:21, Himanshu Chauhan wrote:
> On Thursday 24 February 2011 11:46 PM, Kevin D. Kissell wrote:
>> On 02/24/11 10:13, Himanshu Chauhan wrote:
>>> Hi,
>>>
>>> Does Linux kernel for MIPS assumes that its link address is always 
>>> in Kseg0?
>>> What if I change the link address to somewhere in useg?
>> Your page fault handlers will be in for an interesting time. ;o)
>>
>> What you describe can be, and is done, for virtualized kernels 
>> running on top
>> of a hypervisor, but there's a bit more involved than just changing 
>> the link address.
>
> You just caught that. Thats what I am trying to evaluate. What all I 
> would need to do apart from changing the link address. I am working on 
> a bare metal hypervisor for MIPS architecture.
>
> Any pointers?
>
I've done a design of something like this for a non-MIPS architecture, 
but I'd prefer someone who's done this for MIPS (and I know that there 
are people out there who have) advise you.

             Regards,

             Kevin K.
