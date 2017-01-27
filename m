Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2017 12:18:54 +0100 (CET)
Received: from mail-it0-x22a.google.com ([IPv6:2607:f8b0:4001:c0b::22a]:38079
        "EHLO mail-it0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdA0LSpsNblI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jan 2017 12:18:45 +0100
Received: by mail-it0-x22a.google.com with SMTP id c7so53622143itd.1
        for <linux-mips@linux-mips.org>; Fri, 27 Jan 2017 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pqR2/HFXheLVkK04Qhv0YwnP51UUGiTZz2Pq7MBhNK8=;
        b=Im9pYB0KcHk+HC+6Pn1FN0pIkJJ+Rt6I4fKGfvYf8AP4/CJsEiZNaEcGmqua22UJNG
         cZppmbI49VAFXHoU/sM2zuZu4Y2AGEIBkKjMCQOV3uyRhd9EXQxGi8yQdftFq3Q1avI8
         Ax79lZSC4bhudBel65CDEco7m9ku33hrikMKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pqR2/HFXheLVkK04Qhv0YwnP51UUGiTZz2Pq7MBhNK8=;
        b=Hx0QzX1IgP9gv0jsEtkCHncAVEQgLWLAbI9MwhjsxS5S52uIDSpiNH7ez4enyClr93
         J5ZGBYZ/GmEB6/o7cJwMQ7AKuuPUzvOSBmOShxDArR7FKVJNlysChgTCRatnfDaYfswT
         KlDt6Sj4u4jY/4v3YglZiT6+r8f15CMQUBXX7/8I7L5sL7Vu6ujkFRMeH2yZTLQ8198Q
         oRDABcGUZq0Xg0R1G8JgpZ4FEarTf6NW3r+Rn8PSgEkuTROzh1Qjub2AcXrZ350qdF5+
         shYIAYwvTY1ilT/z+w4HMyEeSYPJu81SYfEQ1icMER0aWQLrSHOAcK0gGuVnCFMY7f5f
         grqQ==
X-Gm-Message-State: AIkVDXJps/4azccHAZ3Bgo43SjkAM1oqSRVts7CW96K2lxidpN2+oYtjYx8z0eVVaMeGGNgOz5xOAVcxPWhFk5aT
X-Received: by 10.36.33.135 with SMTP id e129mr2514900ita.9.1485515919962;
 Fri, 27 Jan 2017 03:18:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Fri, 27 Jan 2017 03:18:39 -0800 (PST)
In-Reply-To: <20170122144947.16158-2-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net> <20170122144947.16158-2-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2017 12:18:39 +0100
Message-ID: <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
X-archive-position: 56522
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

On Sun, Jan 22, 2017 at 3:49 PM, Paul Cercueil <paul@crapouillou.net> wrote:


> +Required properties:
> +- compatible: One of:
> +  - "ingenic,jz4740-pinctrl"
> +  - "ingenic,jz4780-pinctrl"
> +
> +Optional properties:
> +- ingenic,pull-ups: A list of 32-bit bit fields, where each bit set tells the
> +  driver that a pull-up resistor is available for this pin.
> +  By default, the driver considers that all pins feature a pull-up resistor.
> +- ingenic,pull-downs: A list of 32-bit bit fields, where each bit set tells
> +  the driver that a pull-down resistor is available for this pin.
> +  By default, the driver considers that all pins feature a pull-down
> +  resistor.

So I still don't understand these properties.

Does this mean that there is a pull-up *inside* the SoC or *outside*
on the board where it is mounted?

If it is *outside* the SoC, on the board, the pulls should be set on
the consumers, not on the controller.

In the former case, if this pertains to the *inside* of the SoC:
is it just different between jz4740 and jz4780?
In that case, just code this into the driver as .data to the .compatible
in the DT match. No special DT properties needed.

If it is different between e.g. different versions of jz4740, why not
make different compatible-properties? If there are different versions
of the circuit, with different hard-wired hardware configuration, they
are different devices and should have different compatible strings.

> +                               /* CLK, CMD, D0 */
> +                               ingenic,pins = <0x69 0 0x68 0 0x6a 0>;

Standard bindings use just "pins". Why the custom ingenic,
prefix?

Yours,
Linus Walleij
