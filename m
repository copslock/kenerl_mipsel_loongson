Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 10:48:34 +0200 (CEST)
Received: from mail-we0-f182.google.com ([74.125.82.182]:52623 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816479AbaDFIsbtnJT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 10:48:31 +0200
Received: by mail-we0-f182.google.com with SMTP id p61so5394147wes.13
        for <linux-mips@linux-mips.org>; Sun, 06 Apr 2014 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LwMTb6gX8lVMBM52uQlHqciSSVqIEEtM9wIyclWgTm8=;
        b=beOdp3OfMMvZmQoGAwIj9i6noJBTLCBsg8OdNA9vBs7mPXyAhT4DHWbXltsv809OJp
         gKLRxgLqThuZzFSO4Fqjfi/x03jn7u6PpYQe69RNWp+YRiBI/x+o6v6PHFFeDpwwwzZB
         3uX/k4EdvrsG4WaRCgU1ylRgpil5NKAU6zbXriz4CGKnXxRb5Y7bOKKQoKFduquDn4I5
         qEJ0CPxvabWEAeCQ96G1LbowRpGXzTuDsHo/fdaKUvpVYETeU1+Zcd3m2oZVw+QcPCp7
         3y7ZXEr93uxtyyM9qqcP/tGCOriej6BF1Kolh58rfVN/sLf2Cl3aQ+2gQbC+7MS1Y9GZ
         O0vQ==
X-Received: by 10.194.236.232 with SMTP id ux8mr33630259wjc.46.1396774106349;
 Sun, 06 Apr 2014 01:48:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.148.136 with HTTP; Sun, 6 Apr 2014 01:47:46 -0700 (PDT)
In-Reply-To: <CAOiHx=m-DJHgVKOGNMwePqCZMe8YnCnqjk7X-8VegUoHmXSExA@mail.gmail.com>
References: <1396738335-475011-1-git-send-email-manuel.lauss@gmail.com> <CAOiHx=m-DJHgVKOGNMwePqCZMe8YnCnqjk7X-8VegUoHmXSExA@mail.gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Sun, 6 Apr 2014 10:47:46 +0200
Message-ID: <CAOLZvyHtK8Tk1BXqC9vS2psmfbWAWivnGHzsag_XcfECt=kZFA@mail.gmail.com>
Subject: Re: [RFC PATCH] MIPS: make FPU emulator optional
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Sun, Apr 6, 2014 at 7:08 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Sun, Apr 6, 2014 at 12:52 AM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
>> Add a config option to disable the FPU emulator.
>> Saves around 56kB on 32bit, and kills FPU users with SIGILL.
>
> Looks similar to what we do in OpenWrt[1]. Main differences are we
> also stub out process_fpemu_return and emit a notice into the kernel
> log that the FPU emulator is disabled.

Does Florian have any plans to upstream it?
I kept process_fpuemu_return() because it actually emits the SIGILL I want,
and that was the quickest way to get the result I want.


>> --- a/arch/mips/Kbuild
>> +++ b/arch/mips/Kbuild
>> @@ -16,7 +16,9 @@ obj- := $(platform-)
>>
>>  obj-y += kernel/
>>  obj-y += mm/
>> +ifdef CONFIG_MIPS_FPU_EMULATOR
>>  obj-y += math-emu/
>> +endif
>
> You can write this as obj-$(CONFIG_MIPS_FPU_EMULATOR) += math-emu/

Done...


>> --- a/arch/mips/include/asm/fpu.h
>> +++ b/arch/mips/include/asm/fpu.h
>> @@ -161,7 +161,9 @@ static inline int init_fpu(void)
>>                 if (!ret)
>>                         _init_fpu();
>>         } else {
>> +#ifdef CONFIG_MIPS_FPU_EMULATOR
>>                 fpu_emulator_init_fpu();
>> +#endif
>
> Maybe do something like
>
>         } else if (IS_ENABLED(CONFIG_MIPS_FPU_EMULATOR)) {
>                fpu_emulator_init_fpu();
>
> which kooks a bit nicer IMHO.

and done.


>> --- a/arch/mips/include/asm/fpu_emulator.h
>> +++ b/arch/mips/include/asm/fpu_emulator.h
>> @@ -53,13 +53,35 @@ do {                                                                        \
[...]
>> +static inline int mm_isBranchInstr(struct pt_regs *regs,
>> +                                  struct mm_decoded_insn dec_insn,
>> +                                  unsigned long *contpc)
>> +{
>> +       return 0;
>> +}
>
> Won't this break micromips support? mm_isBranchInstr is called from a
> few other places outside the FPU emulator.

True.  I get the impression that it doesn't really belong in the fpu emu code,
it looks like generic umips support code for e.g. kernel/branch.c

Thanks!
        Mano
