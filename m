Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 19:34:22 +0100 (CET)
Received: from mail-vc0-f169.google.com ([209.85.220.169]:50097 "EHLO
        mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006899AbaKXSeVL2A0i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 19:34:21 +0100
Received: by mail-vc0-f169.google.com with SMTP id hy10so4453330vcb.28
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 10:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yAp3ppMJ7RUehoGB64xU/zyBfN/ZIB9AUoa1vO7TLWU=;
        b=keHSaqXLihDSBiThgvM+v5SXvacicTfa3CEDvvrQ3VbcsuSMzvLMVyzwMImSFh7Fc/
         fDwXWq9CWQLIuflzFDdRjdHk5XFqyQxhhr1Nd/k8c814EDl+9IjxaUDsbB1WhGEHx4uL
         /Bov/flmRzdFS96nw6Ct+WawFapfTi3+mV3B862llz/+pevYg+o8piaY21ithlXci/YD
         ywIxU5vEmQ3Aw/C+JBCjsOTjeCtQ2xCTnOe2A1VescdzdCkn0vIsUwHU6S4kIWvg8YSM
         5TOW6/YAKPV/hFtWxkgrVt81w/HBuPkcducf8Lek4/vydBzWgI9ZfuttQmDBYJ0LMf/T
         cofw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yAp3ppMJ7RUehoGB64xU/zyBfN/ZIB9AUoa1vO7TLWU=;
        b=jWdBU7U781KkmiX02yiMyqP59yGC0ZYysWfcOmVq7pd0d4ZsQAStsftdpMjEQ4dl3W
         NEZcr3H2Clic/fQ9ZfKHIAYWG1kCtgOCss0PU8//kFqzyf3xJD/YgVUMoEngi9T9iCgJ
         UNr/VtlfqHZ/kaK7ego9Y95b98AAm3ioX/kj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yAp3ppMJ7RUehoGB64xU/zyBfN/ZIB9AUoa1vO7TLWU=;
        b=ip0ct7IDb/9rxQ++vi54nihQ9ps7QoJ5XswDW2+2I8K/OWENo6HlmWIOwFgGCl4Nsa
         w2QbUaieYfXkA7cTgWZgpmboOFQrzucrc6LP2uRI65ftC5jMJ97HnSlLPTT2xZGF/L0u
         qwm4xllsF9hbo3FQ+4cBHr7hRzdSOXneX3Xc6h8PSvrtRf/H0k8hPysDG0YjbfDIM5vd
         QSo3ziulv38WbpLz0EpS60wylZ/hhVY9ZnEpjFrcrxqOGRrr9AXj9Y//l7Qy5+izUHLB
         WhTjDe/DhHKAupZe2txtvGu2VN9z8LWE5avRetQfi0c0ACsS6yzF+idD9qigkyqYMprM
         DCrw==
X-Gm-Message-State: ALoCoQnM2oXFbV9vldZSCRUfEhVbpzC7vaILafAHBpo1wtp6QrU/KCPA/OAbJ4xAX+seSYjyfAiV
MIME-Version: 1.0
X-Received: by 10.52.141.1 with SMTP id rk1mr10762088vdb.70.1416854055308;
 Mon, 24 Nov 2014 10:34:15 -0800 (PST)
Received: by 10.52.168.200 with HTTP; Mon, 24 Nov 2014 10:34:15 -0800 (PST)
In-Reply-To: <11772640.IZcxoRkMEM@wuerfel>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
        <1416796846-28149-12-git-send-email-cernekee@gmail.com>
        <11772640.IZcxoRkMEM@wuerfel>
Date:   Mon, 24 Nov 2014 10:34:15 -0800
X-Google-Sender-Auth: FBoW6-OK76MnjoFJtngZEebsfv8
Message-ID: <CAL1qeaH8d0DAZ5SEyioPUM1WXvTgyEoXOqM88-tibnsd-MDT=Q@mail.gmail.com>
Subject: Re: [PATCH V3 11/11] MIPS: Add multiplatform BMIPS target
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, jfraser@broadcom.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonas Gorski <jogo@openwrt.org>, computersforpeace@gmail.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44387
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

Hi,

On Mon, Nov 24, 2014 at 6:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> ---
>>  .../devicetree/bindings/mips/brcm/bmips.txt        |   8 +
>>  .../devicetree/bindings/mips/brcm/soc.txt          |  12 ++
>>  arch/mips/Kbuild.platforms                         |   1 +
>>  arch/mips/Kconfig                                  |  36 ++++
>>  arch/mips/bmips/Kconfig                            |  50 ++++++
>>  arch/mips/bmips/Makefile                           |   1 +
>>  arch/mips/bmips/Platform                           |   7 +
>>  arch/mips/bmips/dma.c                              | 141 +++++++++++++++
>>  arch/mips/bmips/irq.c                              |  38 ++++
>>  arch/mips/bmips/setup.c                            | 195 +++++++++++++++++++++
>>  arch/mips/boot/dts/Makefile                        |   9 +
>>  arch/mips/boot/dts/bcm3384_viper.dtsi              | 108 ++++++++++++
>>  arch/mips/boot/dts/bcm3384_zephyr.dtsi             | 126 +++++++++++++
>>  arch/mips/boot/dts/bcm6328.dtsi                    |  87 +++++++++
>>  arch/mips/boot/dts/bcm6368.dtsi                    |  94 ++++++++++
>>  arch/mips/boot/dts/bcm7125.dtsi                    | 107 +++++++++++
>>  arch/mips/boot/dts/bcm7346.dtsi                    | 192 ++++++++++++++++++++
>>  arch/mips/boot/dts/bcm7360.dtsi                    | 129 ++++++++++++++
>>  arch/mips/boot/dts/bcm7420.dtsi                    | 151 ++++++++++++++++
>>  arch/mips/boot/dts/bcm7425.dtsi                    | 191 ++++++++++++++++++++
>
> I hadn't noticed before that the dts files are now all in one
> directory on MIPS, apparently after a patch from Andrew Brewsticker.
> We should really coordinate these things better, we have just merged
> an arm64 patch to split out the files into multiple directories.

FWIW, I'm planning on sending a patch once 3.19-rc1 is released to
move the DTs into per-vendor sub-directories.  I was expecting to do
it for 3.19, but Robert Richter's series which added kbuild support
for the vendor sub-directories did not end up landing in 3.18.
