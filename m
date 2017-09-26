Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 15:27:03 +0200 (CEST)
Received: from mail-vk0-x241.google.com ([IPv6:2607:f8b0:400c:c05::241]:33468
        "EHLO mail-vk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990520AbdIZN0xHcHda (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 15:26:53 +0200
Received: by mail-vk0-x241.google.com with SMTP id j189so2738426vka.0;
        Tue, 26 Sep 2017 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ziHGxZdUY5PD5yKPQEy/crUtXbBYpqi1MBYRvKKsjKA=;
        b=X2ccYbN7DYcdodCTCtF9H59nL6YWptYFnthwYx3QSjy+zAZNMMUi/BV7BoWrVOV9eW
         RXcSvBBiNwexXsmDVFNy8yNCgkOuY3aTIlbCzgJNuKTtOZCkOo0JHL0UrFp8P2/qTg7F
         pnCN0bzUbLgTD72pOTeW2wqIwRNyKApsEzUrV7HhKbO/4+SpK0iYGok0988z+yKGwYvO
         ioOXlDaJusuylmrQCiA9os/EBOsudQmcLS5xGjVMI+/dJg2LUd2w7Reyjd6Ynyvna30O
         ax6u4ueqaDC+kgC3xCPmRZyLNeuKbIQujNaet+FRDkDm466iIdeNo1d4zwS9g3jhtFpQ
         btSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ziHGxZdUY5PD5yKPQEy/crUtXbBYpqi1MBYRvKKsjKA=;
        b=Rt64aqvEjucMoERiC1QoauVlv/pDxe12yHS83n3meLdd3X23F0u1+Ra0YTbz1PKnNz
         rln4yUsI0x9nv5ZiucCsCE85BtWKlnNzbSvhy5xiAHdkyVLpek+Hzvsot8GhxX/+lXOj
         0Jy3kC0lP52Icxev7gcJ0pL5QVXobPW2bbnMNtMKjV+fOSnIGz7j0UtRkGF7LnrrFnCl
         AsDeKBxM4c4S+wzfkzYEU6oczp6InitCDnmWXBpz/0hNA1Y0Y1oRT4B82zIZSBPVWvQZ
         Va4/mGDns2oECJY2tUjvXPNfbY16hO3lAxQ/4wB2f7r74wWvHdItdFrsXq4BC0jqSmQn
         dSFw==
X-Gm-Message-State: AHPjjUiCFOE4i1yWPIYHrY2C+0dEIPr5di7a09xu5uQ47aEs3c/XAH2E
        ZW+v1Gwpdz2kSKEzRSP0hJ9hWtG+iFWq9RQzz8o=
X-Google-Smtp-Source: AOwi7QCTpnPSnDFYhKNR2BSZBQqn7HEPTSC/qWWkKc5nsjWRizjVJ1TZIUt/d1mQUhsR0zLh6zPF6s27e6U/VH6WE/w=
X-Received: by 10.31.80.199 with SMTP id e190mr9401413vkb.75.1506432406628;
 Tue, 26 Sep 2017 06:26:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.81 with HTTP; Tue, 26 Sep 2017 06:26:26 -0700 (PDT)
In-Reply-To: <CANc+2y6gZ4UQ7fKbJeV7HhDLLW9pbUEr0K0Tq5eBfg1ba2s_LQ@mail.gmail.com>
References: <20170908183558.1537-3-malat@debian.org> <20170915191837.27564-1-malat@debian.org>
 <CANc+2y6gZ4UQ7fKbJeV7HhDLLW9pbUEr0K0Tq5eBfg1ba2s_LQ@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 26 Sep 2017 15:26:26 +0200
X-Google-Sender-Auth: kCrPWOOkhlUH3AXTZtnBTPX5Ei0
Message-ID: <CA+7wUsyrP8a96-55Zk_GPQmNzPS9MB__dhjwUds7RkQhfe=+EA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] MIPS: jz4780: DTS: Probe the jz4740-watchdog
 driver from devicetree
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Hi PrasannaKumar !

On Tue, Sep 26, 2017 at 3:17 PM, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
> Hi Mathieu,
>
> On 16 September 2017 at 00:48, Mathieu Malaterre <malat@debian.org> wrote:
>> The jz4740-watchdog driver supports both jz4740 & jz4780.
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> Changes in v2:
>> * make the node name generic (Paul Cercueil)
>>
>>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> index 20e37d2d6008..76055bbc823a 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> @@ -263,6 +263,11 @@
>>                 status = "disabled";
>>         };
>>
>> +       watchdog: watchdog@10002000 {
>> +               compatible = "ingenic,jz4780-watchdog";
>
> In drivers/watchdog/jz4740_wdt.c the compatible is declared as
> "ingenic,jz4740-watchdog" while your change says
> "ingenic,jz4780-watchdog". Can you modify that?

Well in the full changeset, you'll find: [PATCH v2 4/5] watchdog:
jz4740: Add support for the watchdog in jz4780 SoC

https://lkml.org/lkml/2017/9/15/451

There has been some misunderstanding. I still believe I need a new
compatible string, even if currently the code is 100% identical.

>> +               reg = <0x10002000 0x100>;
>> +       };
>> +
>
> The structures jz4740_wdt_device and jz4740_wdt_resources can be
> removed form arch/mips/jz4740/platform.c as watchdog is declared in
> device tree. For JZ4740 platform watchdog is not used so the variables
> can be removed.
>
> Do you mind adding watchdog entry to JZ4740 device tree? Currently
> watchdog is not enabled for JZ4740 platform.


Will do once this series has been accepted. Thanks for the review !

>>         nemc: nemc@13410000 {
>>                 compatible = "ingenic,jz4780-nemc";
>>                 reg = <0x13410000 0x10000>;
>> --
>> 2.11.0
>>
>
> Regards,
> PrasannaKumar
