Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2011 18:38:33 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:55810 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491131Ab1GAQi3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2011 18:38:29 +0200
Received: by iyn15 with SMTP id 15so3621623iyn.36
        for <multiple recipients>; Fri, 01 Jul 2011 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=G3qdoLXXYsZfcnccEWUXUicBs/Y+DKY9dYcD70Z14po=;
        b=qGHrpsSchskvTzE20VTfiuT3erD0+Cf5CLpTg611zNgQTPVO1rnWBMCBsezaq95hZJ
         C4f5FzSS2iOr9Vg5+U//40zA/M+hZHHQTD0Js3KjkoZeLwsXuW9l+3v8SGwxN/XpuUpH
         ZL5PEconH/ShbeImvj7T5oI8A04cvfmbR8ouE=
Received: by 10.42.117.134 with SMTP id t6mr3678241icq.458.1309538302731;
        Fri, 01 Jul 2011 09:38:22 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-56-230.dsl.pltn13.pacbell.net [67.127.56.230])
        by mx.google.com with ESMTPS id vn4sm3492245icb.19.2011.07.01.09.38.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 09:38:21 -0700 (PDT)
Message-ID: <4E0DF7FC.7010007@gmail.com>
Date:   Fri, 01 Jul 2011 09:38:20 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc13 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Close races in TLB modify handlers.
References: <1309473062-11041-1-git-send-email-david.daney@cavium.com> <alpine.LFD.2.00.1106302358550.29709@eddie.linux-mips.org> <4E0D0D8C.7000200@cavium.com> <20110701082706.GA8308@linux-mips.org>
In-Reply-To: <20110701082706.GA8308@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 791

On 07/01/2011 01:27 AM, Ralf Baechle wrote:
> On Thu, Jun 30, 2011 at 04:58:04PM -0700, David Daney wrote:
>
>> On 06/30/2011 04:34 PM, Maciej W. Rozycki wrote:
>>> Hi David,
>>>
>>>> Page table entries are made invalid by writing a zero into the the PTE
>>>> slot in a page table.  This creates a race condition with the TLB
>>>> modify handlers when they are updating the PTE.
>>>>
>>>> CPU0                              CPU1
>>>>
>>>> Test for _PAGE_PRESENT
>>>> .                                 set to not _PAGE_PRESENT (zero)
>>>> Set to _PAGE_VALID
>>>>
>>>> So now the page not present value (zero) is suddenly valid and user
>>>> space programs have access to physical page zero.
>>>>
>>>> We close the race by putting the test for _PAGE_PRESENT and setting of
>>>> _PAGE_VALID into an atomic LL/SC section.  This requires more
>>>> registers than just K0 and K1 in the handlers, so we need to save some
>>>> registers to a save area and then restore them when we are done.
>>>   Hmm, good catch, but doesn't your change pessimise the UP case?
>> It may, It is really just a first version of the patch.  I am
>> looking for feedback and testing.
>>
>>> It looks
>>> to me like you save&   restore the scratch registers even though the race
>>> does not apply to UP (you can't interrupt a TLB handler, not at this
>>> stage).
>> That's right.  I will look at trying to generate the old code
>> sequences for non-SMP.
> We can replace all the CONFIG_SMPs in tlbex.c (existing and those added
> by your patch) with num_possible_cpus>  1 which will improve readability
> and give SMP kernels running on a single processor the uniprocessor TLB
> exception handler.
>
> But that's something for a followup patch; your patch is big enough as it
> is, it's not as straight forward as it may sound and the 3.0 clock is
> ticking ...

I am testing a slight revision (using Context/XContext to get the 
logical CPU number instead of physical CPU number from EBase).  I will 
not send this revision until Tuesday because we are on holiday until then.

David Daney
