Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 18:25:36 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48092 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011831AbaJ2RZeBF2SP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 18:25:34 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so3585513pab.33
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2014 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2giQ+gCv7hgtihhhDFOcYlMMUWyArYRYATQPEM16Viw=;
        b=mwOyUAxvBtgHq1I3G7Icv66DVOUdErj2NdYod35+Zlatsv2Z8RHlT2W8RcfEq/lmlr
         LvNlvwj31TXfkdsQxHsF6bQ6kaNkxP38xFoHv4MfYrhVw2+974vztiaKrSxsHPywbU0e
         CrReXlt+Gln4WhI0Gu7D8yGkIwpDdRmKh5LAQ3Ta7WN19lD2yQ0his7ZLTivmk4eI8A8
         WtWuWYMO6reBf6Mm2+7F4geKhigf6QayClOM0O9h3w2ErrQXaRjWKXDmIBKXQQM3zCKh
         x2l99Tmn7OTW0oG0zgtAqp5OLL72FA90JKRYct39EdKn6q8DgIUzrVOTykN8ki2UtUxE
         oy1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2giQ+gCv7hgtihhhDFOcYlMMUWyArYRYATQPEM16Viw=;
        b=eJOQf+6DzXdPaezNnXRs2OfoFoIaFcrTWA4CLTEUQRpR/tZ0QHh2SlKvkO6JcsUq6a
         /2Km0wIviJKOi+huKBlgY3jkv4tqKZmsYpjqeUkRFvjGY7SqMf8BQcRRcOqwmRXou33u
         nG7AUEsYjX6XuBWVJwjLizOv4cmQRZSl0lprI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2giQ+gCv7hgtihhhDFOcYlMMUWyArYRYATQPEM16Viw=;
        b=hLkgdHTuGQTWkLXsdx4UNycBzYnB9tutN5yBA+ihBeyH9pP34qB7VLd57GF+wvpkvM
         WCoagLhJT7tdj+4/V39Be2PzzKl9ylwUr/BZNe3ot9Wld0GOasH9S+Aqx/RQf/rkn1Kt
         7G3v1y3mgBzUkiLEVDtFDyJ0PlO5d42OMhFng5x2R/rELGkKihvcFVkcXg7vLoooqR02
         xw9AbBl1kaxX1IMxqzdi/Wny/pZZ3XeLg/r1d2uhYemp/+q2oOG77f99ezcAFplzQJ37
         iQYR4jknGWg82gupJ8IoQpjiwHRtcOSTc5E7ukPj6tXuwVd7BNcYYTdASg8GBusCRQmn
         aNnQ==
X-Gm-Message-State: ALoCoQnwgw/R/CTi/xNkv3IwCC01QI6cl2N7Q7F3eayRRshVClQ1iYLH21a/HrmSGmxeBkZ7Xutd
MIME-Version: 1.0
X-Received: by 10.66.157.161 with SMTP id wn1mr11727640pab.40.1414603527602;
 Wed, 29 Oct 2014 10:25:27 -0700 (PDT)
Received: by 10.70.118.170 with HTTP; Wed, 29 Oct 2014 10:25:27 -0700 (PDT)
In-Reply-To: <5451201C.9090106@imgtec.com>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
        <1414541562-10076-3-git-send-email-abrestic@chromium.org>
        <5450B1B1.5070301@imgtec.com>
        <CAL1qeaFeoKFbea7eiiXaw87PYUWO1JmP5xxdLLpW2RrFCprtZg@mail.gmail.com>
        <5451201C.9090106@imgtec.com>
Date:   Wed, 29 Oct 2014 10:25:27 -0700
X-Google-Sender-Auth: RzLYAdF_FXrjFSKL8bRiPcUGvSU
Message-ID: <CAL1qeaEOifj-R2vcWzzh2i5S3ogBf3eZ4X8PbVa1j_BtsgFCwA@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] of: Add binding document for MIPS GIC
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul <Paul.Burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43714
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

On Wed, Oct 29, 2014 at 10:13 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On 29/10/14 16:55, Andrew Bresticker wrote:
>> Hi James,
>>
>> On Wed, Oct 29, 2014 at 2:21 AM, James Hogan <james.hogan@imgtec.com> wrote:
>>> Hi Andrew,
>>>
>>> On 29/10/14 00:12, Andrew Bresticker wrote:
>>>>  - changed compatible string to include CPU version
>>>
>>>> +Required properties:
>>>> +- compatible : Should be "mti,<cpu>-gic".  Supported variants:
>>>> +  - "mti,interaptiv-gic"
>>>
>>>> +Required properties for timer sub-node:
>>>> +- compatible : Should be "mti,<cpu>-gic-timer".  Supported variants:
>>>> +  - "mti,interaptiv-gic-timer"
>>>
>>> Erm, I'm a bit confused...
>>> Why do you include the core name in the compatible string?
>>>
>>> You seem to be suggesting that:
>>>
>>> 1) The GIC/timer drivers need to know what core they're running on.
>>>
>>> Is that really true?
>>
>> They don't now, but it's possible that a future CPU has a newer
>> revision of the GIC which has some differences that need to be
>> accounted for in the driver.
>>
>>> 2) It isn't possible to probe the core type.
>>>
>>> But the kernel already knows this, so what's wrong with using
>>> current_cpu_type() like everything else that needs to know?
>>>
>>> 3) Every new core should require a new compatible string to be added
>>> before the GIC will work. You don't even have a generic compatible
>>> string that DT can specify after the core specific one as a fallback.
>>
>> Yes, adding a generic compatible string would be a good idea.
>>
>>> Please lets not do this unless it's actually necessary (which AFAICT it
>>> really isn't).
>>
>> The point of this was to future-proof these bindings and I though that
>> CPU type was the best way to indicate version in the compatible
>> string.  This is also how it's done for the ARM GIC and arch timers.
>> Perhaps the best thing to do is to require both a core-specific
>> ("mti,interaptiv-gic") and generic ("mti,gic") compatible string and
>> just match on the generic one for now until there's a need to use the
>> core-specific one.  Thoughts?
>
> FPGA boards like Malta are something else to consider (when it is
> eventually converted to DT - Paul on CC knows more than me). You might
> load an interAptiv, or a proAptiv, or a P5600 bitstream, and the gic
> setup will be pretty much the same I think, since e.g. the address
> depends on where it is convenient to put it in the address space of the
> platform.

Ah, I didn't realize that the CPU bitstream could be changed
independently of the GIC.
In that case, the CPU revision isn't that useful.

> Any thoughts on the existence of current_cpu_type(), and the GIC
> revision register? They pretty much make encoding of core in compatible
> string redundant I think.

Ok, I suppose using the revision register is fine then.
