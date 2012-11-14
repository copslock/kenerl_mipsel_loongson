Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 13:10:28 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52122 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823910Ab2KNMK0qHQoA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 13:10:26 +0100
Received: by mail-ob0-f177.google.com with SMTP id eh20so293521obb.36
        for <multiple recipients>; Wed, 14 Nov 2012 04:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fRYithsN8hBb16Pk8ExHqfxvhDKVGMcP65cjZC12v0U=;
        b=iILex9f2McY15gRFVDamiMsrgz8fyuMX6vYvJaNQNbLd81yFGHqAqr0hYPjnjIP2Li
         wndRObbFB2JHBCBJjyN5d5jNL2wQZAjf92uJVIzAeg6tmCeZOHq3UvE9RnBGEx/iev3i
         /4S6syScSONzobIGKrB+hrVT63AoZOeZQ0rwkIka6yQnd7onHec9nE2kDCG3Hn+LF1Zm
         hq+dVx24qmF855904A4z/rwSY6jHODEvxGCyBkmHRuSmI3/vMgEs01MZiuNt9KHscTLa
         n7rERmgx72Hb/h8dJK5E9IKnq2Ky0iMHA2l3paE69WfL5zrAAYnayjyRLkwZT/+BaaS9
         iDaA==
Received: by 10.60.172.138 with SMTP id bc10mr20404963oec.33.1352895020151;
 Wed, 14 Nov 2012 04:10:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Wed, 14 Nov 2012 04:09:59 -0800 (PST)
In-Reply-To: <50A1D3FC.9010207@wwwdotorg.org>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
 <1352638249-29298-5-git-send-email-jonas.gorski@gmail.com> <50A1D3FC.9010207@wwwdotorg.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 14 Nov 2012 13:09:59 +0100
Message-ID: <CAOiHx==Ufghuf8Oans2VV4eZ1LusdJH4rwq=oos_pM3_y0-omg@mail.gmail.com>
Subject: Re: [RFC] MIPS: BCM63XX: add Device Tree glue code for IRQ handling
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34998
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

On 13 November 2012 06:00, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>> Register IRQ domains through Device Tree for the internal and external
>> interrupt controllers. Register the same IRQ ranges as previously to
>> provide backward compatibility for non-DT drivers.
>
>> diff --git a/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt b/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt
>
> Rather than putting binding docs in an arch-specific directory, perhaps
> put them into a device-type-specific directory, such as
> bindings/interrupt-controller/brcm,bcm63xx-epic.txt?

Almost everyone has their interrupt-controller bindings in
$arch/$platform, but if interrupt-controller is the preferred
location, I can certainly move it there; I have no hard preference for
any location.

>
>> +- #interrupt-cells: <2>
>> +  This controller supports level and edge triggered interrupts. The
>> +  first cell is the interrupt number, the second is a 1:1 mapping to
>> +  the linux interrupt flags.
>
> The DT documentation should be self-contained, and not reference
> anything OS-specific. In this case, you could reference
> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> for the interrupt flags.

Good Idea, I'll do that for the next iteration.

>> diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
>
>>               ranges = <0 0x10000000 0x20000>;
>>               compatible = "simple-bus";
>> +
>> +             interrupt-parent = <&ipic>;
>> +
>> +             perf@0 {
>> +                     epic: interrupt-controller@18 {
>
> Don't you need some reg properties in the perf and interrupt-controller
> nodes so that the register address can be determined?

Since there is no support code for that property yet I did not add it.
I haven't quite finished yet how the final bindings will be (since
there are/were a few things I haven't finished researching yet, e.g.
how this controller works in SMP context, and how interrupt
controllers are supposed to work).

I can add all expected properties now and add support for them later,
but I feel that this might add properties that will then never
supported, and nobody updates the documentation for that, so I'd
rather like to keep the documentation/dts(i) in sync with what the
actual code expects/supports.


Jonas
