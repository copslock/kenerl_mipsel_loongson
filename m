Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 17:27:43 +0100 (CET)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:60551 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012590AbbBEQ1lggJwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 17:27:41 +0100
Received: by mail-ig0-f174.google.com with SMTP id b16so44916146igk.1;
        Thu, 05 Feb 2015 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=le3TWNL4up56lfGauYKyBN9xHpGwBDgbEB07qlw6xeY=;
        b=Pby/JX9SKqYm36kZ1aXJDyW8Q7MXEHZYoFBZdPOeRciCgnugudTiyqN9o8fEwrv2o0
         XiNwgPgKuXOtanUJnavqCDEwFilcZngPr6q/vLI27KrxqblmLlvhVeGZiXEFOf5yvQmT
         GoD7r04xa66pJGSh9fsdfp/P8ibjCkPNDmtRltOONKTStlzxjKAOdpZSMjm7AhrOr3lk
         iCd6hZuRVBz9sElFUoYyiYSZElbz4aKVL2vWQUj4vxSRfL7LYMBV6YRIlG4KjZ3mBrKQ
         GRnpjkPA2p1cGXFQJJZHG6r4pFhndXCk910Kh2ZEUEP+yBGgkxy/qXtsxmIdbOYRvkww
         uX5w==
X-Received: by 10.50.83.10 with SMTP id m10mr31573915igy.23.1423153655654;
        Thu, 05 Feb 2015 08:27:35 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id k18sm11381384igt.5.2015.02.05.08.27.34
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Feb 2015 08:27:35 -0800 (PST)
Message-ID: <54D399F5.5030402@gmail.com>
Date:   Thu, 05 Feb 2015 08:27:33 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org> <54C68429.4030701@gmail.com> <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org> <54C69FCE.80002@gmail.com> <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org> <54C7ED94.6070507@gmail.com> <alpine.LFD.2.11.1501272231190.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501272231190.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 02/05/2015 05:46 AM, Maciej W. Rozycki wrote:
> On Tue, 27 Jan 2015, David Daney wrote:
>
>>>> It is bizarre, and perhaps almost mind bending, but that seems to be how
>>>> it is
>>>> specified.  Certainly the OCTEON implementation works this way.
>>>
>>>    Well, I think this observation:
>>>
>>> "2.2.2.2 Memory Operation Functions
>>>
>>> "Regardless of byte ordering (big- or little-endian), the address of a
>>> halfword, word, or doubleword is the smallest byte address of the bytes
>>> that form the object.  For big-endian ordering this is the
>>> most-significant byte; for a little-endian ordering this is the
>>> least-significant byte."
>>>
>>> contradicts your claim [...]
>>
>> One can argue about the meaning of the text in the reference manual. But in
>> the end, the behavior of real processors is what we are forced to deal with.
>>
>> In the case of all existing OCTEON processors, there is no Status[RE] bit, but
>> you can switch the endianess of the entire CPU under software control.  I am
>> really making statements based on how they actually work, not assertions about
>> the meaning of the specification.  However, I do believe that this is what is
>> specified.
>>
>> If you have access to processors with a working Status[RE] bit, you could
>> empirically determine how they work.
>
>   Well, I do actually, I have a working machine driven by an R4000
> processor.  It was the original implementation of the Status.RE feature
> and therefore it can be used as the reference.  I don't feel tempted to
> use my time to actually make any checks though.
>
>   What I did instead, I checked the R4000 manual  ...

You are still relying on your interpretation of the text, rather than 
actual behavior of the device.  It is not all surprising that your 
interpretation of the manual hasn't changed, but it doesn't persuade me.

I am sticking to my belief that OCTEON faithfully implements the 
specification with respect to the in-memory byte ordering of the various 
load and store instructions.  Switching the endianess of the processor 
results in byte arrays being scrambled such that the low-order 3 bits 
are XOR 7.  This implies that aligned 64-bit loads and stores (LD, SD, 
LLC, SCD) result in identical in-memory and in-register layout for 
either endianess.  This is quite handy when writing driver code for 
devices that have 64-bit registers.

[...]

David Daney
