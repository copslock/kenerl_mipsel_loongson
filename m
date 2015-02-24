Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 00:58:24 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:44240 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006911AbbBXX6XGXG1b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 00:58:23 +0100
Received: by iecar1 with SMTP id ar1so496357iec.11;
        Tue, 24 Feb 2015 15:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=A6gfNQVOYbVIEo+DkRAb6wrmaM5TB3CB+FcB7MLfESk=;
        b=E9CDJ70GW5sMRGRZIHS0K3mKbH/GFRYwqrINtszxNFPjpVN3uHHPBWYY80SH4PyrzA
         P5OXgfrDp+hIc2A0309vUFWupUuNgZ/yIiaE0EprhHJDoTQnlpoxOWVXn/L/4ki3dbhI
         Y1RvUQZ4woYXGdwurXVJVhKuoWVrpj25EtIn9CSgvwe9FdNkXqbhR/gRjOmADoVVxU1E
         o32FQHHGLzDIuSWazZXiZzcIN2xgI1G0qVkrpXCFrqERIeNklI4k3Lu/IALYDt79DAuY
         55ICqO3ZGBBsWNC29O1ry3o4XJQruGm9Tg4DVG3z/sF5N+Ib/vE+l0Vy7LuVD4MUWa1W
         SlTg==
X-Received: by 10.50.30.202 with SMTP id u10mr23414896igh.35.1424822297603;
        Tue, 24 Feb 2015 15:58:17 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id c4sm8795126igt.19.2015.02.24.15.58.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 15:58:16 -0800 (PST)
Message-ID: <54ED1017.305@gmail.com>
Date:   Tue, 24 Feb 2015 15:58:15 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Zenon Fortuna <zenon.fortuna@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with non-DMA
 I/O.
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com> <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org> <54ECE7CE.4040407@imgtec.com> <alpine.LFD.2.11.1502242140220.17311@eddie.linux-mips.org> <54ECF3E6.9080606@imgtec.com> <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org> <54ED01F5.8040409@gmail.com> <54ED06F4.8020607@imgtec.com>
In-Reply-To: <54ED06F4.8020607@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45944
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

On 02/24/2015 03:19 PM, Leonid Yegoshin wrote:
> On 02/24/2015 02:57 PM, David Daney wrote:
>> On 02/24/2015 02:50 PM, Maciej W. Rozycki wrote:
>>> On Tue, 24 Feb 2015, Leonid Yegoshin wrote:
>>>
>>>>>    For simplicity perhaps on SMP we should just always use hit
>>>>> operations
>>>>> regardless of the size requested.
>>>>
>>>> High performance folks may not like doing a lot of stuff for 8MB VMA
>>>> release
>>>> instead of flushing 64KB.
>>>
>>>   What kind of a use case is that, what does it do?
>>>
>>>> Especially taking into account TLB exceptions and postprocessing in
>>>> fixup_exception() for swapped-out/not-yet-loaded-ELF blocks.
>>>
>>>   The normal use for cacheflush(2) I know of is for self-modifying or
>>> other
>>> run-time-generated code, to synchronise caches after a block of machine
>>> code has been patched in -- SYNCI can also be used for that purpose
>>> these
>>> days,
>>
>> SYNCI is only useful in non-SMP kernels.
> Yes, until MIPS R6. I pressed hard on Arch team to change vague words in
> SYNCI description and now (MIPS R6) it has words requiring execution on
> all cores:
>
>> "SYNCI globalization:
>> Release 6: SYNCI globalization (as described below) is required:
>> compliant implementations must globalize SYNCI.
>> Portable software can rely on this behavior, and use SYNCI rather than
>> expensive “instruction cache shootdown”
>> using inter-processor interrupts."

Wow.  I guess implementing -msynci wasn't a complete waste of time after 
all.

In any event, it is irrelevant with respect to the semantics of 
cacheflush(2), which still must be properly implemented.

David Daney
