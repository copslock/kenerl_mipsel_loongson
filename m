Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 13:59:51 +0100 (CET)
Received: from mail-it0-x232.google.com ([IPv6:2607:f8b0:4001:c0b::232]:36529
        "EHLO mail-it0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993878AbdAaM7oOTwBq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 13:59:44 +0100
Received: by mail-it0-x232.google.com with SMTP id c7so215233462itd.1
        for <linux-mips@linux-mips.org>; Tue, 31 Jan 2017 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yd/Jj4+IKAF0rsZKhinpf1FZ6/vnDpQ8qKLoE1uY6zg=;
        b=hGNJYtL1gGWEzxBBW84uDS3J8w31w0dDZ4Kc3xl1+lYNxVibufAv3eeDeDgF/ZBcxZ
         Lus0Ytem4o/P/h6/YUIsRYCa/s3/RUivak+WLSuyJyPd58iwLMYPBUy9NoVItgiDzx6m
         NIZJDVDp3LRAT1bsnCo9eOvz3HKrfVAM1372Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yd/Jj4+IKAF0rsZKhinpf1FZ6/vnDpQ8qKLoE1uY6zg=;
        b=g/rsCJyLO1+QwUph98kD+poP4MEB46IhUXv1yD6hl8xucEY9sUMhCLQDgQb3ryhehz
         AxA3v1nAup+jbbjILmLzc0ONViw/02oTF0RIZc2++HN61A61GZQMV7rZ38eZ+ENLWY88
         rYyslL973pHlwQR2OQAJkAZ+d1O+1YAYvFCWN4jy9Lk7Z0pDcMK8i7C8H+4emggHeoUt
         dWvMCQGtQA871LZ9WP410XQ4wZWWEeGTh3+rgKP8LEfHTZ7OzTIEdFDiewUtDda8KCfy
         Kjx292//mY/On7GsxOpRMiEZp3v5g4dZW6kokxEcidLf7fSHepdYSgxSgCxl1M8BXYyJ
         I8CA==
X-Gm-Message-State: AIkVDXK9KyzNCg2Ly1vbyUjgMdirSRjkdsCLZIx+FxW+ZMmh/yiovepPW9tyqh39t4EZoJPZmIKP8T6tcnht3U51
X-Received: by 10.36.26.9 with SMTP id 9mr19890633iti.25.1485867578405; Tue,
 31 Jan 2017 04:59:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Tue, 31 Jan 2017 04:59:37 -0800 (PST)
In-Reply-To: <08e9505d2d366557950f8e6a4e81f57a@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net> <20170122144947.16158-2-paul@crapouillou.net>
 <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com> <08e9505d2d366557950f8e6a4e81f57a@mail.crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2017 13:59:37 +0100
Message-ID: <CACRpkda+2tnuO=AcN=HAD+YoaM4eEgnyjju7ioJL1op7+jFtqA@mail.gmail.com>
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
X-archive-position: 56543
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

On Fri, Jan 27, 2017 at 4:27 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> [Me]:
>> In the former case, if this pertains to the *inside* of the SoC:
>> is it just different between jz4740 and jz4780?
>> In that case, just code this into the driver as .data to the .compatible
>> in the DT match. No special DT properties needed.
>
> Well, I've been taught that devicetree is for describing the hardware, and
> the driver code is for functionality. So that's why I put it in devicetree.

This is a gray area.

But as GPIO maintainer I'm not happy about encoding information
about the hardware, that can be deducted from the compatible-string,
into the devicetree.

I prefer to encode per-compatible hardware information tables into
the driver, as structs, and pick the right table based on the compatible
string as .data in the of match entry.

It's simple to retrieve into the driver using of_device_get_match_data()
these days.

> That's also the reason why I put the list of functions and groups in
> devicetree and not in the driver code.

I'm not super-happy about that either, and it's not the way I would
have done it but the argument has been made
that it is a lot of opaque data and people prefer to maintain it
in the device tree.

I accept it for functions and groups, but I don't like it.

I will not fold to any consistency arguments of the type "now
you allowed this one thing, so you must allow this other thing
so you are consistent", just no. I didn't like it the first time, so I'm
not liking it anymore the second time.

I guess if the DT people tell me it has to be done this way I would
accept it. After a lot of discussion. But noone has.

Please make it a table and put it in the driver instead.

Yours,
Linus Walleij
