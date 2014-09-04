Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2014 02:06:40 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:44118 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008066AbaIDAGja1M0i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Sep 2014 02:06:39 +0200
Received: by mail-ig0-f172.google.com with SMTP id h15so165050igd.11
        for <multiple recipients>; Wed, 03 Sep 2014 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d5RqXkNw8VVKxodTNLlEmrp9VxV7X1JjYrsAlwtlkko=;
        b=XvGmdcqvucDP86NtHqvtj9xxqChdpB1N7edDF6PKVSpTzvrQIwDt5f1miS3qko+U3T
         es7TPrZbOQjtOLbLHpXQOgV93l8CQHTHorrkQN2PvZWYaVI0KfR7P8D4f8wsGJz3NfUE
         UE1cPI8eNmhhu/FZHdh3GJLvIJrO52ghkerP+ozLLbbxGcD+8xNR1rcCT1RQDFePzexE
         jN57nvZBorIX2P4xPWekKug+Ebll4qjKP0m+BNnmtpYASejIR2+BGnRQlEtm3VXBZuln
         Grn7lqlG3UV0/AzqBpbktNnOb9HwULbZ7xIB7j70Me/ZHNElkzSFg6ez5FNveXpn1z6N
         5U5w==
X-Received: by 10.50.67.51 with SMTP id k19mr823271igt.39.1409789193346;
        Wed, 03 Sep 2014 17:06:33 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p5sm6907084iga.5.2014.09.03.17.06.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Sep 2014 17:06:32 -0700 (PDT)
Message-ID: <5407AD06.6070402@gmail.com>
Date:   Wed, 03 Sep 2014 17:06:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
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
Subject: Re: [PATCH 03/12] of: Add binding document for MIPS GIC
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org> <1409350479-19108-4-git-send-email-abrestic@chromium.org> <5405FE07.4030400@gmail.com> <CAL1qeaHcV_4Z9n_THEN_aST3smgaW1vwn81SkmbU0AUJ_rdB1Q@mail.gmail.com> <540665BA.3080702@gmail.com> <CAL1qeaG_vSiBToi9ZU2=+Guj98gWE_AgmrR7=Z6-PxSNfdH9sA@mail.gmail.com>
In-Reply-To: <CAL1qeaG_vSiBToi9ZU2=+Guj98gWE_AgmrR7=Z6-PxSNfdH9sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 09/03/2014 04:53 PM, Andrew Bresticker wrote:
> On Tue, Sep 2, 2014 at 5:50 PM, David Daney <ddaney.cavm@gmail.com> wrote:
[...]
>>
>> Your comments don't really make sense to me in the context of my knowledge
>> of the GIC.
>>
>> Of course all the CP0 timer and performance counter interrupts are per-CPU
>> and routed directly to the corresponding CP0_Cause[IP7..IP2] bits.  We are
>> don't need to give them further consideration.
>>
>>
>> Here is the scenario you should consider:
>>
>>    o 16 CPU cores.
>>    o 1 GIC routing interrupts from external sources to the 16 CPUs.
>>    o 2 network controllers each with an interrupt line routed to the GIC.
>>
>> Q: What would the GIC "interrupts" property look like?
>>
>> Note that the GIC doesn't have a single "interrupt-parent", as it can route
>> interrupts to *all* 16 CPUs.
>>
>> I propose that the GIC have neither an "interrupt-parent", nor "interrupts".
>> The fact that it is an "mti,global-interrupt-controller", means that the
>> software drivers for the GIC already know how to route interrupts, and any
>> information the device tree could contain is redundant.
>
> Ok, I misunderstood your opposition to the binding.
>
> My intention for the "interrupt-parent" and "interrupts" property of
> the GIC was to express that GIC interrupts are routed to the CPU
> interrupt vectors and that a certain set of these vectors are
> available for use by the GIC.  I would agree that these are mostly
> redundant (obviously the GIC routes interrupts to CPU interrupt
> vecotrs) and that it is not the most accurate description of the
> GIC-CPU relationship (the CPU interrupt controller are per-CPU, not
> global, and the GIC can route interrupts to any of them), though I'm
> not sure that there's a better way of describing it in DT.
>
> So that leaves us with something like this:
>
> interrupt-controller@1bdc0000 {
>          compatible = "mti,global-interrupt-controller";
>
>          interrupt-controller;
>          #interrupt-cells = <2>;
>
>          available-cpu-vectors = <2>, <3>, ...


Exactly what I had in mind, except for the missing "reg" property.

This gives software the information it needs, but doesn't impose any policy.

I will defer to others on the exact name the "available-cpu-vectors" 
should have.




> };
>
> DT folks, thoughts?
>
>
