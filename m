Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jan 2018 12:52:48 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:43327
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbeAFLwla7Aet (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jan 2018 12:52:41 +0100
Received: by mail-it0-x241.google.com with SMTP id u62so4373812ita.2;
        Sat, 06 Jan 2018 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WcCUyri3VX7AV9HRLdZlzrCEvFmkE5s1h4m1Aa3rKw8=;
        b=F+906N+c6DJMEDZKKipPgivfBlDAs374SeaAkqoDZ+A84uyHoeJT9srNu+Q2MLOMHZ
         YC9oy4CbXuQyVe7Cub6fRq88YDk0zBtmtlr8MXhBMqJaGBk1P8UAjJYO1ydFYiXFIwHJ
         YTLqH2Vq8/W03lk+FsB5bYEpOKWPkwy+4sQJo87+qKXQm2TfW2aYQd5mL8C7kCsjAEhg
         N0Ayvwcw4jnwfU2dPdaHWveq2rkUZmBl2uL1UnhK8uwhd/nH/V+wMoU3B3DqafzpzaCA
         b2aje2CH9IZmercTzayBUD1cBYBQMNQqxZQ4dxrRWcCYTL+AdzIm2zK0LI3av5yn8+Wu
         KZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WcCUyri3VX7AV9HRLdZlzrCEvFmkE5s1h4m1Aa3rKw8=;
        b=BP9QLUl8Sn+6NewgU2T6KdlcoH5Tj97DBjckHFJvIuFPnNtzy8lyvBb04FK3KcqO1Q
         Re30JyU6Imd+nIKt8dcw8/HWut/FVoNMQwq0pW7tBJx+EXUqzTgLA3GRmfyYw4DauB29
         I1Y7Y/B0sEyEqeG1+y6UqDWdgjfMIftU1Tbdx+nnrrDlWSMVNm11Vdd/iSefWo86W5xA
         5vCvBZuqObOXDjK+3OS8mkaDF9n3Egg9qCjOyVxRd3WjdkOJqYx+M1ZABlfyYP1aVlJO
         o3kVK+/Y8k1uLIPLNQgRQXiDw+S8fd7sDlQsKcBBN7I69QVhtLEf1BwyKcWeEJkD/P/s
         Y5jQ==
X-Gm-Message-State: AKGB3mL233wc7R4/WexXjPBI/PIsFKz6JxsoO/P/2npdgi7Ju48IoVhQ
        wey0mHeefgfjyZzOHuPcTC2xDqS2JhdJmAkElng=
X-Google-Smtp-Source: ACJfBouwr2w2RuyllqlmcwJGMrkY6in/a1/zTDipiDlYlD9VfSUEE1WDIuwAEWuI7d7myJ8aLTq9znVhx2wskNOmWdY=
X-Received: by 10.36.210.197 with SMTP id z188mr6160007itf.144.1515239555045;
 Sat, 06 Jan 2018 03:52:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Sat, 6 Jan 2018 03:52:34 -0800 (PST)
In-Reply-To: <0a3b0b12-80c0-9d6d-bfdb-8d2541947750@mips.com>
References: <20171227122722.5219-1-malat@debian.org> <20171227122722.5219-2-malat@debian.org>
 <bbc64846-e12e-aea8-c516-5e03f6253fed@mips.com> <CA+7wUsxM4Cq-K6ONSO-WzmYYvq8PmT92Jfrf7M-MqY-ntObi-g@mail.gmail.com>
 <0a3b0b12-80c0-9d6d-bfdb-8d2541947750@mips.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 6 Jan 2018 17:22:34 +0530
Message-ID: <CANc+2y7zf5V-7oWiBEDkhv6cD70C74=_7q4fUtbwU85MydAkzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvmem: add driver for JZ4780 efuse
To:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>, Zubair.Kakakhel@mips.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61950
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

Hi Marcin,

On 28 December 2017 at 13:35, Marcin Nowakowski
<marcin.nowakowski@mips.com> wrote:
> Hi Mathieu,
>
> On 28.12.2017 08:26, Mathieu Malaterre wrote:
>>
>> Hi Marcin,
>>
>> On Thu, Dec 28, 2017 at 8:13 AM, Marcin Nowakowski
>> <marcin.nowakowski@mips.com <mailto:marcin.nowakowski@mips.com>> wrote:
>>  > Hi Mathieu, PrasannaKumar,
>>  >
>>  > On 27.12.2017 13:27, Mathieu Malaterre wrote:
>>  >>
>>  >> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com
>> <mailto:prasannatsmkumar@gmail.com>>
>>  >>
>>  >> This patch brings support for the JZ4780 efuse. Currently it only
>> expose
>>  >> a read only access to the entire 8K bits efuse memory.
>>  >>
>>  >> Tested-by: Mathieu Malaterre <malat@debian.org
>> <mailto:malat@debian.org>>
>>  >> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com
>> <mailto:prasannatsmkumar@gmail.com>>
>>  >> ---
>>  >
>>  >
>>  >> +
>>  >> +/* main entry point */
>>  >> +static int jz4780_efuse_read(void *context, unsigned int offset,
>>  >> +                                       void *val, size_t bytes)
>>  >> +{
>>  >> +       static const int nsegments = sizeof(segments) /
>> sizeof(*segments);
>>  >> +       struct jz4780_efuse *efuse = context;
>>  >> +       char buf[32];
>>  >> +       char *cur = val;
>>  >> +       int i;
>>  >> +       /* PM recommends read/write each segment separately */
>>  >> +       for (i = 0; i < nsegments; ++i) {
>>  >> +               unsigned int *segment = segments[i];
>>  >> +               unsigned int lpos = segment[0];
>>  >> +               unsigned int buflen = segment[1] / 8;
>>  >> +               unsigned int ncount = buflen / 32;
>>  >> +               unsigned int remain = buflen % 32;
>>  >> +               int j;
>>  >
>>  >
>>  > This doesn't look right, as offset & bytes are completely ignored. This
>>  > means it will return data from an offset other than requested and may
>> also
>>  > overrun the provided output buffer?
>>
>>
>> Thanks for the review ! That was the part of nvmem framework I was not
>> totally clear. Let say I want to expose only a portion of efuse space, eg:
>
>
> Do you need to expose this to the userspace or to other drivers only?
> For the second case have a look at the description of nvmem cell interface.
>
>
>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> index 2f26922718559..44d97c06a6d15 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> @@ -299,6 +299,15 @@
>> clocks = <&cgu JZ4780_CLK_AHB2>;
>> clock-names = "bus_clk";
>> +
>> +#address-cells = <1>;
>> +#size-cells = <1>;
>> +
>> +eth_mac: eth_mac@12 {
>> +/* six byte/48bit MAC address stored as 8-bit integers */
>> +reg = <0x12 0x6>;
>> +};
>> +
>> };
>> };
>> What should I do to expose that chunk only in the user space ?
>
>
> The nvmem interface's userspace interface (via /sys/.../nvmem) provides
> access to the complete device raw memory so the only way to achieve that
> would be to parse the devicetree description in your driver and only
> register part of the memory with the nvmem driver - but that would be a
> slight abuse of the interface.
> The nvmem devicetree binding document shows clearly how to define the cell
> interface that can later be used by any consumer - that way you could have
> the ethernet driver access the cell directly. However, as the dm9000 driver
> isn't designed to do that and this is a SoC-specific extention, I don't know
> how it fits with the general eth driver design ...
>
> Potentially a good and useful compromise would be to have all of the cell
> regs exposed via /sys/.../nvmem-cellname file (or something similar), but
> this is not currently supported and I don't know what the view of nvmem
> maintainers on adding such extension would be.

Currently exposing MAC address is necessary. No need to worry about
user space stuff for now.

>>  >
>>  >> +               /* EFUSE can read or write maximum 256bit in each time
>> */
>>  >> +               for (j = 0; j < ncount ; ++j) {
>>  >> +                       jz4780_efuse_read_32bytes(efuse, buf, lpos);
>>  >> +                       memcpy(cur, buf, sizeof(buf));
>>  >> +                       cur += sizeof(buf);
>>  >> +                       lpos += sizeof(buf);
>>  >> +                       }
>>  >> +               if (remain) {
>>  >> +                       jz4780_efuse_read_32bytes(efuse, buf, lpos);
>>  >> +                       memcpy(cur, buf, remain);
>>  >> +                       cur += remain;
>>  >> +                       }
>>  >> +               }
>>  >> +
>>  >> +       return 0;
>>  >> +}
>
>
> Regardless of the choices above, you still always have to make sure in your
> reg_read method that you only read from the offset specified in method
> arguments and never return more than 'bytes' of data requested.

Sure, will do that.

Regards,
PrasannaKumar
