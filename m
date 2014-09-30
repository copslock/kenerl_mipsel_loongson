Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 16:08:48 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:33641 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010180AbaI3OIqCUHkB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Sep 2014 16:08:46 +0200
Received: by mail-la0-f41.google.com with SMTP id pn19so4973370lab.28
        for <multiple recipients>; Tue, 30 Sep 2014 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ncQpuP5YsGwtdgykI5k54MgdpEnqxDeQR/EjBybItlI=;
        b=upaYR1tQJu7UDHWGSWN1fi3UUWmDElG211XaKdMO4Mr06EdNcB1jkn3lwWTGbtUTgr
         8Gg/Wl3Hg9NKi57Lzuae1x1eKip9kp3EnfHiFm2NSo3V4qdfwPVQxZVLfGYPNuijZwA/
         3LdxljVz4OVAEe9Pd+z9W576957hyQ1rC4Z2445AI8XiTrupI/npQcWw4N6ncfz2+3PX
         5XLfCvPQmCETfjnIqy+F4nTxMp62O/988KHxzdcQMtI/kW/eLJ9+r+uUf06Bmb9oVtCt
         yvnlKIJ+00EP255NDgomTOy7Zl+39nYhFNDXklUDWcHaHZGfuunDw/c3q3AFcqvcpz0G
         l3cQ==
MIME-Version: 1.0
X-Received: by 10.112.126.194 with SMTP id na2mr44480711lbb.70.1412086120116;
 Tue, 30 Sep 2014 07:08:40 -0700 (PDT)
Received: by 10.152.216.200 with HTTP; Tue, 30 Sep 2014 07:08:39 -0700 (PDT)
In-Reply-To: <1412085083.10205.8.camel@L80496>
References: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
        <CAMuHMdXj=b0G7foTRkcEtRC_De8+WjVefxBfW=s1sjaXLeF5nQ@mail.gmail.com>
        <1412085083.10205.8.camel@L80496>
Date:   Tue, 30 Sep 2014 16:08:39 +0200
X-Google-Sender-Auth: RjdN3dojaAOz5BUxmZTo3-GsMmU
Message-ID: <CAMuHMdWHMK7NxX9AUg3ihwds41dKW26A_jFnZELw5N9shMaBKw@mail.gmail.com>
Subject: Re: [PATCH] tc: fix warning and coding style
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thibaut Robert <thibaut.robert@gmail.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42899
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

Hi Thibaut,

On Tue, Sep 30, 2014 at 3:51 PM, Thibaut Robert
<thibaut.robert@gmail.com> wrote:
> Le mardi 30 septembre 2014 à 14:28 +0200, Geert Uytterhoeven a écrit :
>> On Tue, Sep 30, 2014 at 2:16 PM, Thibaut Robert
>> <thibaut.robert@gmail.com> wrote:
>> > Fix gcc warning:
>> > warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘resource_size_t’ [-Wformat=]
>> >
>> > As resource_size_t can be 32 or 64 bits (depending on CONFIG_RESOURCES_64BIT), this patch uses "%lld" format along with a cast to u64 for printing resource_size_t values
>>
>> Please use %pR instead (cfr. Documentation/printk-formats.txt).
>
> This code use 'resource_size_t' but I think %pR is for 'struct resource'. I got inspired by this patch: https://lkml.org/lkml/2008/8/29/187

Oops, sorry for (mis)behaving like a bad script.

> However, I've thought again, and '%u' is probably enough for displaying a size in MiB. So I propose the following :
> (Parens around the cast were also missing in my first patch):
>
> @@ -117,10 +114,10 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
>                         tdev->resource.start = extslotaddr;
>                         tdev->resource.end = extslotaddr + devsize - 1;
>                 } else {
> -                       printk(KERN_ERR "%s: Cannot provide slot space "
> -                              "(%dMiB required, up to %dMiB supported)\n",
> -                              dev_name(&tdev->dev), devsize >> 20,
> -                              max(slotsize, extslotsize) >> 20);
> +                       dev_err(&tdev->dev,
> +                               "Cannot provide slot space (%uMiB required, up to %uMiB supported)\n",
> +                               (unsigned int) (devsize >> 20),
> +                               (unsigned int) (max(slotsize, extslotsize) >> 20));
>                         kfree(tdev);
>                         goto out_err;
>                 }
>
>
> WDYT ?

I guess that's acceptable, as tc is probably limited to 32-bit anyway. Maciej?

Note that there's also %pa, for phys_addr_t/resource_size_t.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
