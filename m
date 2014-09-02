Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2014 21:36:43 +0200 (CEST)
Received: from mail-vc0-f171.google.com ([209.85.220.171]:38681 "EHLO
        mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007935AbaIBTgl0p8kY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2014 21:36:41 +0200
Received: by mail-vc0-f171.google.com with SMTP id id10so7626525vcb.16
        for <linux-mips@linux-mips.org>; Tue, 02 Sep 2014 12:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8qpCdw2Q9sQ+1gejQMHowRKCNN/tmJw+R5tecdHh9Tg=;
        b=LfKIxBz+Y23U0G3v2V7E2uA4FA+or2LYVIvAkv3d0xSCiqLQJG8YYCAta7uSqyOK0Y
         GeW2DyPU4r2HLjZkpm3ntQFTpUnuFQ0yLCXN51yodpJYY4RvchqL7rU+UhOQpfCfW1oq
         80wQK2KNHn9qHdeaZZr2g8nJ2uktOyyhzGAFJLSnCiiD8+JG8WomV2fx1epn2Y33nyx+
         I0CxVCmcctCgh7nrB9pPVm37RLcPnI5M8sa12Lx98l9LouGrcaLN6XtpdgVNMYqP0P44
         iWit9U0/DCUCKAKODwK6GKXxmRfMtsVeT4JppsezLJO1qQDnV9a4os+iAgCfEk3v28dD
         U6YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8qpCdw2Q9sQ+1gejQMHowRKCNN/tmJw+R5tecdHh9Tg=;
        b=eGcFIcP1hhxHfF0dA+10ZqqzfzLx7OffWs2u3rRljDwIZp7H1pIy3WY19DOhjT03YU
         8gWMBSkcarZCN1kooDuM1gZ0iCNwmUu/N5RoUxFfsrJMiUmifIbInQ4NjkgaRxTPgXlA
         Ocd+Xsi/64fjaZsYIB4krLAIzgLhxZpWp1KVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8qpCdw2Q9sQ+1gejQMHowRKCNN/tmJw+R5tecdHh9Tg=;
        b=i0JCRHn80QIfPsXFz/YvzBC72ZVnEn9XMHejTfErZDAYM2CVCJ6Kh2AFXFwm7VYvdh
         xc5EJbO7wOFo4Ddwosn8RPXhAUibQM1X9JDR0WJMkqpAljSoz3C95fuIU3/tNIPopGdE
         GlO6qmVP+g+hQ5uNTprsiC0SsNuOizwsEvS36WcWmlgBYc6KLaEy0GpIKtSzNVRttrS9
         R9vVJ1zYuE7ng5sLEy5jWGZ2HyMFX93zpThRsNDCmRH3dXd5BwbkE19XjMpDnnihGSYU
         9hayGxbNYb+NbLF2n+zbfuarSXc+8l1j/bfpnQs8gd6E3HTE5PNwP4ji/RzdI1uAzVzD
         PsxQ==
X-Gm-Message-State: ALoCoQnqDer0cXZW0g6994Insay/Ozao/oQz3a9WlxoLpqleNsTBzfmT7ew3ACKBi5iJAMQQ1ucU
MIME-Version: 1.0
X-Received: by 10.220.97.5 with SMTP id j5mr31692273vcn.16.1409686595404; Tue,
 02 Sep 2014 12:36:35 -0700 (PDT)
Received: by 10.52.51.194 with HTTP; Tue, 2 Sep 2014 12:36:35 -0700 (PDT)
In-Reply-To: <5405FE07.4030400@gmail.com>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <1409350479-19108-4-git-send-email-abrestic@chromium.org>
        <5405FE07.4030400@gmail.com>
Date:   Tue, 2 Sep 2014 12:36:35 -0700
X-Google-Sender-Auth: 2r_FbelVnA0mt4NUtrECEqmy22Q
Message-ID: <CAL1qeaHcV_4Z9n_THEN_aST3smgaW1vwn81SkmbU0AUJ_rdB1Q@mail.gmail.com>
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
X-archive-position: 42370
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

On Tue, Sep 2, 2014 at 10:27 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 08/29/2014 03:14 PM, Andrew Bresticker wrote:
>>
>> The Global Interrupt Controller (GIC) present on certain MIPS systems
>> can be used to route external interrupts to individual VPEs and CPU
>> interrupt vectors.  It also supports a timer and software-generated
>> interrupts.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>   Documentation/devicetree/bindings/mips/gic.txt | 50
>> ++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mips/gic.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mips/gic.txt
>> b/Documentation/devicetree/bindings/mips/gic.txt
>> new file mode 100644
>> index 0000000..725f1ef
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/gic.txt
>> @@ -0,0 +1,50 @@
>> +MIPS Global Interrupt Controller (GIC)
>> +
>> +The MIPS GIC routes external interrupts to individual VPEs and IRQ pins.
>> +It also supports a timer and software-generated interrupts which can be
>> +used as IPIs.
>> +
>> +Required properties:
>> +- compatible : Should be "mti,global-interrupt-controller"
>> +- reg : Base address and length of the GIC registers.
>> +- interrupts : Core interrupts to which the GIC may route external
>> interrupts.
>
>
> This doesn't make sense to me.  The GIC can, and does, route interrupts to
> all CPU cores in a SMP system.  How can there be a concept of only
> associating it with several interrupt lines on a single CPU in the system?
> That is not what the GIC does, is it?  It is a Global interrupts controller,
> not local.  So specifying device tree bindings that don't show its Global
> nature seems wrong.

While the GIC can route external interrupts to any HW interrupt vector
it may not make sense to actually use all those vectors.  For example,
the CP0 timer is usually hooked up to HW vector 5 (it could be treated
as a GIC local interrupt, though it may still be fixed to HW vector
5).  BTW, the Malta example about the i8259 I gave before was wrong -
it appears that it actually gets chained with the GIC.

What would you suggest instead?  Route all GIC interrupts to a single
vector?  Attempt to distribute them over all 6 vectors?

>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt specifier.  Should be 3.
>> +  - The first cell is the GIC interrupt number.
>> +  - The second cell encodes the interrupt flags.
>> +    See <include/dt-bindings/interrupt-controller/irq.h> for a list of
>> valid
>> +    flags.
>> +  - The optional third cell indicates which CPU interrupt vector the GIC
>> +    interrupt should be routed to.  It is a 0-based index into the list
>> of
>> +    GIC-to-CPU interrupts specified in the "interrupts" property
>> described
>> +    above.  For example, a '2' in this cell will route the interrupt to
>> the
>> +    3rd core interrupt listed in 'interrupts'.  If omitted, the interrupt
>> will
>> +    be routed to the 1st core interrupt.
>> +
>
>
> This seems like a really convoluted way of doing things that really goes
> against the device tree model.
>
> The routing of interrupts through the GIC to a core interrupt is controlled
> entirely within the GIC hardware and therefore should be a property of the
> GIC itself, not all the random devices connected upstream to the GIC.
>
> It also places policy about the priority of the various interrupts into the
> device tree.  Typically the device tree would contain only information about
> the topology of the hardware blocks, not arbitrary policy decisions that
> software could change and still have a perfectly functional system.
>
> Therefore I would recommend removing the third cell from the interrupt
> specifier.

As Mark mentioned, putting priority policy in the DT is a bit of a
gray area.  Since I don't see any need for it currently, I've decided
to drop it.
