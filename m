Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 19:51:27 +0100 (CET)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:63651 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008221AbaLESvWMcRo0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 19:51:22 +0100
Received: by mail-ob0-f173.google.com with SMTP id uy5so984189obc.4
        for <linux-mips@linux-mips.org>; Fri, 05 Dec 2014 10:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pO252tJ6cN78/4GALesjtaIRiaNkU4jl85no5JpPOJI=;
        b=K/IdszfnS95+7ZBOPLCoXdrQpahS28FmYbnGozKcru+DI5PQ4ScJRq9YWXi7BC2fst
         BVN1Rn5O71SNwK1lRm8/l3/QpI1QngzsHWXffDnHf1YOBwO/lqiRz/WcD9/wORVza3jy
         yqUO6H8FQo2QJSBQxiDDeqv8u6Fd/9i3UAs0FpbCMcRfzhJPx6AWKnPbxCiyFTR2LIgU
         EfI+z6oBbBMY/WJmX6W7b3+FnuPffVywMNeY+5cqj4K7xeupNQFtSo6JlIc3uWANLUEM
         CysDx2U08NOtgdA/FJQlHwxXecmRpjiFDh6sUsyTKtDo2/swNsDcO/Scp4jbq6dzvaIT
         XJlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pO252tJ6cN78/4GALesjtaIRiaNkU4jl85no5JpPOJI=;
        b=Ynx1YFcSRRzpqmTTtVSNNABHGCZSbHkRZ8vmSE0z26qE0VZ08J06np7juFly56D3oX
         8IXZG78akvHBTGNoCtce0cgw5Np2kGDaWQ7hhRQqhA5PnM81ch3ANrER1yvUfpwiflKz
         5Kae0VnCGESLJEg1BF7BIBnVmjWvN4cyT3c+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pO252tJ6cN78/4GALesjtaIRiaNkU4jl85no5JpPOJI=;
        b=k4rGPFLomlBRb33lplG2rJdxDW/OMdMBqMEG8GUVHgfgTh7IGfhdd739JThyaIj+YA
         zjecTj7RuDvxIJpJEFwrRbslQs/UX34zBzGgPRF+O1oCX6OYDpNtxvXYhVkN0IaXy5WZ
         PxbNSkvkC6x5H9kOucfJzJ8mkqtZgX3XeaZ/G++eLcLtty2CxbQ9N4GujiTEdt+n66em
         SNkJuzfsgzEosjz26LoPfcMB+ZxjAcai2hv1iTzrinJsocNkO+sCPZHlni0GimKUC42Y
         3eC6zSNxpuaii6qsH4sIuspWJYxrBNUGyWkfkprm2pL626/DeOQasFrWBoekdw5+h7kZ
         7QJg==
X-Gm-Message-State: ALoCoQnnpzFv+TZp5pa0q6CaI36gCEILp08X6bROcakAn2SZgEMsZr3GV6oOHEwndnqCJLDFKwS3
MIME-Version: 1.0
X-Received: by 10.202.200.143 with SMTP id y137mr10975888oif.38.1417805476059;
 Fri, 05 Dec 2014 10:51:16 -0800 (PST)
Received: by 10.182.33.69 with HTTP; Fri, 5 Dec 2014 10:51:15 -0800 (PST)
In-Reply-To: <5481EB52.6060706@gmail.com>
References: <20141203015537.13886.50830.stgit@linux-yegoshin>
        <20141203015824.13886.74616.stgit@linux-yegoshin>
        <5481EB52.6060706@gmail.com>
Date:   Fri, 5 Dec 2014 10:51:15 -0800
X-Google-Sender-Auth: 1BTdWi0hR1syVSk-T-Cz5N7FCQY
Message-ID: <CAGXu5jJJx0O7GhHghy+sC4fJL2O=RsO+Zgm78r9SNt-aTbhqcw@mail.gmail.com>
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
X-archive-position: 44586
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

On Fri, Dec 5, 2014 at 9:28 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 12/02/2014 05:58 PM, Leonid Yegoshin wrote:
>>
>> This is a last step of 3 patches which shift FPU emulation out of
>> stack into protected area. So, it disables a default executable stack.
>>
>> Additionally, it sets a default data area non-executable protection.
>>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
>
> NAK!
>
> Some programs require an executable stack, this patch will break them.

Have you tested this?

> You can only select a non-executable stack in response to PT_GNU_STACK
> program headers in the ELF file of the executable program.

This is already handled by fs/binfmt_elf.c. It does the parsing of the
PT_GNU_STACK needs, and sets up the stack flags appropriately. All the
change to VM_DATA_DEFAULT_FLAGS does is make sure that EXSTACK_DEFAULT
now means no VM_EXEC by default. If PT_GNU_STACK requires it, it gets
added back in.

-Kees

>
> David Daney
>
>
>
>> ---
>>   arch/mips/include/asm/page.h |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
>> index 3be81803595d..d49ba81cb4ed 100644
>> --- a/arch/mips/include/asm/page.h
>> +++ b/arch/mips/include/asm/page.h
>> @@ -230,7 +230,7 @@ extern int __virt_addr_valid(const volatile void
>> *kaddr);
>>   #define virt_addr_valid(kaddr)
>> \
>>         __virt_addr_valid((const volatile void *) (kaddr))
>>
>> -#define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | VM_EXEC | \
>> +#define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | \
>>                                  VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>>
>>   #define UNCAC_ADDR(addr)      ((addr) - PAGE_OFFSET + UNCAC_BASE)
>>
>>
>>
>>
>



-- 
Kees Cook
Chrome OS Security
