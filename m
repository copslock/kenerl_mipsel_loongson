Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 12:58:50 +0200 (CEST)
Received: from mail-ia0-f176.google.com ([209.85.210.176]:49330 "EHLO
        mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823763Ab3EGK6rM9o0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 12:58:47 +0200
Received: by mail-ia0-f176.google.com with SMTP id j38so282286iad.7
        for <multiple recipients>; Tue, 07 May 2013 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=OcrbXUUS3/SDsXYlFL0ABusj6ObdSalOY93rlUFCDwU=;
        b=NnZMX94sL8sjIOAwIxTEgoC37UHP+ernA7VmhMLyiE8h5WaY9s/TZlFCZVYNe+PVXP
         EO+IeRwDsqFztS4pKvhJYUWRX/ADad9UTvaFqrL56sNFhtvurAgnSDLuKksR3HvQQmNn
         WmY8zYYIIJGVYfG+GkotVe75Zv02L9h3bc32b3xWyMmQof4lzdTkxyHOsCgrCkSub2At
         e1+qDUkUNM8cjlv4wosvDr92w8fT4KLxWp5T5dBEsXcUhDo8xPStoCDE4L+9fQp2D0mM
         JvnXHHvC03VjgETgu+kY61/LZQZiuqeI2toQx5U7qdGYDiioGFHZOfTAaTLy7jQ5aiSK
         iKoA==
MIME-Version: 1.0
X-Received: by 10.50.15.166 with SMTP id y6mr512287igc.83.1367924320771; Tue,
 07 May 2013 03:58:40 -0700 (PDT)
Received: by 10.64.58.34 with HTTP; Tue, 7 May 2013 03:58:40 -0700 (PDT)
In-Reply-To: <20130507100447.GA15044@linux-mips.org>
References: <20130506160253.GA27181@linux-mips.org>
        <87mws8m3eu.fsf@hase.home>
        <20130507100447.GA15044@linux-mips.org>
Date:   Tue, 7 May 2013 12:58:40 +0200
X-Google-Sender-Auth: 5rb3r5HzS3VcYu4i40ysGnFGpBw
Message-ID: <CAMuHMdWiQdUFREBMjQMmxrMa0LAOA2d3GqqeydyF5TK334ZwRw@mail.gmail.com>
Subject: Re: Build errors caused by modalias generation patch
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36338
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

On Tue, May 7, 2013 at 12:04 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, May 06, 2013 at 07:19:53PM +0200, Andreas Schwab wrote:
>> Please try the patch in
>> <http://marc.info/?l=linux-kbuild&m=136767800809256&w=2>.
>
> No change in observed behaviour.  I did all my builds in empty object
> directories so I don't see why this patch would make any difference.

I'm getting this in an ia64 build (don't ask me why I build for itanic ;-):

FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=14 is not a
modulo of the size of section __mod_acpi_device_table=144.
Fix definition of struct acpi_device_id in mod_devicetable.h

This is next-20130501, with or without Andreas' fix.

It works in my development tree based on yesterday's mainline
(d7ab7302f970a254997687a1cdede421a5635c68).

I'll try today's linux-next, and will bisect if I find time...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
