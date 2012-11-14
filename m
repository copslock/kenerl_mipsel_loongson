Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 13:11:33 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37944 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823910Ab2KNMLctP2zw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 13:11:32 +0100
Received: by mail-ob0-f177.google.com with SMTP id eh20so294448obb.36
        for <multiple recipients>; Wed, 14 Nov 2012 04:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IBV7fkKaBAf4I71JyiMxCOpNRFYFjXApaAG7z/57afM=;
        b=0LsyfzzASrpXAb7QY+PSnCbnVG32B+SnItgjhdB/aDDws8NmVoMTVNlX4D6Kjwj6rV
         8ukeoyjz3b75sD92igOZaUyd/NVMIjT9Wp35W36bf4rEq+SkNEshwmas/vcFF+YhgiaJ
         Pgvpd1kI/ZoZu5yKpen49IZJc2hncdCtedY2evTXgLCh/aqHV2mBCVaf6ou9Wu+avZX4
         SasJbevw5GHVDIHZtXd0vhq8wxcL9zNZxRWu2R/AQdcCgNgUtq3eBVS+Ihdjg3u1ffsy
         Qt4NCW+NXXeIAuZ9y2PkhfI6EAjJxcuOLBIJdHzsydIyfJ+YhlmHsdwVA+xS6E2wHo1o
         hvjA==
Received: by 10.60.172.138 with SMTP id bc10mr20407423oec.33.1352895086398;
 Wed, 14 Nov 2012 04:11:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Wed, 14 Nov 2012 04:11:06 -0800 (PST)
In-Reply-To: <50A1D452.2020904@wwwdotorg.org>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
 <1352638249-29298-10-git-send-email-jonas.gorski@gmail.com> <50A1D452.2020904@wwwdotorg.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 14 Nov 2012 13:11:06 +0100
Message-ID: <CAOiHx=m=OxDiXKozQG1_iUBDhWj3iJDd9b8LHP_6mPL=FOyGPQ@mail.gmail.com>
Subject: Re: [RFC] MIPS: BCM63XX: add Device Tree clock definitions
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 13 November 2012 06:02, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>> Add definitions for the clocks found and used in all supported SoCs.
>
>> diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
>
>> +                     clocks {
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +
>> +                             periph: pll {
>> +                                     compatible = "brcm,bcm63xx-clock";
>> +                                     #clock-cells = <0>;
>> +                                     clock-frequency = <50000000>;
>> +                                     clock-output-names = "periph";
>> +                             };
>
> Here too, it seems like some reg properties would be required.

This is more or less a dummy clock with no real backing for it, but
some of the drivers expect this clock to be present (even just to get
the frequency).


Jonas
