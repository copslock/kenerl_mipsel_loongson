Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 18:18:53 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990439AbdKNRSrOAPah (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 18:18:47 +0100
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com [209.85.216.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77C121904
        for <linux-mips@linux-mips.org>; Tue, 14 Nov 2017 17:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77C121904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
Received: by mail-qt0-f172.google.com with SMTP id n32so10749030qtb.2
        for <linux-mips@linux-mips.org>; Tue, 14 Nov 2017 09:18:42 -0800 (PST)
X-Gm-Message-State: AJaThX4srqHeM/blUWfuo3IhqD+NAKc7YH0ty3TtOECW5anthqBqNFth
        UUHHZjFzoTACbIYmpKDoO4Y80wym3xMPVTswSw==
X-Google-Smtp-Source: AGs4zMadmLv61DSIx0fJB84+t2IpHgvlaOe8hsfP5pKObrru20thV27qLieNTLhK7LqkDZr8jSA+/UZnsVnG5fuseNw=
X-Received: by 10.55.141.3 with SMTP id p3mr20406744qkd.210.1510679921934;
 Tue, 14 Nov 2017 09:18:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.194.73 with HTTP; Tue, 14 Nov 2017 09:18:21 -0800 (PST)
In-Reply-To: <1510628754.14209.27.camel@chimera>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
 <20171113112312.GZ15260@jhogan-linux> <CAL_JsqJRVB928DVOAVQGrtT_EOuQBHkBhcd9+XFzqemutG65GA@mail.gmail.com>
 <1510628754.14209.27.camel@chimera>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Nov 2017 11:18:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoEEkoA1sGocGFXE7WWhCmkb5k2OxVRZ3OnigptoL8_Q@mail.gmail.com>
Message-ID: <CAL_JsqJoEEkoA1sGocGFXE7WWhCmkb5k2OxVRZ3OnigptoL8_Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     James Hogan <james.hogan@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60930
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

On Mon, Nov 13, 2017 at 9:05 PM, Daniel Gimpelevich
<daniel@gimpelevich.san-francisco.ca.us> wrote:
> On Mon, 2017-11-13 at 10:34 -0600, Rob Herring wrote:
>> This is a kernel problem. What's the use case where you want the DT to
>> override the kernel?
>>
>> One way you could handle this is make bootargs be multiple strings.
>> Well 2 specifically, the first string is prepended and the 2nd is
>> appended. That complicates how you'd implement /append-property/
>> though as you'd probably want to support both string cat and 2
>> strings. Though the latter works more generically without knowing the
>> data type.
>
> Let's say the bootloader tells the kernel that the command line is "foo
> bar" and that "baz" is in the dtb. Currently, there are kernel
> configuration options to control whether this means the kernel's command
> line will be "baz" or "baz foo bar" instead, but there is no way to turn
> it into "foo bar baz" without either creating new kernel configuration
> options or this patch. Implementing it via this patch would allow a
> theoretical distro to use a generic kernel across different devices that
> need the arguments from their bootloader manipulated in different ways.

I understand you can't apply random strings in any order you like. I'm
questioning the need to do that and what are the concrete example(s)
where you need that ability.

I'd generally expect that only board specific options are in the dtb,
and a distro will add it's own options common for all and the specific
arch into the bootloader config files. And generally, the last thing
loaded gets the last say in what is set.

> Ideally, the MIPS-specific kernel configuration options for how to treat
> the dtb's bootargs with respect to the bootloader's bootargs should go
> away in favor of an analogous device tree property "bootargs-prepend"
> for this reason. The kernel configuration options to supply a hard-coded
> default command line if the bootloader does not supply one, and to
> override what the bootloader and dtb supply, would remain. This would
> separate the need for an alternate or "recovery" kernel to supply its
> own bootargs to override the dtb from the need to have device-specific
> bootargs in the dtb override a legacy bootloader, where the manner its
> bootargs are overridden may be device-specific.

What h/w specific options would be needed for recovery kernel? That's
getting into putting not just Linux specifics into the dtb, but distro
specifics there. While yes, the dts files often already have bootargs
filled with Linux options, the intention is really that the bootloader
fills in bootargs. And if you have multiple kernels or OSs, then the
bootloader provides the mechanism to choose and boot with the right
options.

I think the kernel (being last) should fully decide what to do:
append, prepend, and/or override. There was some work a while back to
support more flexible command line handling and be arch neutral, but
it never got merged.

Rob
