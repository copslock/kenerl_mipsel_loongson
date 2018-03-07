Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 14:45:03 +0100 (CET)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:44101
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994720AbeCGNo4k1v1g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 14:44:56 +0100
Received: by mail-io0-x242.google.com with SMTP id h23so3053518iob.11;
        Wed, 07 Mar 2018 05:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9ZxNlKhAxHIkVsIi8BDFjolqv6lDHm5y/dg9vYi0dUU=;
        b=c+XSVp2iBd1ploamULaONJzUDjRxqC7GCtKK+FAT2ssoB8AeR4itQUK4XGqCzP0yKC
         b1MRnmP93fUI69B8soqSfC0eq0vCDSLQfedj/vw+D5zfsMVFAoInKVWbmEXs6OstTS8C
         wAmkXyj1QUHMWX3JiWOAGvqIIA2oy8wQsS94Y+xt/9KqDTx9fb4YxeFHW5HQ6A6XgQm/
         fbQdgp1G7OyNgTEKNUwF4odTW3rRVe0NPbkGqlw2ZxGU+AEoRuCRamCe1pOc/e7eopik
         PxgcjtBXuOAg1FDsx4N8VN7R1Q3v3G9yC2Ys3srJmlfyjqSL6icU9MQ37WHNAhC9lzc6
         ZWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9ZxNlKhAxHIkVsIi8BDFjolqv6lDHm5y/dg9vYi0dUU=;
        b=ryLX+zLSOQBs0GI7qkVduhdTK/IzVBocbh67U/rZ9kEkrZZ3RUFTUrtiD/ir3uhQxK
         QXhmN4UFrdNd5OKkwDqWi/R25gjM3yQC/jrejJgd7CdNYzTWAmW4dN1/omj2sfo2W/VU
         kfkcZm4997xc5MiHTjG26Y0c06tYm5XMX+JUqzO/tk5aAIv/LEVuBk8XI7D1ONDhzKi1
         JWp9DL8xR/yDJNC0H48yWfyooR6M8pvapcCMW8E+r9MEfIXrt8Za1/JScLqz1OfhpV/v
         WeWdS9swwVV6K3fD6CPihJA8lDjTts3Qr5Wzf74UiatRipD30VpoAvqYFGxcjWciL9lH
         pYLw==
X-Gm-Message-State: AElRT7Ex3MU6GWCXyAaFbzD2Pg2+mPE4N54b/nrHJbbSMvohBGIEljMa
        F8syy+Xzo985/bjSdbJA/cYuWUEwvA913AJbxmw=
X-Google-Smtp-Source: AG47ELvKeokPpWFhnHpbFTXl+YjJKuwbhFOTrPaq6rr2+rKf2g4TBk3nXFg0CAY2LMZ6hgNQeJX6gs9CTg8rznCSPwM=
X-Received: by 10.107.198.151 with SMTP id w145mr25431464iof.255.1520430290089;
 Wed, 07 Mar 2018 05:44:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.89.194 with HTTP; Wed, 7 Mar 2018 05:44:49 -0800 (PST)
In-Reply-To: <20180306000832.GL4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com> <20180306000832.GL4197@saruman>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 7 Mar 2018 19:14:49 +0530
Message-ID: <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
To:     James Hogan <jhogan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62827
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

Hi James,

Thanks for reviewing this.

On 6 March 2018 at 05:38, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Sep 27, 2017 at 08:45:26PM +0530, PrasannaKumar Muralidharan wrote:
>> Add initial Ingenic X1000 SoC support. Provide minimum necessary
>> information to boot kernel to an initramfs userspace.
>>
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> ---
>>  arch/mips/boot/dts/ingenic/x1000.dtsi | 93 +++++++++++++++++++++++++++++++++++
>>  arch/mips/jz4740/Kconfig              |  6 +++
>>  arch/mips/jz4740/time.c               |  2 +-
>>  3 files changed, 100 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/mips/boot/dts/ingenic/x1000.dtsi
>
> arch/mips/jz4780/setup.c, specifically get_board_mach_type() and
> get_system_type() will need updating too.

Missed it. Will make necessary changes.

> Does X1000 use a different PRID, or is it basically just a JZ4780 core
> with different SoC peripherals?

Yes X1000 does have a different PRID (PRID = 0x2ed1024f). X1000 has
single CPU core so it is definitely not JZ4780.

>> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
>> new file mode 100644
>> index 0000000..abbb9ec
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
>> @@ -0,0 +1,93 @@
>> +/*
>> + * Copyright (C) 2016 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>
> (these will need updating to use SPDX identifiers if you respin)

Sure. Will take care while submitting next version.

>> +     cgu: jz4780-cgu@10000000 {
>
> not sure jz4780 is appropriate here.

No, it is not. Copy pasted from jz4780.dtsi but missed updating this.

>> +             compatible = "ingenic,x1000-cgu";
>> +             reg = <0x10000000 0x100>;
>> +
>> +             clocks = <&ext>, <&rtc>;
>> +             clock-names = "ext", "rtc";
>> +
>> +             #clock-cells = <1>;
>> +     };
>
> Cheers
> James

I used to get my code tested from Domink but I could not reach him for
quite some time. Before buying the development board myself I would
like to see if anyone can help me in testing. Do you have any contact
with Ingenic who can help in testing this?

Thanks,
PrasannaKumar
