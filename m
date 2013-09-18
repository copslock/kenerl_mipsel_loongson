Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:41:45 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51666 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727Ab3IRLllK6wK1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 13:41:41 +0200
Received: by mail-pd0-f171.google.com with SMTP id g10so6928080pdj.16
        for <multiple recipients>; Wed, 18 Sep 2013 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Pj9sITmYZKnlMUMy9nt4783NJZrAuhGnQLMQWJ2F7Fs=;
        b=NMVRyeHIgpIGZz5GT7Pus17JOGItEMm72rfZjFh53xtp0Y7RRXLmezXyhVfOr7euuw
         TyJCuJuD5yfOn3tDp+1Pl+UY8sROU2A3JTR/g1w+EVskH247wZlWYvuERI2/mGGtqC89
         gR0n9gH87TkEIz9lq0e5ahiaezcqEidWJl2IltIA2J/w8BKOa+jwc+MWRe3sNuohR7BC
         EQl9U7rwnlGj/AGoWL9Dv4PPALkpMYuLEdAxadMaWCtBSHPKi03wcUiooz607wfHjm+p
         mBbfZO032W+RJH2Rkscp+2Z51tFxryhem4+kzZ5uNIoWxEOuY8mKQ/j0hEQJRuRYFOXD
         jvkg==
MIME-Version: 1.0
X-Received: by 10.67.22.106 with SMTP id hr10mr13838215pad.155.1379504494664;
 Wed, 18 Sep 2013 04:41:34 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Wed, 18 Sep 2013 04:41:34 -0700 (PDT)
In-Reply-To: <1379503798-9014-1-git-send-email-hauke@hauke-m.de>
References: <1379503798-9014-1-git-send-email-hauke@hauke-m.de>
Date:   Wed, 18 Sep 2013 13:41:34 +0200
X-Google-Sender-Auth: bYDvC4kXyr2CXiDX3payZ2v6dBk
Message-ID: <CAMuHMdU8V=96fEb9Vrpb2+TEWiD5L2Gh+3xzY9SBDotP2NaQ=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: BCM47XX: add board detection
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Wed, Sep 18, 2013 at 1:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Detect on which board this code is running based on some nvram
> settings. This is needed to start board specific workarounds and
> configure the leds and buttons which are on different gpios on every board.
>
> This patches add some boards we have seen, but there are many more.

Can you please make the board database __initconst, and only retain in memory
a copy of the detected board info?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
