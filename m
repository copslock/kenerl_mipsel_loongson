Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 17:27:02 +0200 (CEST)
Received: from gateway06.websitewelcome.com ([69.93.164.14]:32940 "HELO
        gateway06.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492874Ab0HDP06 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Aug 2010 17:26:58 +0200
Received: (qmail 29477 invoked from network); 4 Aug 2010 15:37:17 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway06.websitewelcome.com with SMTP; 4 Aug 2010 15:37:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=HRDlOVT2Auv51Zu/kp+GTcvzZWdMmxFTBKhWFkbPd7ega3N5LQJo7s0Bo7uzvnWh1y9fUBk9anfumSq7/tguvrC6AVIij+6b0QPm5PQUis3BeMl1P1cHlVEi8RvWtRHU;
Received: from [216.239.45.4] (port=60682 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1Ogfrm-0003RN-CK; Wed, 04 Aug 2010 10:26:51 -0500
Message-ID: <4C5986BC.9000307@paralogos.com>
Date:   Wed, 04 Aug 2010 08:26:52 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [Q] enabling FPU for vpe1
References: <AANLkTinCjSTE7sYa7JdqwAEe-4nZJKAvVfg5q4YVVqC7@mail.gmail.com>      <4C592027.8010902@paralogos.com> <AANLkTinVxFnNzQaHUCqxTQk708MEuUAiEuRGGPN8WcuS@mail.gmail.com>
In-Reply-To: <AANLkTinVxFnNzQaHUCqxTQk708MEuUAiEuRGGPN8WcuS@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

You can only set the TC's CU bits if the VPE to which the TC is bound 
has access to the coprocessor.  See sections 8.2 andf 6.7 of the 
currently online spec, and read the MIPS MT Principles of Operation 
document, if you can find it.

On 08/04/10 03:14, Deng-Cheng Zhu wrote:
> Thanks for looking into this.
>
> I did do that. But the CU1 bit of TC#1 (in VPE#1) can not be set by
> TC#0 or itself. Looks like VPE#1 is not seeing the FPU at all...
>
>
> Deng-Cheng
>
>
> 2010/8/4 Kevin D. Kissell<kevink@paralogos.com>:
>    
>> Check the MIPS MT spec.  If I recall correctly, it's possible to enable
>> access to the FPU by either VPE by setting the right bits while the
>> processor is in the MT configuration mode.
>>
>> Deng-Cheng Zhu wrote:
>>      
>>> Hi,
>>>
>>>
>>> I'm working on a 34Kf CPU. I understand that only one TC can use the
>>> FPU at any given time.
>>>
>>> My question is: If a TC is attached to the 2nd VPE (i.e. VPE1), can I
>>> enable FPU for it?
>>>
>>> I experimented on this, but failed to do it. Am I missing something?
>>>
>>>
>>> Thanks
>>>
>>> Deng-Cheng
>>>
>>>
>>>        
>>
>>      
