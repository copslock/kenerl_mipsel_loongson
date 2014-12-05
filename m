Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 20:06:55 +0100 (CET)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:51181 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008206AbaLETGx3efgJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 20:06:53 +0100
Received: by mail-ie0-f180.google.com with SMTP id rp18so1287921iec.39
        for <multiple recipients>; Fri, 05 Dec 2014 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6PMojiU17R6rRaJnppj3u0hmTagrskgTWHx1Kkqffe8=;
        b=UiU/qBDvNgqdBkT29Bl+J+OT0rCda/f7Fug18G53y6SnRgvvxYU5gAmpH8JBYYZZMz
         irbf8ISHBvlP0fOhgf1/pagu21eybeeBlmS2Q2oWuM0SV2jJBjmrmI1+MquMx4GsaHfL
         G1aWhJb+jNo2zwJT8GhTED9hwS8r01tgbo3SkeDcehuKb2dFQq0/t3m46k6fIcSkDPr9
         R0FVAfNX0L/qVtlKqJog50VJBrfsw3WNybXJBOvZvVFeyzi1YYJSjxQo1g+4r25zGHji
         vyT5QrwJr8GpBfivNAtdynnz08ewcBCswpfGQqTpC2OYluzC/yv9F5fSGxmnNT1G/zLz
         2bUg==
X-Received: by 10.107.130.30 with SMTP id e30mr16117822iod.87.1417806407425;
        Fri, 05 Dec 2014 11:06:47 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 39sm13265205ioi.7.2014.12.05.11.06.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 11:06:46 -0800 (PST)
Message-ID: <54820244.5010304@gmail.com>
Date:   Fri, 05 Dec 2014 11:06:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
Subject: Re: [PATCH v3 3/3] MIPS: set stack/data protection as non-executable
References: <20141203015537.13886.50830.stgit@linux-yegoshin> <20141203015824.13886.74616.stgit@linux-yegoshin> <5481EB52.6060706@gmail.com> <CAGXu5jJJx0O7GhHghy+sC4fJL2O=RsO+Zgm78r9SNt-aTbhqcw@mail.gmail.com>
In-Reply-To: <CAGXu5jJJx0O7GhHghy+sC4fJL2O=RsO+Zgm78r9SNt-aTbhqcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44587
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

On 12/05/2014 10:51 AM, Kees Cook wrote:
> On Fri, Dec 5, 2014 at 9:28 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>> On 12/02/2014 05:58 PM, Leonid Yegoshin wrote:
>>>
>>> This is a last step of 3 patches which shift FPU emulation out of
>>> stack into protected area. So, it disables a default executable stack.
>>>
>>> Additionally, it sets a default data area non-executable protection.
>>>
>>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>>
>> NAK!
>>
>> Some programs require an executable stack, this patch will break them.
>
> Have you tested this?

Do you require empirical evidence that the patch is incorrect, or is it 
enough to just to trust me when I say that it is incorrect?  Typically 
the burden of proof is with those proposing the patches.

>
>> You can only select a non-executable stack in response to PT_GNU_STACK
>> program headers in the ELF file of the executable program.
>
> This is already handled by fs/binfmt_elf.c. It does the parsing of the
> PT_GNU_STACK needs, and sets up the stack flags appropriately. All the
> change to VM_DATA_DEFAULT_FLAGS does is make sure that EXSTACK_DEFAULT
> now means no VM_EXEC by default. If PT_GNU_STACK requires it, it gets
> added back in.
>

The problem is not with "modern" executables that are properly annotated 
with PT_GNU_STACK.

My objection is to the intentional breaking of old executables that have 
no PT_GNU_STACK annotation, but require an executable stack.  Since we 
usually try not to break userspace, we cannot merge a patch like this one.

David Daney.


> -Kees
>
>>
>> David Daney
>>
>>
>>
>>> ---
>>>    arch/mips/include/asm/page.h |    2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
>>> index 3be81803595d..d49ba81cb4ed 100644
>>> --- a/arch/mips/include/asm/page.h
>>> +++ b/arch/mips/include/asm/page.h
>>> @@ -230,7 +230,7 @@ extern int __virt_addr_valid(const volatile void
>>> *kaddr);
>>>    #define virt_addr_valid(kaddr)
>>> \
>>>          __virt_addr_valid((const volatile void *) (kaddr))
>>>
>>> -#define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | VM_EXEC | \
>>> +#define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | \
>>>                                   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>>>
>>>    #define UNCAC_ADDR(addr)      ((addr) - PAGE_OFFSET + UNCAC_BASE)
>>>
>>>
>>>
>>>
>>
>
>
>
