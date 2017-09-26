Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 16:00:00 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:35337
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdIZN7x362Za (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 15:59:53 +0200
Received: by mail-io0-x241.google.com with SMTP id d16so4608253ioj.2;
        Tue, 26 Sep 2017 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IhadVHMVkt/XzhpXVqQXlv4/4Mr78kskQb0tZgW24Fw=;
        b=sn/LmfyW92BGHySuILQpDZQL8BJiQCbdbyriV8nRslHQAcl5oEvZYDl/RnH4VexRgT
         /1QPm9MLq0cGAbZAQyHkRc/SevwxYJMVKP9VrlATwm61v8q5zyYqQDPFXHW0Wf0WWEIe
         l94KMfYj21ioyWUl48/wiSoSQOFg8p9fzzWl/rE+7ArcDoqr7gANiE34/TAeU3/li9ob
         aGnEEtFuyIVJan2UCL9902iOmoRhpoD8xcw1RuoSWugq+McXm4mtwvf0X4rA9WThucEX
         dXORVrvo14ZeSwrSmSYdxx/OcNdtHZdqou0quThQpmPN9l3Nq2koL0/aXhi4adC009In
         aiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IhadVHMVkt/XzhpXVqQXlv4/4Mr78kskQb0tZgW24Fw=;
        b=iKfecWDe2UhRFdNMH/TvUuRqhYjsZCihpFieAJubtmYN3k8p9KtdmkzjjHNOg89vfb
         KcJDnh/uB4n+ZDW7ODmRohMeAKY+IDpp8wFp0VI9IMAEnsa7CasKbJMIR1Qx0/2zbiKN
         URTihRk14gvY0dYRfXQVlg2iAyl++qMTaiAatgRSZA/xeoR1cMxSdOXQNGTo253Kp0RP
         xwzHJZq7kQlwU4ZBpEbMxDCeoGHmtGVnqeKI4tL5KOB4gTFS8J5qshCd0A1lI6MFPpcg
         OqUXK3h5bP0PZ4p00OAff07+FgembYBe6pAy5D2dtQBpN1nOQnEF9stInX51dV+CY1eM
         1BfA==
X-Gm-Message-State: AHPjjUjejP4QrqpPAGv/vh27/XWrqWV+kmb22vzGgJ61JGIt+UBw+TDK
        OjFbfIQCNexRIO7A6vnRL7TObs2mXG2yf4qz+xo=
X-Google-Smtp-Source: AOwi7QCzmOMcjZG23bKDdVC3f9Dr75TsWSzn6w2/aqHoh/+ZIsZosNo4Ff5hvjbL7OTozJ/vNXkMjkrLcfviiiofTYo=
X-Received: by 10.107.78.19 with SMTP id c19mr13987037iob.205.1506434387087;
 Tue, 26 Sep 2017 06:59:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.12.193 with HTTP; Tue, 26 Sep 2017 06:59:46 -0700 (PDT)
In-Reply-To: <CA+7wUsyrP8a96-55Zk_GPQmNzPS9MB__dhjwUds7RkQhfe=+EA@mail.gmail.com>
References: <20170908183558.1537-3-malat@debian.org> <20170915191837.27564-1-malat@debian.org>
 <CANc+2y6gZ4UQ7fKbJeV7HhDLLW9pbUEr0K0Tq5eBfg1ba2s_LQ@mail.gmail.com> <CA+7wUsyrP8a96-55Zk_GPQmNzPS9MB__dhjwUds7RkQhfe=+EA@mail.gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 26 Sep 2017 19:29:46 +0530
Message-ID: <CANc+2y47sX0-oDiZvY0AnwHyy0v1uZM7wg-Le5Np=OVEVf0YVQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] MIPS: jz4780: DTS: Probe the jz4740-watchdog
 driver from devicetree
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60159
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

On 26 September 2017 at 18:56, Mathieu Malaterre <malat@debian.org> wrote:
> Hi PrasannaKumar !
>
> On Tue, Sep 26, 2017 at 3:17 PM, PrasannaKumar Muralidharan
> <prasannatsmkumar@gmail.com> wrote:
>> Hi Mathieu,
>>
>> On 16 September 2017 at 00:48, Mathieu Malaterre <malat@debian.org> wrote:
>>> The jz4740-watchdog driver supports both jz4740 & jz4780.
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>> Changes in v2:
>>> * make the node name generic (Paul Cercueil)
>>>
>>>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> index 20e37d2d6008..76055bbc823a 100644
>>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> @@ -263,6 +263,11 @@
>>>                 status = "disabled";
>>>         };
>>>
>>> +       watchdog: watchdog@10002000 {
>>> +               compatible = "ingenic,jz4780-watchdog";
>>
>> In drivers/watchdog/jz4740_wdt.c the compatible is declared as
>> "ingenic,jz4740-watchdog" while your change says
>> "ingenic,jz4780-watchdog". Can you modify that?
>
> Well in the full changeset, you'll find: [PATCH v2 4/5] watchdog:
> jz4740: Add support for the watchdog in jz4780 SoC
>
> https://lkml.org/lkml/2017/9/15/451
>
> There has been some misunderstanding. I still believe I need a new
> compatible string, even if currently the code is 100% identical.

I missed that. Ignore this comment.

>
>>> +               reg = <0x10002000 0x100>;
>>> +       };
>>> +
>>
>> The structures jz4740_wdt_device and jz4740_wdt_resources can be
>> removed form arch/mips/jz4740/platform.c as watchdog is declared in
>> device tree. For JZ4740 platform watchdog is not used so the variables
>> can be removed.
>>
>> Do you mind adding watchdog entry to JZ4740 device tree? Currently
>> watchdog is not enabled for JZ4740 platform.
>
>
> Will do once this series has been accepted. Thanks for the review !

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

>
>>>         nemc: nemc@13410000 {
>>>                 compatible = "ingenic,jz4780-nemc";
>>>                 reg = <0x13410000 0x10000>;
>>> --
>>> 2.11.0
>>>
>>
>> Regards,
>> PrasannaKumar
