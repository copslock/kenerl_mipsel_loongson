Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 14:21:03 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54047 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815753Ab3EGMU4ixA5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 14:20:56 +0200
Received: by mail-ie0-f171.google.com with SMTP id e11so784367iej.16
        for <multiple recipients>; Tue, 07 May 2013 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=SYZyWKvxb+JG9ARqEqMeGZu5i7U71Him3NPX6v85MYI=;
        b=toX55Ox7S2SvL2UMBtRgMEx1riGu6smoGEdSAmdQZSvBngY5t0QnxTXtbVFgux5ILF
         Z+3VPijuhcRBH2GRKi7xMe8m4M+Jy5XcP1ErmYtXdoDe59tf9rDIiI5Tux0r+HzRd4zD
         /MppEuwSXUlnnd0za2Sd22UeSqszrswKiW0cj6ZJHfvWhfMVchaZfO2LGbw1pXbUjn08
         Msiu/uGkZQI2ykvdMWD1WK1YsazmBJWjc4xtvWHVK5ARfuiXZWhO2l2A41HSorg/jW5C
         K67BARjn9J0R2u22N0Z4nI1uv9+ZjBQrZb2BKTzjFng26JOV85Uw2SFLNFXfbIi9UfDG
         0JOw==
MIME-Version: 1.0
X-Received: by 10.50.127.212 with SMTP id ni20mr644622igb.27.1367929250399;
 Tue, 07 May 2013 05:20:50 -0700 (PDT)
Received: by 10.64.58.34 with HTTP; Tue, 7 May 2013 05:20:50 -0700 (PDT)
In-Reply-To: <CAMuHMdWiQdUFREBMjQMmxrMa0LAOA2d3GqqeydyF5TK334ZwRw@mail.gmail.com>
References: <20130506160253.GA27181@linux-mips.org>
        <87mws8m3eu.fsf@hase.home>
        <20130507100447.GA15044@linux-mips.org>
        <CAMuHMdWiQdUFREBMjQMmxrMa0LAOA2d3GqqeydyF5TK334ZwRw@mail.gmail.com>
Date:   Tue, 7 May 2013 14:20:50 +0200
X-Google-Sender-Auth: XIdk-TxU-m6d4PV6CVw80U9atVY
Message-ID: <CAMuHMdWRJrvWw35yC4AHcC7o-DrTLz9kT9ipQs9XP=55oSNNYQ@mail.gmail.com>
Subject: Re: Build errors caused by modalias generation patch
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36339
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

On Tue, May 7, 2013 at 12:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, May 7, 2013 at 12:04 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Mon, May 06, 2013 at 07:19:53PM +0200, Andreas Schwab wrote:
>>> Please try the patch in
>>> <http://marc.info/?l=linux-kbuild&m=136767800809256&w=2>.
>>
>> No change in observed behaviour.  I did all my builds in empty object
>> directories so I don't see why this patch would make any difference.
>
> I'm getting this in an ia64 build (don't ask me why I build for itanic ;-):
>
> FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=14 is not a
> modulo of the size of section __mod_acpi_device_table=144.
> Fix definition of struct acpi_device_id in mod_devicetable.h
>
> This is next-20130501, with or without Andreas' fix.
>
> It works in my development tree based on yesterday's mainline
> (d7ab7302f970a254997687a1cdede421a5635c68).
>
> I'll try today's linux-next, and will bisect if I find time...

This was also caused by a leftover scripts/mod/devicetable-offsets.h in the
source tree.

Andreas' fix works (sort of, read on), but only if you run "make mrproper"
_after_ applying it.

Still, if you have other leftovers from a previous build in the source tree,
you get:

  Using /scratch/geert/linux/linux-next as source for kernel
  /scratch/geert/linux/linux-next is not clean, please run 'make mrproper'
  in the '/scratch/geert/linux/linux-next' directory.

However, you don't get that message if there's still a stale
scripts/mod/devicetable-offsets.h in the source tree.
Any idea how to fix that?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
