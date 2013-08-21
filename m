Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 18:00:33 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56607 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6852073Ab3HUQAatanpf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 18:00:30 +0200
Received: by mail-pa0-f52.google.com with SMTP id kq13so976136pab.11
        for <multiple recipients>; Wed, 21 Aug 2013 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Sk5M2QTkoXPtTMB8gFQ/Y4b6ZG7uL7EpWm7zbFcOzPc=;
        b=w5m49UTriZ9zsrpAkkSsdPrWGyNEoOOMLZpZAXmT7RFGbGlaMzaWEHOVQ5zc6pVAOh
         HfLWeYzFJBiYycP8A/o4bOEJKgrYA1f1dJgrJXnDCiM3+TlEV8QFnuZntPTQxNvm8ZAy
         8rkhWjHNokZtTdbp9/vJKLYklOed5TUq3/gwUigcyh9Ey/shGIzaIqvYzSurSwy5odMJ
         AKlW4sZQ7eSTkde4Pp/zPZKpuy6fa9p81T9BK7AB5Andj3TGmVH+SPzuPcVoVfRl/c7z
         kz6qeRL93AW7MkMH3WC3GoOAkMAdVVcCf9pyrU5CqrulReIuj9M8rNcdOuVNDONuUawV
         G88A==
X-Received: by 10.68.219.104 with SMTP id pn8mr462315pbc.81.1377100824401;
 Wed, 21 Aug 2013 09:00:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.41.193 with HTTP; Wed, 21 Aug 2013 08:59:44 -0700 (PDT)
In-Reply-To: <5214E05E.7000303@imgtec.com>
References: <1377096947-3959-1-git-send-email-james.hogan@imgtec.com>
 <CAGVrzcZ8FVv9p00R6yDaqRMQARi64P+zVzNRsyeGpiL4UZL3Vg@mail.gmail.com> <5214E05E.7000303@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed, 21 Aug 2013 16:59:44 +0100
Message-ID: <CAGVrzcbTuD8ArZ9eN3heN9Xv9b4q7C0_a0o7kAM0sWEy2RQ_og@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add uImage build target
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hello James,

2013/8/21 James Hogan <james.hogan@imgtec.com>:
> Hi Florian,
>
> On 21/08/13 16:08, Florian Fainelli wrote:
>> 2013/8/21 James Hogan <james.hogan@imgtec.com>:
>>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>>> index b2be6b8..c4f339e 100644
>>> --- a/arch/mips/Makefile
>>> +++ b/arch/mips/Makefile
>>> @@ -284,7 +284,7 @@ vmlinux.64: vmlinux
>>>  all:   $(all-y)
>>>
>>>  # boot
>>> -vmlinux.bin vmlinux.ecoff vmlinux.srec: $(vmlinux-32) FORCE
>>> +vmlinux.bin vmlinux.ecoff vmlinux.srec uImage: $(vmlinux-32) FORCE
>>>         $(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
>>>
>>>  # boot/compressed
>>> @@ -327,6 +327,7 @@ define archhelp
>>>         echo '  vmlinuz.ecoff        - ECOFF zboot image'
>>>         echo '  vmlinuz.bin          - Raw binary zboot image'
>>>         echo '  vmlinuz.srec         - SREC zboot image'
>>> +       echo '  uImage               - U-Boot image (gzip)'
>>
>> This is not quite accurate, since you introduce two new uImage
>> targets, this should be:
>>
>> +       echo '  uImage               - U-Boot image'
>> +       echo '  uImage.gz               - U-Boot image (gzip)'
>
> Only uImage is passed through to arch/mips/boot/Makefile, but yes, they
> probably both should be.
>
>>
>>>         echo
>>>         echo '  These will be default as appropriate for a configured platform.'
>>>  endef
>>> diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
>>> index f210b09..a73d6e2 100644
>>> --- a/arch/mips/boot/.gitignore
>>> +++ b/arch/mips/boot/.gitignore
>>> @@ -4,3 +4,4 @@ vmlinux.*
>>>  zImage
>>>  zImage.tmp
>>>  calc_vmlinuz_load_addr
>>> +uImage
>>> diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
>>> index 851261e..8169d42 100644
>>> --- a/arch/mips/boot/Makefile
>>> +++ b/arch/mips/boot/Makefile
>>> @@ -40,3 +40,18 @@ quiet_cmd_srec = OBJCOPY $@
>>>        cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $@
>>>  $(obj)/vmlinux.srec: $(VMLINUX) FORCE
>>>         $(call if_changed,srec)
>>> +
>>> +UIMAGE_LOADADDR  = $(shell $(NM) $(VMLINUX) | grep "\b_text\b"        | cut -f1 -d\ )
>>
>> Is not VMLINUX_LOAD_ADDRESS suitable here?
>
> It's only passed through to arch/mips/boot/compressed. It can always be
> made to pass it to arch/mips/boot too though.

Right, in your case $(load-y) should do it.

>
>>
>>> +UIMAGE_ENTRYADDR = $(shell $(NM) $(VMLINUX) | grep '\bkernel_entry\b' | cut -f1 -d\ )
>>
>> This logic already exists in arch/mips/boot/compressed/Makefile, so we
>> might want to move this to arch/mips/Makefile? This could be a
>> preliminary or subsequent patch, your call.
>
> Thanks for the feedback. I'll refactor it a bit to avoid duplication.

Great, thanks!
-- 
Florian
