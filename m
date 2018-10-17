Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2018 22:26:44 +0200 (CEST)
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34124 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993976AbeJQU0lLvnaW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2018 22:26:41 +0200
Received: by mail-ot1-f68.google.com with SMTP id v2so20420837otk.1;
        Wed, 17 Oct 2018 13:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymd5wralDBwI1+nvWrInzavSha2pjNT5R8MNAt3lHjs=;
        b=onLYsdzoGF9QpNcl4ItWyd2krqBbGMhpfU/AJj7DG6Kf8E8K7xmXnPuo1AOoXWFW3S
         UFnp+uqa7aesroG9lD8XLr/YuH/ruL4+zIOzZTpWaKZ4GHtKeYod5yfDAlYVxZHxY30o
         RNOtf2z9imJ9L22aQTClYpxV3Y1CFxW7UtIurPnWnVwjUVIkJHHeVmNZS79zeF+MGRgP
         zahDRc0kOj9Wd66x68Kxk/QJSOv9uZmmnqYCZa3ea6LTMoT/c+M6xc/P4QSK0rSPK2yX
         lnaIemd33l62HlqOrFzf1hqEhnW8rI9iwWH3eoLQXaLzUtwwyDK5Kn0A6AArtCo0ZUhN
         ydRw==
X-Gm-Message-State: ABuFfogaqx3fkcvLqGG8Ygtp1tT+sq3Yva0hSNi4UOfO6AUSnuSy64qf
        gDjGq7M/66RY0z41LaIx7TqIYO1aMSCZCX4DZhk=
X-Google-Smtp-Source: ACcGV62x+Z7nz/E8dRPJzUgVEXNeJ6lIBa5mTdv/llLukctvmcYRZkOVFtuHkNCo+W0r/ZazXX5apH/2yWN3IscUIkM=
X-Received: by 2002:a9d:59ae:: with SMTP id u46mr16612272oth.243.1539807994864;
 Wed, 17 Oct 2018 13:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180606193811.16007-1-malat@debian.org> <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
 <20180831203752.37rsceiwotcmeses@pburton-laptop> <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
 <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
In-Reply-To: <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Oct 2018 22:26:22 +0200
Message-ID: <CA+7wUsycUxKoCEk1CW+RKfJ5e9AxOumyfKoF93JYw3qmU5r=nQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Paul,

On Mon, Sep 3, 2018 at 8:15 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Fri, Aug 31, 2018 at 10:59 PM Paul Burton <paul.burton@mips.com> wrote:
> >
> > On Fri, Aug 31, 2018 at 01:37:52PM -0700, Paul Burton wrote:
> > > Further to that, this series doesn't seem to work for me. With
> > > v4.19-rc1, with the patch from [1] & then this series applied I see the
> > > following when booting a ci20_defconfig kernel:
> > >
> > >   [    0.846684] ALSA device list:
> > >   [    0.849642]   No soundcards found.
> >
> > D'oh! Apparently I haven't drunk enough coffee today - missing link can
> > be found below:
> >
> > [1] https://www.spinics.net/lists/linux-gpio/msg31965.html
>
> Awesome, thanks for testing. I'll return to this series once I receive
> replacement for my laptop hard drive.

I see it now :

[    0.289701] bus: 'platform': really_probe: probing driver
jz4740-i2s with device 10020000.i2s
[    0.289713] jz4740-i2s 10020000.i2s: no pinctrl handle
[    0.289782] OF: /i2s@10020000: could not find phandle

I'll try to make sense of this.

> thanks,
> -M
