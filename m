Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 00:33:29 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:46216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXWdVc0oOu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 00:33:21 +0200
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDB820883
        for <linux-mips@linux-mips.org>; Tue, 24 Jul 2018 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532471594;
        bh=FLIxouCEeBgnmLF1si3clt7ZYURxWlmLlUuLureqtNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xmD+APMElOuqYSbetAKddiNm9+zUGBgbfVMSSmK2ROpxJLzEHg0TmdsqmqTRYYIiM
         RKc1n9EcDc9vqbui5u3I3110R8d2aB08N6zdliVHjNy2fY4r8XT3sn1ZSbPCtxDE/g
         /QWjwsyAU0XgdgGja02gh9r/yZ1XiIVORRBJesqo=
Received: by mail-qt0-f180.google.com with SMTP id n6-v6so5848293qtl.4
        for <linux-mips@linux-mips.org>; Tue, 24 Jul 2018 15:33:14 -0700 (PDT)
X-Gm-Message-State: AOUpUlGGWDVypZpdLGKpfSJ7nobNtSgA/RKM4EbiKvmESYOocxh9Mvqe
        nSl9TjC2YDCOmbFlsbA0MnVUmMZl1nqtjLY7lA==
X-Google-Smtp-Source: AAOMgpcDPo0wcBeY4oA8JdHpGauD/V9NGlrhTzbbpsC1ff9jEypk4eCfy/exkhqEDwb4dLcn3m84bt2kHtYEzNIOnFY=
X-Received: by 2002:a0c:98d1:: with SMTP id g17-v6mr16909040qvd.27.1532471593762;
 Tue, 24 Jul 2018 15:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180724000647.okbjmghv4w66bl7u@pburton-laptop>
 <20180724180940.20249-1-paul.burton@mips.com> <CAL_JsqKs2RkWVo=WXVdhD+qs0jP2bDA3w6U=PeBSd=J9QiFCHw@mail.gmail.com>
 <20180724201738.brkxgsoovcng52a7@pburton-laptop> <96e4ccf1-0624-4840-d12d-39812324217e@suse.de>
In-Reply-To: <96e4ccf1-0624-4840-d12d-39812324217e@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Jul 2018 16:33:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKicOAB8Hg3mWq2gV=uz5U-h4r7SVautVhN=UkraX8ivw@mail.gmail.com>
Message-ID: <CAL_JsqKicOAB8Hg3mWq2gV=uz5U-h4r7SVautVhN=UkraX8ivw@mail.gmail.com>
Subject: Re: [PATCH] checks: Detect cascoda,ca8210 extclock-gpio false-positive
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>,
        Linux-MIPS <linux-mips@linux-mips.org>, h.morris@cascoda.com,
        harrymorris12@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        stefan@osg.samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Tue, Jul 24, 2018 at 4:12 PM Andreas Färber <afaerber@suse.de> wrote:
>
> Hi Rob and Paul,
>
> Am 24.07.2018 um 22:17 schrieb Paul Burton:
> > On Tue, Jul 24, 2018 at 01:16:28PM -0600, Rob Herring wrote:
> >> On Tue, Jul 24, 2018 at 12:10 PM Paul Burton <paul.burton@mips.com> wrote:
> >>>
> >>> The binding for the cascoda,ca8210 IEEE 802.15.4 (6LoWPAN) device
> >>> includes an extclock-gpio property which does not contain a gpio-list,
> >>> but is instead an integer representing a pin of the device itself. This
> >>> falls foul of the gpios_property check, for example:
> >>>
> >>>     DTC     arch/mips/boot/dts/img/pistachio_marduk.dtb
> >>>   arch/mips/boot/dts/img/pistachio_marduk.dtb: Warning (gpios_property):
> >>>     /spi@18100f00/sixlowpan@4: Missing property '#gpio-cells' in node
> >>>     /clk@18144000 or bad phandle (referred from extclock-gpio[0])
> >>>
> >>> Extend the checking for false-positives in prop_is_gpio() to detect this
> >>> case in addition to the existing nr-gpio case. The false-positive cases
> >>> are described by an array including a compatible string & property name.
> >>> A NULL compatible string indicates that the property may be present in
> >>> any node, otherwise the property is only allowed in a node compatible
> >>> with the given string. This allows us to whitelist the extclock-gpio
> >>> property for the cascoda,ca8210 device without allowing it anywhere
> >>> else.
> >>
> >> IMO the binding should be fixed. It wasn't reviewed and there are no
> >> dts files using it. I see several issues with it.
>
> It looked strange to me, too, so revising it will be appreciated. Will
> you be driving this, Rob? Thanks.

Well, I'll happily list what should be fixed:

- s/reset-gpio/reset-gpios/
- Use 'interrupts' instead of irq-gpio
- Use clock binding instead of extclock-freq
- s/extclock-gpio/cascoda,extclock-gpio-pin/
- Seems like extclock-gpio being present can imply extclock-enable

> BTW not a single binding in net/ieee802154/ has Rob's Reviewed-by or
> Acked-by, not just this binding.

get_maintainers.pl is not perfect, but still...

Rob
