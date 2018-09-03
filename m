Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 08:15:36 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34536 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991063AbeICGPdGTw9o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 08:15:33 +0200
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so31766603ois.1;
        Sun, 02 Sep 2018 23:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2ZCunzbkkFXTlYNcvypMLR2svkaZRvfiiTFPiOaAzA=;
        b=KLI0vVGbXrw6prMBrfb7nYCQ32f7/atcGvgmwhiGJvY01s+x8GCTbPI9fodsl9bYs8
         SN0WY7jzsKfZIVdVkfKb2YgYDiok2uGwVpH9StSkRrqqpHTUNktjAAytzmcDVQjuDZqD
         4DKwtHDruJJLFDpnkDp5zmIbqsTrSwK6hdMOsZdQcatThzOiO87t2qUPkwbSU5wj6XxB
         Qjhm0X21jYNVyq+kxVrOmRL1qM6zMuJGA1fWvrMjbh9Q3uhU8nQWt6Y+XDNess4Itid8
         DpsvF4LwY4fGemG/e7UK9EeT3K+UsB3u/NozOMEXyxyg13HDGf62qW9+wChpM4gcv2fb
         fzYg==
X-Gm-Message-State: APzg51AgJjFR+MOaJysxUjKoJXlozd8o9R4hV1+ke3eVNR2J33bpb+kB
        NtZihZnTpdlLQUJkImF526TLf6WYA71u4DrI/Bc=
X-Google-Smtp-Source: ANB0Vdb/hJo0L/AShWTtV6kB9uWAxVDLJRB1IrivJiAO+cstM53oCiRK5hGGTFr7rH0L7nXLWkMpJr+vbn6Fdim7jvg=
X-Received: by 2002:aca:c7c2:: with SMTP id x185-v6mr17274435oif.43.1535955326907;
 Sun, 02 Sep 2018 23:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180606193811.16007-1-malat@debian.org> <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
 <20180831203752.37rsceiwotcmeses@pburton-laptop> <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
In-Reply-To: <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 3 Sep 2018 08:15:14 +0200
Message-ID: <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
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
X-archive-position: 65866
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

On Fri, Aug 31, 2018 at 10:59 PM Paul Burton <paul.burton@mips.com> wrote:
>
> On Fri, Aug 31, 2018 at 01:37:52PM -0700, Paul Burton wrote:
> > Further to that, this series doesn't seem to work for me. With
> > v4.19-rc1, with the patch from [1] & then this series applied I see the
> > following when booting a ci20_defconfig kernel:
> >
> >   [    0.846684] ALSA device list:
> >   [    0.849642]   No soundcards found.
>
> D'oh! Apparently I haven't drunk enough coffee today - missing link can
> be found below:
>
> [1] https://www.spinics.net/lists/linux-gpio/msg31965.html

Awesome, thanks for testing. I'll return to this series once I receive
replacement for my laptop hard drive.

thanks,
-M
