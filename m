Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:35:57 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34701 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820489AbaDHLfxRBq3Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:35:53 +0200
Received: by mail-wi0-f180.google.com with SMTP id q5so1154423wiv.7
        for <linux-mips@linux-mips.org>; Tue, 08 Apr 2014 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YQ63f4Grf3blp0+QPmxJtdM4cf8rpF3h2mf5CUrcUAU=;
        b=Yh4xlXDYC4CDAvv+DC/3Yl13WVEsdaY3TVeaspjlrw1eNDN/LhbcMMVDydDnzYAUuE
         HuVOCT6Wx5SHUvWAvckA29d2HJP8YJmMrwV5HaTl0rdLxP6iHPOYsT3czToj2QrlUx7j
         M5QKUY7yyflsOMSG2ah/k5JgXLUytI75bMaVCzQCDYmc7JJoBm/iLhz4QGN+xIoLbhKH
         aX9S6+bQZeytDi6ett1FsFVXp5tdNuMmenj2oPT1NYQ0w+F9QG3IRxALCXMoTf/DDV00
         FpkGE1l5eOrt1N1bptHTdQ0MaFX3O96DkLnJcDHpOYTHMTf8hUKxxpAfU+QvS2S0Ifan
         6W8A==
X-Received: by 10.194.90.107 with SMTP id bv11mr3275497wjb.11.1396956946422;
 Tue, 08 Apr 2014 04:35:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.148.136 with HTTP; Tue, 8 Apr 2014 04:35:06 -0700 (PDT)
In-Reply-To: <CAOiHx=mQkpFn-Ys2hpDY1DGMLA9zTCoUC2ixRBqwg7i7n-t8vg@mail.gmail.com>
References: <1396954444-392675-1-git-send-email-manuel.lauss@gmail.com>
 <1396954444-392675-2-git-send-email-manuel.lauss@gmail.com> <CAOiHx=mQkpFn-Ys2hpDY1DGMLA9zTCoUC2ixRBqwg7i7n-t8vg@mail.gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Tue, 8 Apr 2014 13:35:06 +0200
Message-ID: <CAOLZvyFLFT8fr-LGWyK2tM53yAKQvwFtiU1_+Kev6zg_uq76mQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] MIPS: optional floating point support
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39704
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

On Tue, Apr 8, 2014 at 1:14 PM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Tue, Apr 8, 2014 at 12:54 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
>> This small patch makes the floating point support and the FPU-emulator
>> optional.  A Warning will be printed once when first use of floating
>> point is detected.
>>
>> Disabling fpu support shrinks vmlinux by about 54kBytes (32bit,
>> optimizing for size), and it is mainly useful for embedded devices
>> which have no need for float math (e.g. routers).
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>
> (snip)
>
>> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
>> index 4d86b72..c3d418d 100644
>> --- a/arch/mips/include/asm/fpu.h
>> +++ b/arch/mips/include/asm/fpu.h
>> @@ -154,17 +154,26 @@ static inline void lose_fpu(int save)
>>  static inline int init_fpu(void)
>>  {
>>         int ret = 0;
>> +       static int first = 1;
>
> This one could go into the else branch of (IS_ENABLED(CONFIG_MIPS_FPU_SUPPORT)).
> [...]
> Braces belong on all branches of a conditional, see Chapter 3 of CodingStyle.

Done x2

>> +               preempt_enable();
>>         } else {
>> -               fpu_emulator_init_fpu();
>> +               if (likely(first)) {
>> +                       first = 0;
>> +                       pr_err("FPU support disabled, but FPU use "
>> +                              "detected! Make sure you have a "
>> +                              "softfloat userspace!\n");
>
> Don't split strings, it makes it hard to grep for and they have a
> special exception to exceed the normal 80 characters per line limit
> (Checkpatch does not complain about it). See also Chapter 2 of
> CodingStyle.

I'll trim the text a bit as well.

Thanks!
       Manuel
