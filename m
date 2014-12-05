Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 20:41:32 +0100 (CET)
Received: from mail-oi0-f51.google.com ([209.85.218.51]:51367 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008210AbaLETlTF7who (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 20:41:19 +0100
Received: by mail-oi0-f51.google.com with SMTP id e131so935776oig.24
        for <linux-mips@linux-mips.org>; Fri, 05 Dec 2014 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VVKq0RflCdmEKOboTmsPx3n9Z/NCB9ha413ChyaRSpE=;
        b=ctOfzxJm0BTv/fPEj/koSc/kJ+Pj3JzUS8prlCJqJF4vj9jeJEH39r7b+IdOtm5dVi
         oYO+p5/ouxLWydjvCTetufLUXKbk/HPSEs4J3A7LAmZZqs2wFw/mTyC54bADhb2HPuDm
         eprww8PQEHKngwPYvg0qg27qnX2SgapMPlf5jQjju+3OAncXB+/DW+wQxrTv/OuE6PMX
         N/3KVaajRY528ddFGnh7FBeMX9aGvENc4bHJCvy4sDT1tMzF21tOCDS4u3KvpkK8dGqL
         8SJ/ekf+N4f46Iduc1XozQWCUT3JsscXTpuqjmoTXSE6gaX+EQjq4xAa9FHicGW8emfD
         MNFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VVKq0RflCdmEKOboTmsPx3n9Z/NCB9ha413ChyaRSpE=;
        b=hx3Lks/Y7pd8CKEozsyfUlWp2vY/kk5XU64rCfEbRy7ugxpKyNgdCzOnXczW5cG94+
         G3nSEcC8099zWhX3Kp2AT/lO8LkjJ5tEqHXpZGqZ7c+VLYGNSO3faklxQrpy5eh0FCYj
         XrXgrRVtvVNgPoxeMyTa7xuHMVxkYMX6uEOyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VVKq0RflCdmEKOboTmsPx3n9Z/NCB9ha413ChyaRSpE=;
        b=PG0N/fMjsfHS7aNxyBbVOAX6zAq1ietfcMBJvQaZ7ctQTJ/DUqs2hfJvdZ4sQ60gpF
         s+QdaAmtRJee2C8xr30VkOjOSHU8FfWkcU/DC55DhoqU2xDDEejdHaQ5tQzJdcIA86zl
         n40c/+ytiqlOhsz4zlM6+mYP9o9+32uL0F4EbEYw6XTO2ivYHkbNb/JGQP4yZvADj+wx
         U5bnnBgHq5Jc8vVkU/D17WqGB/6lt8wu1tR/r6HmxCE8mti30iVY+PqK1W3s8mHlO8jK
         lGvETY4DKKKgh0dY/cO2OSzVOUcfH63OePVqqRJGZOpis2btvVMe9toRTh9xbir7xjWu
         DiVA==
X-Gm-Message-State: ALoCoQmoFmGIFw5W+e2GHhi1rh1RXfRrMNknT+YeGI2OTrbU+v7xIVPjkGbyWRhpypPM9QZM/MvQ
MIME-Version: 1.0
X-Received: by 10.60.99.99 with SMTP id ep3mr8537246oeb.70.1417808473142; Fri,
 05 Dec 2014 11:41:13 -0800 (PST)
Received: by 10.182.33.69 with HTTP; Fri, 5 Dec 2014 11:41:13 -0800 (PST)
In-Reply-To: <54820244.5010304@gmail.com>
References: <20141203015537.13886.50830.stgit@linux-yegoshin>
        <20141203015824.13886.74616.stgit@linux-yegoshin>
        <5481EB52.6060706@gmail.com>
        <CAGXu5jJJx0O7GhHghy+sC4fJL2O=RsO+Zgm78r9SNt-aTbhqcw@mail.gmail.com>
        <54820244.5010304@gmail.com>
Date:   Fri, 5 Dec 2014 11:41:13 -0800
X-Google-Sender-Auth: 9zHzHXE-bX1kiOh0FK8sFQi1a5c
Message-ID: <CAGXu5jJOCfXXMPYsWbp0wzF_PvTTKrcuy3=cSa0bCEn01M56dA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] MIPS: set stack/data protection as non-executable
From:   Kees Cook <keescook@chromium.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Zubair.Kakakhel@imgtec.com, geert+renesas@glider.be,
        david.daney@cavium.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        davidlohr@hp.com, "Maciej W. Rozycki" <macro@linux-mips.org>,
        chenhc@lemote.com, cl@linux.com, Ingo Molnar <mingo@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Tejun Heo <tj@kernel.org>, alex@alex-smith.me.uk,
        Paolo Bonzini <pbonzini@redhat.com>,
        John Crispin <blogic@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>, qais.yousef@imgtec.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        lars.persson@axis.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Fri, Dec 5, 2014 at 11:06 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 12/05/2014 10:51 AM, Kees Cook wrote:
>>
>> On Fri, Dec 5, 2014 at 9:28 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>>>
>>> On 12/02/2014 05:58 PM, Leonid Yegoshin wrote:
>>>>
>>>>
>>>> This is a last step of 3 patches which shift FPU emulation out of
>>>> stack into protected area. So, it disables a default executable stack.
>>>>
>>>> Additionally, it sets a default data area non-executable protection.
>>>>
>>>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>>
>>>
>>>
>>> NAK!
>>>
>>> Some programs require an executable stack, this patch will break them.
>>
>> Have you tested this?
>
> Do you require empirical evidence that the patch is incorrect, or is it
> enough to just to trust me when I say that it is incorrect?  Typically the
> burden of proof is with those proposing the patches.

My fault, I misunderstood. (See below.)

>>> You can only select a non-executable stack in response to PT_GNU_STACK
>>> program headers in the ELF file of the executable program.
>>
>>
>> This is already handled by fs/binfmt_elf.c. It does the parsing of the
>> PT_GNU_STACK needs, and sets up the stack flags appropriately. All the
>> change to VM_DATA_DEFAULT_FLAGS does is make sure that EXSTACK_DEFAULT
>> now means no VM_EXEC by default. If PT_GNU_STACK requires it, it gets
>> added back in.
>>
>
> The problem is not with "modern" executables that are properly annotated
> with PT_GNU_STACK.
>
> My objection is to the intentional breaking of old executables that have no
> PT_GNU_STACK annotation, but require an executable stack.  Since we usually
> try not to break userspace, we cannot merge a patch like this one.

Ah! Okay. If legacy executables expected an executable stack for more
reasons than FPU emulation, then yes, absolutely I agree with you.

-Kees

>
> David Daney.
>
>
>
>> -Kees
>>
>>>
>>> David Daney
>>>
>>>
>>>
>>>> ---
>>>>    arch/mips/include/asm/page.h |    2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
>>>> index 3be81803595d..d49ba81cb4ed 100644
>>>> --- a/arch/mips/include/asm/page.h
>>>> +++ b/arch/mips/include/asm/page.h
>>>> @@ -230,7 +230,7 @@ extern int __virt_addr_valid(const volatile void
>>>> *kaddr);
>>>>    #define virt_addr_valid(kaddr)
>>>> \
>>>>          __virt_addr_valid((const volatile void *) (kaddr))
>>>>
>>>> -#define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | VM_EXEC | \
>>>> +#define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | \
>>>>                                   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>>>>
>>>>    #define UNCAC_ADDR(addr)      ((addr) - PAGE_OFFSET + UNCAC_BASE)
>>>>
>>>>
>>>>
>>>>
>>>
>>
>>
>>
>



-- 
Kees Cook
Chrome OS Security
