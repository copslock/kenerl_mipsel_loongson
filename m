Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2014 18:36:38 +0200 (CEST)
Received: from mail-vc0-f178.google.com ([209.85.220.178]:61083 "EHLO
        mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007935AbaIBQggbNilu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2014 18:36:36 +0200
Received: by mail-vc0-f178.google.com with SMTP id la4so7191678vcb.23
        for <linux-mips@linux-mips.org>; Tue, 02 Sep 2014 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QA7K6Yskb3WMtn4E2VKtNSMfEb0Bpl8JIS2Sm+3KE1s=;
        b=dDoJF3cEcmyKOowzuLXhQslgBJuC8/7Ls8etwvzySr3ILlCFY8NeOoNy55YWqJNY6P
         NZYXbUzFe17lfSGgMYYvfqrSfSbB3MDTI39nsadiUGx7o1Yx6qlEXAPDAyVtSyE8wi+q
         ivdiGg1W6iuKf28Vu/IXxbMM9B9KzlvukJ3ZUCgd7KU4DCYSjrY7InGrI7gUoDUGqu4e
         +Dbi4tU/kgvY+nBo3slFQyEqzNgahuGPU4Pj5Nz48Xpg94PCy803yyudDPKEiMHFTXlb
         U7pDRsg+egzDDzFMPQ3Xlem+yzqrv/nliJAY05iU6wliA3yZd/OP20YVjL93JHj8FvLm
         xglw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QA7K6Yskb3WMtn4E2VKtNSMfEb0Bpl8JIS2Sm+3KE1s=;
        b=LfUBJ6efT7OTycl2eAemzNfNWuvSnK4yRLNQ6QiB20EgB+hSdDHOkK8retLe1639XE
         OSqRQ88bcrxbc9iZnhnzv2nNAn8txNyx3QqtaR72vrWEy/Lvw4YIK0kObLtTpiDpUCNQ
         lYazKqnGhvi0ZPhx+UL9Ikm/7mBYvvR88WM4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QA7K6Yskb3WMtn4E2VKtNSMfEb0Bpl8JIS2Sm+3KE1s=;
        b=b+qRL/qCeWnC1IQw+u80R3UldWCJEtevrQPkguQlYV08mraZlQDBZVaILbb8rFTQU5
         XEH1PUlxJuZNHclh0fbff0DuhBWew9hl7UxwCLiYN+PlSsTkYVrwl39/ZzWAj85RsOTT
         Pn1MvTuq7vLsEDDfsImR0ELYWGF4vIprqHSICM7eQLnKBI4IqSobk503kWmyhyuQv5Oh
         zl6j/0Yqax+pnD2qausRLxJHNh3wAPvzx8VIbAJWbuYucCIganajIiDNFauxLQorH/it
         S3Qac+bjBR6JFg6XNZ67wJ/dzYU9915LJRq6L21ChVXwi4mJkHlD6n60HwqjAimbzs08
         ohzw==
X-Gm-Message-State: ALoCoQnR/wQhZqcfAguu9hz6Uy2QFdIU9dUvx+6f1150Ec+/6FreuYuGTvZ69Fwg/s+HeVnsBgWA
MIME-Version: 1.0
X-Received: by 10.220.105.201 with SMTP id u9mr31001407vco.11.1409675790501;
 Tue, 02 Sep 2014 09:36:30 -0700 (PDT)
Received: by 10.52.51.194 with HTTP; Tue, 2 Sep 2014 09:36:30 -0700 (PDT)
In-Reply-To: <20140902093330.GA6595@leverpostej>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <1409350479-19108-4-git-send-email-abrestic@chromium.org>
        <20140901110119.GB6617@leverpostej>
        <CAL1qeaH97fL3x689-FwOxRZWS2-6CDzzzJX3xEKdvULHoxjMLA@mail.gmail.com>
        <20140902093330.GA6595@leverpostej>
Date:   Tue, 2 Sep 2014 09:36:30 -0700
X-Google-Sender-Auth: LaRba6yNVryZOr7kZlKuObqRlx0
Message-ID: <CAL1qeaFwaMkZ-960ON2doHFXBHJdg-obHopfiDOXCskKbMZppg@mail.gmail.com>
Subject: Re: [PATCH 03/12] of: Add binding document for MIPS GIC
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Sep 2, 2014 at 2:33 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Sep 02, 2014 at 01:53:18AM +0100, Andrew Bresticker wrote:
>> On Mon, Sep 1, 2014 at 4:01 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Aug 29, 2014 at 11:14:30PM +0100, Andrew Bresticker wrote:
>> >> The Global Interrupt Controller (GIC) present on certain MIPS systems
>> >> can be used to route external interrupts to individual VPEs and CPU
>> >> interrupt vectors.  It also supports a timer and software-generated
>> >> interrupts.
>> >>
>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> >> ---
>> >>  Documentation/devicetree/bindings/mips/gic.txt | 50 ++++++++++++++++++++++++++
>> >>  1 file changed, 50 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/mips/gic.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mips/gic.txt b/Documentation/devicetree/bindings/mips/gic.txt
>> >> new file mode 100644
>> >> index 0000000..725f1ef
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/mips/gic.txt
>> >> @@ -0,0 +1,50 @@
>> >> +MIPS Global Interrupt Controller (GIC)
>> >> +
>> >> +The MIPS GIC routes external interrupts to individual VPEs and IRQ pins.
>> >> +It also supports a timer and software-generated interrupts which can be
>> >> +used as IPIs.
>> >> +
>> >> +Required properties:
>> >> +- compatible : Should be "mti,global-interrupt-controller"
>> >
>> > I couldn't find "mti" in vendor-prefixes.txt (as of v3.17-rc3). If
>> > there's not a patch to add it elsewhere, would you mind providing one
>> > with this series?
>>
>> Sure.  As James points out, "img" could also be used but I chose "mti"
>> since the CPU interrupt controller also uses "mti" and I believe the
>> GIC IP was developed before the acquisition by Imagination (though I'm
>> not sure if that actually matters).
>
> Using 'mti' sounds like the right choice to me given both of those
> points.
>
>> >> +- reg : Base address and length of the GIC registers.
>> >> +- interrupts : Core interrupts to which the GIC may route external interrupts.
>> >
>> > How many?
>>
>> Up to 6, one for each of the possible core hardware interrupts (i.e.
>> interrupt vectors 2 - 7).  Which ones are available to the GIC depend
>> on the system, for example Malta has an i8259 PIC hooked up to CPU
>> interrupt vector 2, so that vector should not be used by the GIC.
>>
>> > In any order?
>>
>> They can technically be in any order, but when in strictly
>> increasing/decreasing order they can be used along with the 3rd cell
>> (described below) to prioritize interrupts.
>
> Ok. Could you try to place that into the property description?
>
>> >> +- interrupt-controller : Identifies the node as an interrupt controller
>> >> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> >> +  interrupt specifier.  Should be 3.
>> >> +  - The first cell is the GIC interrupt number.
>> >> +  - The second cell encodes the interrupt flags.
>> >> +    See <include/dt-bindings/interrupt-controller/irq.h> for a list of valid
>> >> +    flags.
>> >
>> > Are all the flags valid for this interrupt controller?
>>
>> Yes.
>
> Ok.
>
>> >> +  - The optional third cell indicates which CPU interrupt vector the GIC
>> >> +    interrupt should be routed to.  It is a 0-based index into the list of
>> >> +    GIC-to-CPU interrupts specified in the "interrupts" property described
>> >> +    above.  For example, a '2' in this cell will route the interrupt to the
>> >> +    3rd core interrupt listed in 'interrupts'.  If omitted, the interrupt will
>> >> +    be routed to the 1st core interrupt.
>> >
>> > I don't follow why this should be in the DT. Why is this necessary?
>>
>> Since the GIC can route external interrupts to any of the CPU hardware
>> interrupt vectors, it can be used to assign priorities to external
>> interrupts.  If the CPU is in vectored interrupt mode, the highest
>> numbered interrupt vector (7) has the highest priority.  An example:
>>
>> gic: interrupt-controller@1bdc0000 {
>>         ...
>>         interrupts = <3>, <4>;
>>         ...
>> };
>>
>> uart {
>>         ...
>>         interrupt-parent = <&gic>;
>>         interrupts = <24 IRQ_TYPE_LEVEL_HIGH 1>;
>>         ...
>> };
>>
>> i2c {
>>         ...
>>         interrupt-parent = <&gic>;
>>         interrupts = <33 IRQ_TYPE_LEVEL_HIGH 0>;
>>         ...
>> };
>>
>> Since the third cell for the UART is '1', it maps to CPU interrupt
>> vector 4 and thus has a higher priority than the I2C (whose third cell
>> is 0, mapping to CPU interrupt vector 3).
>>
>> Perhaps, though, this is an instance of software policy being
>> specified in device-tree.  Other options would be to a) evenly
>> distribute the GIC external interrupts across the CPU interrupt
>> vectors available to the GIC, or b) just map all GIC external
>> interrupts to a single interrupt vector.
>
> As a user I don't see why the DT author should be in charge of whether
> my UART gets higher priority than my I2C controller. That priority is
> not a fixed property of the interrupt (as the line and flags are).
>
> That said, this is a grey area. Are there any cases where this
> prioritisation is critical on existing devices?

I am not aware of any boards for which this is critical.  Malta and
SEAD-3 are development boards and do not appear to need any sort of
prioritization of GIC interrupts.  John Crispin is working on a
Mediatek board which has a GIC, but it looks like all external
interrupts are routed to a single CPU vector.  It's possible that it
could be useful on the platform I'm working on, though it's looking
more and more unlikely.

Given all that, perhaps it's better to stick with the 2-cell
(no-prioritization) binding for now and add the 3-cell binding later
if necessary.
