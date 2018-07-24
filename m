Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 21:16:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994243AbeGXTQrVSTum (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 21:16:47 +0200
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com [209.85.216.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E3EF20875
        for <linux-mips@linux-mips.org>; Tue, 24 Jul 2018 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532459800;
        bh=QEHxwU6j4bnTNKBTdkbB20VGWXMSdzWH5N5727s30A4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xuTT+nC+OI9Zb+o9Wu/Ybjek0d70/SwqdKcDaMb9Qbz2wIk3YFqkNUvqglkTIFpqu
         xxMVCSV4BlsMRVfkTkx1NL4ZDVjjujXoqwAkLCbg9bjgAjSmCCODRnEp8h6WV/epA/
         MSW/vvxIrA4cLARV4LDrjAW2IGiXzmSvq8uGa4L8=
Received: by mail-qt0-f176.google.com with SMTP id c15-v6so5292796qtp.0
        for <linux-mips@linux-mips.org>; Tue, 24 Jul 2018 12:16:40 -0700 (PDT)
X-Gm-Message-State: AOUpUlEw6tl31j/+kM4ik1k92WHWzgoZcspgz1d4IjQ9FMi5jf3ueJtL
        Nn40oc1FyEhP29j/jNUD39HwofzUhUzaGxOQLg==
X-Google-Smtp-Source: AAOMgpf0P6ZSfnG5P85N4Qu+6FWcLIqIQ4B5NHzp7sRWem1OovCYsTL5SU+6unZHHyzV2DH3CsR4+o9v5jSMu9mQLWE=
X-Received: by 2002:a0c:98a4:: with SMTP id f33-v6mr16280194qvd.81.1532459799655;
 Tue, 24 Jul 2018 12:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180724000647.okbjmghv4w66bl7u@pburton-laptop> <20180724180940.20249-1-paul.burton@mips.com>
In-Reply-To: <20180724180940.20249-1-paul.burton@mips.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Jul 2018 13:16:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKs2RkWVo=WXVdhD+qs0jP2bDA3w6U=PeBSd=J9QiFCHw@mail.gmail.com>
Message-ID: <CAL_JsqKs2RkWVo=WXVdhD+qs0jP2bDA3w6U=PeBSd=J9QiFCHw@mail.gmail.com>
Subject: Re: [PATCH] checks: Detect cascoda,ca8210 extclock-gpio false-positive
To:     Paul Burton <paul.burton@mips.com>
Cc:     Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65092
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

On Tue, Jul 24, 2018 at 12:10 PM Paul Burton <paul.burton@mips.com> wrote:
>
> The binding for the cascoda,ca8210 IEEE 802.15.4 (6LoWPAN) device
> includes an extclock-gpio property which does not contain a gpio-list,
> but is instead an integer representing a pin of the device itself. This
> falls foul of the gpios_property check, for example:
>
>     DTC     arch/mips/boot/dts/img/pistachio_marduk.dtb
>   arch/mips/boot/dts/img/pistachio_marduk.dtb: Warning (gpios_property):
>     /spi@18100f00/sixlowpan@4: Missing property '#gpio-cells' in node
>     /clk@18144000 or bad phandle (referred from extclock-gpio[0])
>
> Extend the checking for false-positives in prop_is_gpio() to detect this
> case in addition to the existing nr-gpio case. The false-positive cases
> are described by an array including a compatible string & property name.
> A NULL compatible string indicates that the property may be present in
> any node, otherwise the property is only allowed in a node compatible
> with the given string. This allows us to whitelist the extclock-gpio
> property for the cascoda,ca8210 device without allowing it anywhere
> else.

IMO the binding should be fixed. It wasn't reviewed and there are no
dts files using it. I see several issues with it.

Rob
