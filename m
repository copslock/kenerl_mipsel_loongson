Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:58:47 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37013 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009080AbaLTB6mqizQX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:58:42 +0100
Received: by mail-ie0-f169.google.com with SMTP id y20so1783123ier.14;
        Fri, 19 Dec 2014 17:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sIaw783zwaz8CEV5LChadXUjFzkrJxDmtyv1dcOJJYc=;
        b=PeG0fL+3fDnwa80NDGxJkSkFpFuXXHJ8F5UNJE++uNUWGI7zbCjBoCqNnNdXURbn/H
         A1WVpU7tRuGOeC7kiicXbD2NBCDpU3EhmdFsXFrCCjBqDip1AN/xg6ME8eqDrivN/Rhn
         F2SEn56u8z9HRPfoEyc/Bf88g+f3M3sIkxY3IQfEW7FkQ0lwG/nYgVzgZsk/PlbO6850
         TjcYACGLvFkhS+CJqgB8x6j2OBWRz5LX/Io8M+eiRxBVPRx7AKZyi0YLXrVaRKEc2l4w
         XKYq7AdLmj4sha2nc/Jmo0jAcQTAx9DGJNPcI2GwUQR/G1mSSftIQRynwGlqTBSXgcZl
         2TsA==
MIME-Version: 1.0
X-Received: by 10.51.16.37 with SMTP id ft5mr6215275igd.6.1419040717232; Fri,
 19 Dec 2014 17:58:37 -0800 (PST)
Received: by 10.64.133.11 with HTTP; Fri, 19 Dec 2014 17:58:37 -0800 (PST)
In-Reply-To: <20141219150221.GK14160@linux-mips.org>
References: <1418999184-10216-1-git-send-email-chenhc@lemote.com>
        <20141219150221.GK14160@linux-mips.org>
Date:   Sat, 20 Dec 2014 09:58:37 +0800
X-Google-Sender-Auth: 3Ytbxc8up9praDRoJY3pJ364xdg
Message-ID: <CAAhV-H7qXOPDhOoRwERG6K5PR-QJs7cyQxvsET2zfn9zQiNsEA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Hibernate: flush TLB entries earlier
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

Maybe it is better to have two patches: the first fix the bug, and the
second restructure files and functions?

Huacai

On Fri, Dec 19, 2014 at 11:02 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Dec 19, 2014 at 10:26:24PM +0800, Huacai Chen wrote:
>
>> We found that TLB mismatch not only happens after kernel resume, but
>> also happens during snapshot restore. So move it to the beginning of
>> swsusp_arch_suspend().
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/power/hibernate.S |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
>> index 32a7c82..e7567c8 100644
>> --- a/arch/mips/power/hibernate.S
>> +++ b/arch/mips/power/hibernate.S
>> @@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
>>  END(swsusp_arch_suspend)
>>
>>  LEAF(swsusp_arch_resume)
>> +     /* Avoid TLB mismatch during and after kernel resume */
>> +     jal local_flush_tlb_all
>
> I'd like to keep the assembler code to a minimum.  Can you rename
> swsusp_arch_resume and create a new wrapper function in C named
> swsusp_arch_resume() which calls the old swsusp_arch_resume() after
> calling local_flush_tlb_all(), something like that?
>
> Thanks,
>
>   Ralf
>
