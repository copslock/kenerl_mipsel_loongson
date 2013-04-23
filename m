Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Apr 2013 17:14:28 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36422 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835120Ab3DWPOXvFDoz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Apr 2013 17:14:23 +0200
Received: by mail-ie0-f177.google.com with SMTP id 9so797062iec.36
        for <multiple recipients>; Tue, 23 Apr 2013 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=zMlRVKNQAuIJFAdRndSyw3mQT5SUX82fq8Ft4GR3U6I=;
        b=vMsRZ5clA+BEBjs8RVtEpXqQWklJ9gtU/uuaBsqF32IOF18N8Y0jOnB5QNS2JYWLAK
         eJ7Fidcg6e8e6z3ZCnGxx27TzjPIgVtQDiwnDNHJ0MMbGeLngbElNCNi3zzriECqWtWi
         wkYbrnEiuF0lQvKuW6EgmiaBSOZEaBcSs19Hlo2QRRipv8gkBSwYmdzirYOGwXV6Af8v
         d6Ujq913aZR2F6o9bDYzeFuysKfiHchXGjjk2YdLiFJy4yjucc/a54NfChUztuojmxmU
         dp7tUs6Taz3iva/3N11tYnp8ciUZ++QiXJKSkzohxRxjHC9yqxELJxl6cveFyS2QF1tv
         M2LQ==
MIME-Version: 1.0
X-Received: by 10.50.15.166 with SMTP id y6mr18915621igc.83.1366730057079;
 Tue, 23 Apr 2013 08:14:17 -0700 (PDT)
Received: by 10.64.48.231 with HTTP; Tue, 23 Apr 2013 08:14:16 -0700 (PDT)
In-Reply-To: <516EE5E4.1010605@corelatus.se>
References: <516EE5E4.1010605@corelatus.se>
Date:   Tue, 23 Apr 2013 17:14:16 +0200
X-Google-Sender-Auth: EX9KmP7CkgGGICJv6pzoKuSIAC0
Message-ID: <CAMuHMdU4EE2jOtud+YQ6-o08VVWyMsqQRYNZzOntV0+xHxkUzA@mail.gmail.com>
Subject: Re: c17a6554 broke 64BIT_PHYS_ADDR for 32 bit systems
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Lange <thomas@corelatus.se>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36287
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

On Wed, Apr 17, 2013 at 8:11 PM, Thomas Lange <thomas@corelatus.se> wrote:
> commit c17a6554 unintentionally(?) modified the PAGE_MASK type
> from (int) to (long unsigned int).
>
> This breaks ioremap (and possibly more) when using 64BIT_PHYS_ADDR on
> 32 bit systems.
> Example of failing code from ioremap.c:
>
>         phys_addr &= PAGE_MASK;
>
> Since phys_addr is 64 bit (unsigned long long) when 64BIT_PHYS_ADDR and
> PAGE_MASK is 32bit (long unsigned int), the upper 32 bits will always
> be zeroed which is not what we want/expect.
>
> The code above works if PAGE_MASK is a _signed_ 32bit int though.
>
> Some possible fixes:
>
> A) Simply revert the commit. Makes ioremap work again, but then PAGE_MASK
>    is a signed int. Do we really want a mask that is 'signed'?

Already fixed, cfr. https://lkml.org/lkml/2013/4/22/518

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
