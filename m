Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 14:10:08 +0100 (CET)
Received: from mail-it0-x22f.google.com ([IPv6:2607:f8b0:4001:c0b::22f]:35310
        "EHLO mail-it0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993878AbdAaNKB1t7vq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 14:10:01 +0100
Received: by mail-it0-x22f.google.com with SMTP id 203so216116523ith.0
        for <linux-mips@linux-mips.org>; Tue, 31 Jan 2017 05:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fo0K65OHtHFhXWPezA18XGVy0RNw0D4JUjdwkt0DR5w=;
        b=FlAdzuTN7F1xP3mWEYGIxgS9BU8bSOXnn5Vxg2wP9maqKYg5rtn8jVicioXLQ2luo5
         KEwrZDEjVyHnPnqsFbpyKbBa/NEu8e7Up5b3NO9RIRArdUmk8ZPqwEdoR+glm4awEZpQ
         D3PBi+/2cQxIgJZ/9mHkuvNA9/64FEHSbcaDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fo0K65OHtHFhXWPezA18XGVy0RNw0D4JUjdwkt0DR5w=;
        b=O3pFm6Jem0xIQGp3HmyitcY5YPyZZkPVK7MS5/pasdW4Ajek/LBMI2TrRMvpqZqTNU
         lLc0EiZvyzt00+FJ+8AbsdKPRPRXOKbi/qC5sd/QQ7DSMl8TIhpT2lUu9jhPRZH9G/z8
         /YtVCKbVKXEZh0rFpiRe53lvz2plahMXeV623qyiDXO80th5jL7FFHYBi99qxkC0s6N6
         wbweBin5yeXvzZHX/A/LOtdErCAF9L9cdfzmzZKetIZurNnOEnJmuTIOjpyvswEsqKcp
         bgzwT5zQQTu3EGJNsy7+wkv1Im86r1Fev//2cYdQ5t9COyKs2UyKhZ5ECNiHc0VS1454
         xj1g==
X-Gm-Message-State: AIkVDXL+EA3xuCOB1bYiRqAn0hIBi/FbJJTAi1S33ozBdayRL494IXB8BrzLQkDstlQQO803GT1S3sHeTvSqMfPu
X-Received: by 10.36.26.9 with SMTP id 9mr19935780iti.25.1485868195647; Tue,
 31 Jan 2017 05:09:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Tue, 31 Jan 2017 05:09:54 -0800 (PST)
In-Reply-To: <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop> <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2017 14:09:54 +0100
Message-ID: <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Tue, Jan 31, 2017 at 11:31 AM, Paul Cercueil <paul@crapouillou.net> wrote:
> [Rob]:
>> From the overlapping register addresses in the examples and this
>> description, it looks like the pinctrlr and gpio controller are 1 block.
>> If so, then there should only be 1 node.
>
> Well, that's what I had until Linus W. just told me to do the opposite:
>
>> Just pull all these down two levels and make them one device
>> each instead of having them inside the pin controller node
>> like this.

I guess the argument is that they are in the same coherent memory
range so they should be one device node. That is how we handle
e.g. system controllers so it makes some sense.

So can the two GPIO controllers be modeled as two subnodes of
the pin controller then?

Subnodes are certainly OK, we have that for many other devices
such as interrupt controllers on PCI bridges and what not.

So when the probing of the pin controller is ready it can just
walk down and populate the GPIO subdevices with
of_platform_default_populate() or simply by registering the
device directly with platform_device_add_data() just like an
MFD device does?

This is nice because we want to use the standard gpio ranges
to map pins to GPIO lines.

I'm sorry about the unclarities here, but it's essentially an intrinsic
problem with GPIO that has been with us for years: do we model
each "bank" as a device or do we just register each bank as a
gpiochip, or do we even make one gpiochip to cover all the banks.
All solutions can be found in the kernel... also the different DT bindings:
one node for a whole slew of GPIO controllers, or seveal nodes
and I bet also several nodes for memory ranges in close proximity.

I don't know for sure what is the most elegant solution, we might
need to build some consensus here for the future so it doesn't
get to heterogeneous.

Yours,
Linus Walleij
