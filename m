Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2012 05:13:30 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:54087 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817033Ab2KQEN3okutl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2012 05:13:29 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 7D49A6234;
        Fri, 16 Nov 2012 21:14:48 -0700 (MST)
Received: from dart.wwwdotorg.org (unknown [IPv6:2001:470:bb52:63:5d70:fb63:5917:494d])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 163B9E40EF;
        Fri, 16 Nov 2012 21:13:27 -0700 (MST)
Message-ID: <50A70EE6.3050101@wwwdotorg.org>
Date:   Fri, 16 Nov 2012 21:13:26 -0700
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [RFC] MIPS: BCM63XX: add Device Tree glue code for IRQ handling
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-5-git-send-email-jonas.gorski@gmail.com> <50A1D3FC.9010207@wwwdotorg.org> <CAOiHx==Ufghuf8Oans2VV4eZ1LusdJH4rwq=oos_pM3_y0-omg@mail.gmail.com>
In-Reply-To: <CAOiHx==Ufghuf8Oans2VV4eZ1LusdJH4rwq=oos_pM3_y0-omg@mail.gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 35030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 11/14/2012 05:09 AM, Jonas Gorski wrote:
> On 13 November 2012 06:00, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>>> Register IRQ domains through Device Tree for the internal and external
>>> interrupt controllers. Register the same IRQ ranges as previously to
>>> provide backward compatibility for non-DT drivers.
>>
>>> diff --git a/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt b/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt
>>
>> Rather than putting binding docs in an arch-specific directory, perhaps
>> put them into a device-type-specific directory, such as
>> bindings/interrupt-controller/brcm,bcm63xx-epic.txt?
> 
> Almost everyone has their interrupt-controller bindings in
> $arch/$platform, but if interrupt-controller is the preferred
> location, I can certainly move it there; I have no hard preference for
> any location.

Yes, people have been putting them in arch/platform, but I think there's
a move to more type-based locations.

>>> diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
>>
>>>               ranges = <0 0x10000000 0x20000>;
>>>               compatible = "simple-bus";
>>> +
>>> +             interrupt-parent = <&ipic>;
>>> +
>>> +             perf@0 {
>>> +                     epic: interrupt-controller@18 {
>>
>> Don't you need some reg properties in the perf and interrupt-controller
>> nodes so that the register address can be determined?
> 
> Since there is no support code for that property yet I did not add it.
> I haven't quite finished yet how the final bindings will be (since
> there are/were a few things I haven't finished researching yet, e.g.
> how this controller works in SMP context, and how interrupt
> controllers are supposed to work).
> 
> I can add all expected properties now and add support for them later,
> but I feel that this might add properties that will then never
> supported, and nobody updates the documentation for that, so I'd
> rather like to keep the documentation/dts(i) in sync with what the
> actual code expects/supports.

The DT bindings and DT content are supposed to be fully defined the
first time around, such that even if the kernel doesn't use the reg
property yet, if you were to use the DT created now with a future kernel
that does use the reg property, it's already there.
