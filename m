Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 17:34:42 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990425AbdKMQeeaSlqX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 17:34:34 +0100
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com [209.85.220.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74DAA21904
        for <linux-mips@linux-mips.org>; Mon, 13 Nov 2017 16:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DAA21904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-qk0-f180.google.com with SMTP id 78so20451563qkz.0
        for <linux-mips@linux-mips.org>; Mon, 13 Nov 2017 08:34:32 -0800 (PST)
X-Gm-Message-State: AJaThX5dUhc9eKuKI7nJQ4QY0LCQaF4qZrYRZ3D6oGQapbVZaQSA93j5
        VBghG/Ky23oezqmSSORnnfDXUcpXHHctDh2y3A==
X-Google-Smtp-Source: AGs4zMaOEt02oiYALkfvFHxgDiA1ySKWumY9QWy/Dpu9GaYP2YxB+rIvc/qTqgSTPujqXjHWovf+gWVkjw6E72DUdt0=
X-Received: by 10.55.99.214 with SMTP id x205mr15111628qkb.34.1510590871662;
 Mon, 13 Nov 2017 08:34:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.194.73 with HTTP; Mon, 13 Nov 2017 08:34:11 -0800 (PST)
In-Reply-To: <20171113112312.GZ15260@jhogan-linux>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
 <20171113112312.GZ15260@jhogan-linux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Nov 2017 10:34:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJRVB928DVOAVQGrtT_EOuQBHkBhcd9+XFzqemutG65GA@mail.gmail.com>
Message-ID: <CAL_JsqJRVB928DVOAVQGrtT_EOuQBHkBhcd9+XFzqemutG65GA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
To:     James Hogan <james.hogan@mips.com>
Cc:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Mon, Nov 13, 2017 at 5:23 AM, James Hogan <james.hogan@mips.com> wrote:
> On Sat, Nov 11, 2017 at 09:19:48AM -0800, Daniel Gimpelevich wrote:
>> There are two uses for this:
>>
>> 1) It may be useful to split a device-specific kernel command line between
>> a .dts file and a .dtsi file, with "bootargs" in one and "bootargs-append"
>> in the other, such as for variations of a reference board.

What Geert said.

>> 2) There are kernel configuration options for prepending "bootargs" to the
>> kernel command line that the bootloader has passed, but not for appending.
>> A new option for this would be a less future-proof solution, since things
>> like this should be in the dtb.

This is a kernel problem. What's the use case where you want the DT to
override the kernel?

One way you could handle this is make bootargs be multiple strings.
Well 2 specifically, the first string is prepended and the 2nd is
appended. That complicates how you'd implement /append-property/
though as you'd probably want to support both string cat and 2
strings. Though the latter works more generically without knowing the
data type.

Rob
