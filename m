Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 16:11:34 +0200 (CEST)
Received: from mail-yh0-f48.google.com ([209.85.213.48]:50682 "EHLO
        mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012134AbaJVOLcWYCCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 16:11:32 +0200
Received: by mail-yh0-f48.google.com with SMTP id v1so3476029yhn.7
        for <multiple recipients>; Wed, 22 Oct 2014 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FYetDZXVV6ceUrhUNukBaxN7jh6dPKFxRd6UcYhjWpg=;
        b=jjpJhTpU2NMFIdkhWUyonPgulhWEzM2rVGkAYzpHmkAqJFf6TE/gOKJQ6gjvuiOZaW
         4rlZaPYzIWOsKK6yoqrbl+tJimmaI572oW7dnNcNDTT0zDLYi51BRzi/WyOc3cejOzvX
         A1alne+kasIEcPKI9QUQ1S5ZpLFgDANX8mtV67VOxGM1ATv4INnFzmUgrGtqOAl3D2WI
         6fMaaLXMyK6JZZDFKmwgqJAtoi55y05WFbSAhrM8JtCKblrnhwY6Cb9UWu1Wx0NvRjz+
         V5oAR8GE/z/Pbfmmj1o5+O/pDV5UbJl/8BooQ7nMKWKBH3eHtMAuuKY0zo/bQvkFEIcL
         JQtw==
X-Received: by 10.236.28.112 with SMTP id f76mr1874882yha.195.1413987086080;
 Wed, 22 Oct 2014 07:11:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Wed, 22 Oct 2014 07:11:05 -0700 (PDT)
In-Reply-To: <5446F0D2.7050603@openwrt.org>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-3-git-send-email-ryazanov.s.a@gmail.com> <5446F0D2.7050603@openwrt.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 22 Oct 2014 18:11:05 +0400
Message-ID: <CAHNKnsSG7ZUwAby00wQAHX-N024VOvki02XAjY2AAP0YuTZy6A@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] MIPS: ath25: add basic AR5312 SoC support
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-10-22 3:48 GMT+04:00 John Crispin <blogic@openwrt.org>:
> 1 comment inline
>
> On 22/10/2014 01:03, Sergey Ryazanov wrote:
>> Add basic support for Atheros AR5312/AR2312 SoCs: registers
>> definition file and initial setup code.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com> ---
>>
>> Changes since v1: - rename MIPS machine ar231x -> ath25
>>

[snip]

>> void __init prom_init(void)
>> {
>>+       if (is_ar5312())
>>+               ar5312_prom_init();
>> }
>
> if i am reading this correct then is_ar5312() can return true even if
> CONFIG_SOC_AR5312 is not selected
>
Yep. It checks the version of SoC MIPS core, to distinguish chip
families. If SOC_AR5312 or SOC_AR2315 not selected then respective
chip specific functions are replaced by stubs.

> how about
>
> if (IS_ENABLED(CONFIG_SOC_AR5312) && is_ar5312())
>         pr_info("AR5312");
> else if (IS_ENABLED(CONFIG_SOC_AR2315) && is_ar2315())
>         pr_info("AR2315");
> else
>         panic("failed to init memory");
>
> somewhere early in the code
>

If you want show to user some message, when kernel was built with
wrong options, then may be:

#if !defined(CONFIG_SOC_AR5312) && !defined(CONFIG_SOC_AR2315)
#error "You should select at least one SoC support option"
#endif

if (!IS_ENABLED(CONFIG_SOC_AR5312) && is_ar5312())
        panic("AR5312 SoC support is not builtin");
if (!IS_ENABLED(CONFIG_SOC_AR2315) && is_ar2315())
        panic("AR5312 SoC support is not builtin");

IMHO these checks in general is odd.

-- 
BR,
Sergey
