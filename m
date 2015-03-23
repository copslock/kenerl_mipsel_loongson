Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 11:49:04 +0100 (CET)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34235 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008858AbbCWKtBoSnug (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 11:49:01 +0100
Received: by qcay5 with SMTP id y5so50635437qca.1
        for <linux-mips@linux-mips.org>; Mon, 23 Mar 2015 03:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4UwlyQY9FcAiGZz+aCk1Xes7/o5RewfSdGlJRv2C1r4=;
        b=mt8Q2WEqgzXtrOqtyL5vQD9ssuyJl/qtaMv8UFMYxHc+wsjMTlUyhsZgUANZbH0ttd
         vrPUlAj6djktYioHy/6KtOHbbcHOnp7tjZCgu69t8Sm1UCQsvY6z/Jvg9IYOoSbiq50m
         35cuNVZSkUZJpo1WpxPrOXU1dud3/RExii8xbJTVfIaErbISh27QYzE1Smc0DJteWEN6
         kiT/GQ3paHUEbZMkOsXERZ3hBpEEBmW+0U7CtJQrBjBGv7y/J2Dv4YW1RR4i3lqJtzNw
         9QWULgeaq61hd4xUxVP79DAdbEpN4gE0d6qhz+9xYF3dVP2oBYUuVwoSVloYrprtnpws
         ICOQ==
X-Gm-Message-State: ALoCoQkpDCbpRg8tcHmRS3qbunzhOIeVE3rs7WDuz7/Ef5GdAqMpNIrhFquUGTEacsS2LStU1jlv
MIME-Version: 1.0
X-Received: by 10.140.238.139 with SMTP id j133mr121699562qhc.26.1427107736735;
 Mon, 23 Mar 2015 03:48:56 -0700 (PDT)
Received: by 10.96.68.130 with HTTP; Mon, 23 Mar 2015 03:48:56 -0700 (PDT)
In-Reply-To: <550C57E3.60800@gmail.com>
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com>
        <CAPDyKFoZsx_GtGT1NsZnFB9PPWKzsLv8dU26eWcobz4cCdKAOw@mail.gmail.com>
        <550C57E3.60800@gmail.com>
Date:   Mon, 23 Mar 2015 11:48:56 +0100
Message-ID: <CAPDyKFqdOuZfcvdFNq5dw-6k_eES-GMJAtq_V_YtF5AgE4QTig@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: OCTEON: Add host driver for OCTEON MMC controller
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Aleksey Makarov <aleksey.makarov@auriga.com>,
        linux-mmc <linux-mmc@vger.kernel.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Chris Ball <chris@printf.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

[...]

>>> +
>>> +This controller is present on some members of the Cavium OCTEON SoC
>>> +family, provide an interface for eMMC, MMC and SD devices.  There is a
>>> +single controller that may have several "slots" connected.  These
>>
>>
>> Even it it may have several slots, that's not being supported by the
>> mmc core from a MMC/SD/SDIO protocol perspective.
>>
>> We have hade some discussions around this historocally, and I doubt
>> that we ever will be adding this.
>>
>> So, with that in mind I would rather see that you remove the concept
>> of "slot" entirely and thus don't do the DT configuration within a
>> child node.
>
>
> As you note this is a device tree representation, and thus really has
> nothing to do with the capabilities and internal structure of any given
> operating system.
>
> The hardware really is structured as a single controller with a single set
> of registers and register fields that can control multiple "slots".  There
> are not multiple independent slot controllers.
>
> This device tree representation reflects,  with fidelity, the actual
> hardware topology.

I understand, you have point - but...

We can debate whether why you think using a child-node for a slot is
reflecting the hardware better, but I rather don't. Everybody else
isn't using a child node, so I don't think you should.

Moreover in the SDIO case, child nodes of mmc hosts reflects the
actual embedded functional SDIO devices. So if child nodes are going
to be used for anything, it should be to contain properties of an
embedded SD/MMC/SDIO card. At least that's my view.

>
> But none of this matters, because the device tree bindings train has already
> left the station.  You should have expressed opposition to this binding back
> when it was first discussed:
>
> http://www.linux-mips.org/archives/linux-mips/2012-05/msg00119.html

I don't get it. What happened with the RFC above? It wasn't merged for
any release, but the DT-bindings that was proposed was accepted? How
is that possible?

>
> The device tree is deployed in the boot firmware of shipping devices, and we
> are merely documenting what is there.

That's a problem. :-)

[...]

Kind regards
Uffe
