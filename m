Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 14:37:12 +0200 (CEST)
Received: from mail-it0-f52.google.com ([209.85.214.52]:36448 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993262AbcHRMhDxFd9L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 14:37:03 +0200
Received: by mail-it0-f52.google.com with SMTP id e63so25208392ith.1
        for <linux-mips@linux-mips.org>; Thu, 18 Aug 2016 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=z0PIW29l7nJ7g5bTQ5MfCYLtUelb3dTBjKIGUEJ7EcE=;
        b=OOZrLcNexna96SzJ2wnZsB/Ovx9NqeLxuxeqvOvhl2IGkHhxVXd93c7esZUCwhWrCH
         x251grrZ51VOH5J+Zxr8TMXVyyswzVR3PMzZKGp7zCcgffwi5sW/YInUNu8srnaur8o5
         8KIXi7GEBGcmQJqXIRT80bsek+Al36av//DdaEGGp/0ayFteGSd6HcSRDnjlvwFCYpg2
         msYwxNLbVgXeJqwgDinLm7kgr5tsZxe8DgqFY8mUC/f1DdEOykbSurXXnPaTv1E6MUtl
         UayWrNyB7rN84cFirguo5JZtsHXxbQYHXCjkIGmAtv74xm5hwd0L0F6ZkcENmvLpzRfR
         1Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=z0PIW29l7nJ7g5bTQ5MfCYLtUelb3dTBjKIGUEJ7EcE=;
        b=MY8lD2uB0ZCVe+BjYpH2f1SVSCIkgFBuJ6ygMAnoO3fsc6Vu8xBIWCK2VHfnx0eIbJ
         wwixSY8EDFWMS4h5MhUGJazAiZcCcO5kTYRAmezZDOq7hgecaTr+0i0meByIqWkH2x19
         pFg3KuTFzo9SLP9Qp+im12Cswsg0N6DHmTpJA8SKrSQYHOjBAm0F64KJhyh8yYTAaxPa
         HJAvRRsxVQpOilacu3ykoSm1yBGhci44XIYjkNTHbYriF/AnNSf2Y9gyxOO2w8+K29RD
         D293SoWTr4JrC1w3pQyGuGKCwzhCml6UyTN2jyQzmIbhiDqFyfHw87gSLBoDiiq9OL8A
         aa3A==
X-Gm-Message-State: AEkoouvnY0ZnLVNqnn9rwYOA1DHv8pgKSSFwe/c639ecLcBjS43mf6xYRFHrA2I+nKqLPHtbdBUIy6FkiLhHsg==
X-Received: by 10.36.200.134 with SMTP id w128mr3003099itf.92.1471523815233;
 Thu, 18 Aug 2016 05:36:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.232 with HTTP; Thu, 18 Aug 2016 05:36:54 -0700 (PDT)
In-Reply-To: <20160801.232359.1867350514422089320.anemo@mba.ocn.ne.jp>
References: <CAMuHMdUARn_SxhkWiTsGdSixFv9a=VjKLLgQMfPTtxufrjepCg@mail.gmail.com>
 <20160801.232359.1867350514422089320.anemo@mba.ocn.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2016 14:36:54 +0200
X-Google-Sender-Auth: 190qE8djfoYbhALJhjibs8cK01M
Message-ID: <CAMuHMdW6e=Tms0TXLVomRm7EdhPNpvFTO13nx3W2cyx52VDUmQ@mail.gmail.com>
Subject: Re: Revisiting rbtx4927: gpiod_direction_output_raw: invalid GPIO
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Nemoto-san,

On Mon, Aug 1, 2016 at 4:23 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Thu, 14 Apr 2016 21:06:05 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> I've just updated my old rbtx4927 from v3.13-rc3 to v4.6-rc3.
>> Surprisingly, it boots to nfsroot without any kernel changes.
>
> Good news!  I'm happy to hear that.
>
>> However, there's an annoying warning in the boot log:
>>
>>         gpiod_direction_output_raw: invalid GPIO
>>
>> This is caused by the following code in arch/mips/txx9/rbtx4927/setup.c:
>>
>>         static void __init rbtx4927_mem_setup(void)
>>         {
>>
>>                 /* TX4927-SIO DTR on (PIO[15]) */
>>                 gpio_request(15, "sio-dtr");
>>
>> returns -EPROBE_DEFER
>>
>>                 gpio_direction_output(15, 1);
>>
>> VALIDATE_DESC triggers the warning.

Note that as of commit 54d77198fdfbc4f0 ("gpio: bail out silently on NULL
descriptors"), the warning is gone. But the underlying issue isn't.

>> Probably a silly GPIO conversion was missed during the last 2+ years?
>
> Maybe txx9_gpio_init() failed to add gpio_chip since it was called too
> early on startup.
>
> Nowadays gpiochip_add_data calls kzalloc so cannot be called from
> plat_mem_setup context.

That's correct. It failed (silently) with -12, which is -ENOMEM...

> Could you try moving these txx9_gpio_init(), gpio_request() and
> gpio_direction_output() calls to rbtx4927_arch_init() or
> rbtx4927_device_init()?

Thanks, that works! Will send patches soon...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
