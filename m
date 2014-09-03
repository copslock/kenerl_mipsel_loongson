Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2014 01:53:51 +0200 (CEST)
Received: from mail-vc0-f178.google.com ([209.85.220.178]:38739 "EHLO
        mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008066AbaICXxtpRdfx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Sep 2014 01:53:49 +0200
Received: by mail-vc0-f178.google.com with SMTP id la4so9946253vcb.9
        for <linux-mips@linux-mips.org>; Wed, 03 Sep 2014 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H6zohop+0tZM9IV+Gr8P0ajlCVXsytzimwC81ePUMdo=;
        b=pjWISdJmvRKmL+Xw7bSww+Q+TZvPIfM0eefapEzic6ffohPLWU1odgGXCNKDoPuXCN
         cpCvegPejRarU4dk2Hkr2nf4mnjCnjTuMD7LmgVINDU6JcfA7f04DD115OmrQQ6xzYSq
         rYwEkdn8Pj6zW53xNfr/PrAfjYKZDrG76vHSxqd/DvisjGkfWTIyNjJgYlWGOtF4OOZV
         yQl7f8H/MoMLaYAUKv1chizQ8f7PCH1Jq0JxUMOj029MuVPp/lqNszt4KFTFRJFs0gsk
         TUwlFkbtHNKm3EfcUNDMQFAuVVa+v7V99QaqAUBsBbfwLG/c4VsMefPPCO93UDB4EBvB
         mKYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H6zohop+0tZM9IV+Gr8P0ajlCVXsytzimwC81ePUMdo=;
        b=Hbc4mWsl8R1zdISqee+w4PocAVhPrfzzEwigWVvbg3mFaVD0JwGhOs7V6lzSlUwiky
         gzfc1HouccFF2pzR1ivoPMYUQOYeAjoGWzJjnrqO7Yfu1WuNUxCuclDCVoPkCf1Hqpzf
         sGhqs2/BjjbzGrnWWVBsYeRZAurzgSMaA2ZEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H6zohop+0tZM9IV+Gr8P0ajlCVXsytzimwC81ePUMdo=;
        b=aoX+VF4F2CpK6qCm3hx9DLs5OKtaQj0vmdiFFKbWyTfZf0ZXV6caMWk3uyZ34PRkSg
         4w8UWMRl4bBrDMmB18c6BziKzvhlKkAzawA8yu7ceFv9IEQpaPfOAePMRYSynq1LsSeG
         XcJRx4He0eXsz/wxULK9Huw9BLxD625ouHZXfzBtE4n78P50Ej9OwforP181jDX/ZHfQ
         YSS7AH2fxELgG/6qn3f+xCPOM4+94K8PJ1iwFJ2+pUqA4pt0w8rWEb4d5zXA6JAea6Hw
         OLhW0urcQaIcd8nMgZ1/GF4NuYIsuK8psByaLEGofkZXgsUq5UUzsyF0alT0Cc76apEY
         la4A==
X-Gm-Message-State: ALoCoQm8BHCxjeB65X/qQybkb1fYCFU0nzoIxlCKkAkKs2UKvQUKkL80dN+ceK2EhAut5Vu/cd/o
MIME-Version: 1.0
X-Received: by 10.52.61.136 with SMTP id p8mr407519vdr.15.1409788422718; Wed,
 03 Sep 2014 16:53:42 -0700 (PDT)
Received: by 10.52.51.194 with HTTP; Wed, 3 Sep 2014 16:53:42 -0700 (PDT)
In-Reply-To: <540665BA.3080702@gmail.com>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <1409350479-19108-4-git-send-email-abrestic@chromium.org>
        <5405FE07.4030400@gmail.com>
        <CAL1qeaHcV_4Z9n_THEN_aST3smgaW1vwn81SkmbU0AUJ_rdB1Q@mail.gmail.com>
        <540665BA.3080702@gmail.com>
Date:   Wed, 3 Sep 2014 16:53:42 -0700
X-Google-Sender-Auth: H5sZMU-U74C7XVRXa7ycJC-tg58
Message-ID: <CAL1qeaG_vSiBToi9ZU2=+Guj98gWE_AgmrR7=Z6-PxSNfdH9sA@mail.gmail.com>
Subject: Re: [PATCH 03/12] of: Add binding document for MIPS GIC
From:   Andrew Bresticker <abrestic@chromium.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42386
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

On Tue, Sep 2, 2014 at 5:50 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 09/02/2014 12:36 PM, Andrew Bresticker wrote:
>>
>> On Tue, Sep 2, 2014 at 10:27 AM, David Daney <ddaney.cavm@gmail.com>
>> wrote:
>>>
>>> On 08/29/2014 03:14 PM, Andrew Bresticker wrote:
>>>>
>>>>
>>>> The Global Interrupt Controller (GIC) present on certain MIPS systems
>>>> can be used to route external interrupts to individual VPEs and CPU
>>>> interrupt vectors.  It also supports a timer and software-generated
>>>> interrupts.
>>>>
>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/mips/gic.txt | 50
>>>> ++++++++++++++++++++++++++
>>>>    1 file changed, 50 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/mips/gic.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mips/gic.txt
>>>> b/Documentation/devicetree/bindings/mips/gic.txt
>>>> new file mode 100644
>>>> index 0000000..725f1ef
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mips/gic.txt
>>>> @@ -0,0 +1,50 @@
>>>> +MIPS Global Interrupt Controller (GIC)
>>>> +
>>>> +The MIPS GIC routes external interrupts to individual VPEs and IRQ
>>>> pins.
>>>> +It also supports a timer and software-generated interrupts which can be
>>>> +used as IPIs.
>>>> +
>>>> +Required properties:
>>>> +- compatible : Should be "mti,global-interrupt-controller"
>>>> +- reg : Base address and length of the GIC registers.
>>>> +- interrupts : Core interrupts to which the GIC may route external
>>>> interrupts.
>>>
>>>
>>>
>>> This doesn't make sense to me.  The GIC can, and does, route interrupts
>>> to
>>> all CPU cores in a SMP system.  How can there be a concept of only
>>> associating it with several interrupt lines on a single CPU in the
>>> system?
>>> That is not what the GIC does, is it?  It is a Global interrupts
>>> controller,
>>> not local.  So specifying device tree bindings that don't show its Global
>>> nature seems wrong.
>>
>>
>> While the GIC can route external interrupts to any HW interrupt vector
>> it may not make sense to actually use all those vectors.  For example,
>> the CP0 timer is usually hooked up to HW vector 5 (it could be treated
>> as a GIC local interrupt, though it may still be fixed to HW vector
>> 5).  BTW, the Malta example about the i8259 I gave before was wrong -
>> it appears that it actually gets chained with the GIC.
>
>
> Your comments don't really make sense to me in the context of my knowledge
> of the GIC.
>
> Of course all the CP0 timer and performance counter interrupts are per-CPU
> and routed directly to the corresponding CP0_Cause[IP7..IP2] bits.  We are
> don't need to give them further consideration.
>
>
> Here is the scenario you should consider:
>
>   o 16 CPU cores.
>   o 1 GIC routing interrupts from external sources to the 16 CPUs.
>   o 2 network controllers each with an interrupt line routed to the GIC.
>
> Q: What would the GIC "interrupts" property look like?
>
> Note that the GIC doesn't have a single "interrupt-parent", as it can route
> interrupts to *all* 16 CPUs.
>
> I propose that the GIC have neither an "interrupt-parent", nor "interrupts".
> The fact that it is an "mti,global-interrupt-controller", means that the
> software drivers for the GIC already know how to route interrupts, and any
> information the device tree could contain is redundant.

Ok, I misunderstood your opposition to the binding.

My intention for the "interrupt-parent" and "interrupts" property of
the GIC was to express that GIC interrupts are routed to the CPU
interrupt vectors and that a certain set of these vectors are
available for use by the GIC.  I would agree that these are mostly
redundant (obviously the GIC routes interrupts to CPU interrupt
vecotrs) and that it is not the most accurate description of the
GIC-CPU relationship (the CPU interrupt controller are per-CPU, not
global, and the GIC can route interrupts to any of them), though I'm
not sure that there's a better way of describing it in DT.

So that leaves us with something like this:

interrupt-controller@1bdc0000 {
        compatible = "mti,global-interrupt-controller";

        interrupt-controller;
        #interrupt-cells = <2>;

        available-cpu-vectors = <2>, <3>, ...
};

DT folks, thoughts?
