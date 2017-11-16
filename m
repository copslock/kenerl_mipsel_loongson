Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 02:46:52 +0100 (CET)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:43237
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992197AbdKPBqpOxHFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 02:46:45 +0100
Received: by mail-oi0-x244.google.com with SMTP id f135so2274793oib.0
        for <linux-mips@linux-mips.org>; Wed, 15 Nov 2017 17:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kuDDh844p6Mf53d9M3B77aahYWEpu3Zs0JdfebGuy1c=;
        b=ZSgMpYswOdYwoaSu3zGQBaj+XKpnyr99SPW0M04ahxdJWk2NF/2DB0CUG9wolyAKTa
         UEq4twmh7lut8ihjyc7iQsLgzlyXsTMiXNq70yuYpyFxWyMzRh9MfsfIzJdV0pM/uTOF
         Idru65gzCFUPaCPqcDhDMOTzKJeKfbnZCRIyWWKp9LbHm3ZN5mVIkh9rCSe/coYAqGUP
         jRYK8MG3mLJG2Gapp6RulnoZfz92gHOQdrGWviScxe778abBW+X6Xe07CTDs3mKFFbFo
         IiOclMUW+7awPsnwdhmsYTVFHaqOkU0c6yiadFT7GjvfuAS0DKphcIDmRutJy3R9OmZu
         2y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kuDDh844p6Mf53d9M3B77aahYWEpu3Zs0JdfebGuy1c=;
        b=ovWiZHQndC3SiSA6T0WgRVyHaj8SeN+CqDDSbyStg3eLDIoBGhj07b+4dnCmj2xfNp
         a9Jgy2n0Xjjj336uCJjdj6PS84nT37fXBYmgm/hifV5SrPdMLtMxs5cRZCLKlizkc5Dr
         dCKW2r32rWMO7XATk8sLSSTJwpmzzu60f1v6cWjSy5DuJsqdX+rG7bTtbDVkG/m1633N
         amhHEboDRifJEEUgG8PR2LLrpBoMK8aeKCD4dt6m3vIBe1H855opH3wTR3soE20fRWDW
         nw3D6Ypi5Kx6OHcz7rPWrWJVFMgLdLzlKUn7cIoPC2/JU0gqULNm1io1AJjb3D89vIfF
         +6Aw==
X-Gm-Message-State: AJaThX6YIChjZouzhg6i/zKevXTcnEr+tPmOjB3WaVppYqpY1PchPtBZ
        t/qyL7JzPs3zBlwy05H0k9YX4g==
X-Google-Smtp-Source: AGs4zMZ78VV9UlCVD6r0Hs3+bqYzGmYKZKczfnRNWaKst95GOTWLFNYw5dDehG8QLvwOsYr54PnT2Q==
X-Received: by 10.202.178.133 with SMTP id b127mr18632oif.261.1510796797792;
        Wed, 15 Nov 2017 17:46:37 -0800 (PST)
Received: from ?IPv6:2600:1700:9da0:c90:3dcd:32eb:79d7:8fc4? ([2600:1700:9da0:c90:3dcd:32eb:79d7:8fc4])
        by smtp.gmail.com with ESMTPSA id 67sm10617212oti.48.2017.11.15.17.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Nov 2017 17:46:37 -0800 (PST)
Message-ID: <1510796793.16864.25.camel@chimera>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Nov 2017 17:46:33 -0800
In-Reply-To: <CAL_JsqJoEEkoA1sGocGFXE7WWhCmkb5k2OxVRZ3OnigptoL8_Q@mail.gmail.com>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <20171113112312.GZ15260@jhogan-linux>
         <CAL_JsqJRVB928DVOAVQGrtT_EOuQBHkBhcd9+XFzqemutG65GA@mail.gmail.com>
         <1510628754.14209.27.camel@chimera>
         <CAL_JsqJoEEkoA1sGocGFXE7WWhCmkb5k2OxVRZ3OnigptoL8_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Tue, 2017-11-14 at 11:18 -0600, Rob Herring wrote:
> I understand you can't apply random strings in any order you like. I'm
> questioning the need to do that and what are the concrete example(s)
> where you need that ability.

Concrete:
Pre-DT bootloader provides "console=/dev/someunusualdevice" and
"root=/dev/mtdblock1" in argv. The dtb arranges flash differently and
supplies "root=/dev/mtd2" in bootargs. Kernel uses /dev/mtdblock1 and
panics, or alternatively uses /dev/mtd2 with no console.

> I'd generally expect that only board specific options are in the dtb,
> and a distro will add it's own options common for all and the specific
> arch into the bootloader config files. And generally, the last thing
> loaded gets the last say in what is set.

Bootloaders and their configs are not distro-dependent.
> 
> What h/w specific options would be needed for recovery kernel? That's
> getting into putting not just Linux specifics into the dtb, but distro
> specifics there. While yes, the dts files often already have bootargs
> filled with Linux options, the intention is really that the bootloader
> fills in bootargs. And if you have multiple kernels or OSs, then the
> bootloader provides the mechanism to choose and boot with the right
> options.

Kernels _are_ distro-specific. A recovery kernel might also have options
that are not hardware specific in addition to options that are.

> I think the kernel (being last) should fully decide what to do:
> append, prepend, and/or override. There was some work a while back to
> support more flexible command line handling and be arch neutral, but
> it never got merged.

The kernel would not always have all the information needed for this
decision now like it would before DT. The dtb should decide what
precedence its bootargs have, and the kernel should decide what
precedence compiled-in bootargs have. Such logic is provided by this
patch, but not completely, because there is still no "bootargs-prepend"
property. The only use case I can think of for "bootargs-prepend" would
be to provide a default command line that is specific to a board that
would sometimes have one bootloader, and sometimes another. Currently,
such a situation can be worked around using a board-specific kernel, but
this mechanism is a relic from pre-DT days.
