Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 19:25:00 +0200 (CEST)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:42183
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993880AbeGKRYuTspHg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 19:24:50 +0200
Received: by mail-pl0-x244.google.com with SMTP id f4-v6so5254987plb.9;
        Wed, 11 Jul 2018 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S8eXbFaGYMfhXt72zSTl3yRjSiVUADVFdDDv4zpUO/c=;
        b=dPuJ35q4JJM4GdSL+a0Ld/YvRHiCmiaZPj+sQbkkmHvV9jTjbp0657T0jRsOlDV8vK
         ie6tLHsQLfso9Fmy659YszyuE8/D5Ta3xLrZWwSrcX6MSuI8U4NnnnKOzQIsJ9Ulh+Sp
         TfBfUSvL1zdey046HS99jA2UKabiUpsheh2iDvOL1P4yaACashNewViKrxY+emRvGo5r
         iiQG+DurafAhgKP8gztgGj3GLyYBZm/VoWO2S5GvwIdg8clBoI2oBYznftbJXP4UVKOm
         4HeVFSkcqOErfTAy2Fju57oq19CW9nrSOzX7SagWs6OcKhB25x0oCnJu9SuS3VBYK4/B
         U+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S8eXbFaGYMfhXt72zSTl3yRjSiVUADVFdDDv4zpUO/c=;
        b=Msy21FC6VWiiS4Ff/Y0a/8LazobOcv4XGj8IvlY0YatgQDNqfyJmI/jvWps8zWpVMm
         S+Guxv1eQT7po03wy2TgAYBVltcK2pyiP/xSp7UtztLTWeAzJreC+csOvUTqkpaCG9Y7
         Hq5PSIVZ+sXRPT37sjA9yyRp12n9wm3FQSzKdSHvstsTo6LRGb6foxbt78xdZ32MAgVh
         hwwKM1qIR+oiGJDwv4JNjj2+YmIRNgrk5N0yx2td+9MlDXfCol3ibjEsXBv2UZNzzO5I
         0P/aDcbw7/cbPWJknYWqdqqVMY4qbAT0zfBQm+4+uh2ZN23nl85TiCSk/9V+7lBAEv3+
         ZTxQ==
X-Gm-Message-State: APt69E3j+bgEHUBSrJ1By03epIsaeYE40P4ZvntE8wJPFxW6Bvah3I1C
        OWI9KmmDYtMOOlgnVgdcZLawdXVovS8aRlLlv90=
X-Google-Smtp-Source: AAOMgpeBp/H9AaYK6VAfDPXxJZu5YS+c6j/5wN78m/dEbTsEivXwV8ZtshXtyFKC8ksw5UMovL2h9jKBYwfi2Lk2UL4=
X-Received: by 2002:a17:902:7e43:: with SMTP id a3-v6mr29290537pln.151.1531329883467;
 Wed, 11 Jul 2018 10:24:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:24:43
 -0700 (PDT)
In-Reply-To: <20180710191000.2b7c95bb@bbrezillon>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
 <20180709200945.30116-24-boris.brezillon@bootlin.com> <CANc+2y5vjUpM_ikegaoKTtqehSmBY3y_r+1E6y93AoivRQqmfg@mail.gmail.com>
 <20180710191000.2b7c95bb@bbrezillon>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 11 Jul 2018 22:54:43 +0530
Message-ID: <CANc+2y4RpTTJxh+jWjkWgFpuuJRZbtjKgLxXbRAg_M6L1yQ4Jg@mail.gmail.com>
Subject: Re: [PATCH v2 23/24] mtd: rawnand: jz4780: Drop the dependency on MACH_JZ4780
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

On 10 July 2018 at 22:40, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> Hi PrasannaKumar,
>
> On Tue, 10 Jul 2018 22:16:50 +0530
> PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com> wrote:
>
>> Hi Boris,
>>
>> On 10 July 2018 at 01:39, Boris Brezillon <boris.brezillon@bootlin.com>
>> wrote:
>>
>> > This MACH_JZ4780 dependency is taken care of by JZ4780_NEMC, no need
>> > to repeat it here.
>> >
>> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> > ---
>> >  drivers/mtd/nand/raw/Kconfig | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> > index 7b5e97719c25..d9cd9608bc2d 100644
>> > --- a/drivers/mtd/nand/raw/Kconfig
>> > +++ b/drivers/mtd/nand/raw/Kconfig
>> > @@ -499,7 +499,7 @@ config MTD_NAND_JZ4740
>> >
>> >  config MTD_NAND_JZ4780
>> >         tristate "Support for NAND on JZ4780 SoC"
>> > -       depends on MACH_JZ4780 && JZ4780_NEMC
>> > +       depends on JZ4780_NEMC
>> >         help
>> >           Enables support for NAND Flash connected to the NEMC on JZ4780
>> > SoC
>> >           based boards, using the BCH controller for hardware error
>> > correction.
>> > --
>> > 2.14.1
>> >
>> >
>> >
>> JZ4780 has MLC NAND.
>
> Hm, the NAND controller supports both MLC and SLC NANDs. Maybe there
> are only boards with MLC NANDs, but that doesn't mean we should remove
> the driver for the controller.

Creator CI20 board which uses JZ4780 SoC is supported by upstream as
of now. It has MLC NAND.

But I agree that removing the driver is too extreme.

>> As MLC NAND is not supported in mainline do you think
>> this patch is required? Even wondering if the driver is required at all.
>
> The fact that MLC NANDs are not supported by UBI is not necessarily
> definitive. I have a branch with all the work we've done to add MLC
> support to UBI [1]. If you have time to invest in it, feel free to take
> over this work.

I am afraid I don't have time as well as knowledge to work on it yet.

> Anyway, the decision to remove this driver is not mine, and this patch
> allows me to at least compile-test this driver.
>
> Regards,
>
> Boris
>
> [1]https://github.com/bbrezillon/linux/commits/nand/mlc

Thanks,
PrasannaKumar
