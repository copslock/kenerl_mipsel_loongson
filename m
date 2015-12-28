Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Dec 2015 11:15:39 +0100 (CET)
Received: from mail-io0-f194.google.com ([209.85.223.194]:33084 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007586AbbL1KPgXqQdZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Dec 2015 11:15:36 +0100
Received: by mail-io0-f194.google.com with SMTP id f127so24068322ioa.0;
        Mon, 28 Dec 2015 02:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=B1HjBYd68AD2J26CIELNyq6AaDVL5QC8v69kqcTKQbg=;
        b=V729q1KOCJaLoH0bLUQiODlAbEl4cGWbDC0H89HRAgJybYV3yEJXxWh7HpbBz4Z4mC
         vIpYgWBRtgtb1FzHihy65IUwV/LhBJN1sc86dwuoStMIWvuZ6DtWri+F7XlefJtKqzUi
         /igRiesY5wFdGbHTwyI7vf9AtD9k8GaEolhV75Q4J+G8zewCp64KpUFpYjUYeDhFX03D
         2927gTyR9Iox2dm2XGjWDDbpTiv2Bb1rKDsWvNnBbLp1RK5rDVo5zU93tLc2pBo7ai7j
         TllH1ftzyc1nkIm9WkM9rRK6mPidWGIj+3UkytX089Kcv6x9QsZm70/U2ML0Ps0B7VPE
         niJg==
MIME-Version: 1.0
X-Received: by 10.107.148.75 with SMTP id w72mr9001783iod.115.1451297730517;
 Mon, 28 Dec 2015 02:15:30 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Mon, 28 Dec 2015 02:15:30 -0800 (PST)
In-Reply-To: <20151228050147.GE1066@verge.net.au>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
        <20151228050147.GE1066@verge.net.au>
Date:   Mon, 28 Dec 2015 11:15:30 +0100
X-Google-Sender-Auth: e4zmnQ_3AGzRO10fxVmRk4EJdD8
Message-ID: <CAMuHMdXt36GSDuoFVGBebJVN9OHPh=ze8u8KvQ0B+RcvT6xTYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions" node
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "arm@kernel.org" <arm@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50761
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

Hi Simon,

On Mon, Dec 28, 2015 at 6:01 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
>> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
>> subnode of an SPI FLASH device node must have a compatible property. The
>> partitions are no longer detected if it is not present.
>>
>> However, several DTSes in -next have already been converted to the
>> "partitions" subnode without "compatible" property, introduced by
>> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
>> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
>> partitions in a special 'partitions' subnode"). Hence all of these are
>> now broken in -next, and will be broken in upstream during the merge
>> window.
>>
>> This series fixes all users in next-20151221.
>> Tested on r8a7791/koelsch.
>>
>> Changes since v1:
>>   - Add Acked-by,
>>   - Fix new users in -next (kirkwood, ci20).
>>
>> Most of these are in arm-soc/for-next. Exceptions are kirkwood (in
>> mvebu/for-next), and ci20 (in mips/mips-for-linux-next).
>>
>> Given we're late in the v4.4-rc cycle, perhaps it's easiest if the
>> arm-soc maintainers take all applicable patches directly, bypassing the
>> mvebu and shmobile maintainers?
>>
>> Thanks for queuing for v4.5!
>>
>> Geert Uytterhoeven (9):
>>   ARM: mvebu: ix4-300d: Add compatible property to "partitions" node
>>   ARM: mvebu: kirkwood: Add compatible property to "partitions" node
>>   ARM: shmobile: bockw dts: Add compatible property to "partitions" node
>>   ARM: shmobile: lager dts: Add compatible property to "partitions" node
>>   ARM: shmobile: koelsch dts: Add compatible property to "partitions"
>>     node
>>   ARM: shmobile: porter dts: Add compatible property to "partitions"
>>     node
>>   ARM: shmobile: gose dts: Add compatible property to "partitions" node
>>   ARM: shmobile: silk dts: Add compatible property to "partitions" node
>
> Thanks, I have queued up the above "shmobile" patches for v4.6.

I'm afraid v4.6 is too late, leaving all SPI FLASHes broken in v4.5.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
