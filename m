Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 18:07:31 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61600 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819313Ab3FZQH3OsMWt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jun 2013 18:07:29 +0200
Received: by mail-pa0-f43.google.com with SMTP id hz11so14394196pad.2
        for <multiple recipients>; Wed, 26 Jun 2013 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=VmKs6OP7cNJ2DaP7eaz+4+eEIExnF7dQcXJJLIbxuvg=;
        b=GgVhzaQnODKh4mwA8SA0NOVNGOd4c3nG8clVnT0DF9mwuyBswOo7oTG/uaDBtm90O6
         fN9xhjiGRG0cTBSoGUn1SkI8CsP4O7gts9GGtjO3Pl9GXiVlhDEFvzhR2Mwis97U+0RH
         j03SrrgdtdkWczFDskDRcNNWtQ5mhRF4QN27qXvbhJPgErLwPgyzGSRvykvzwFUWpK6t
         7tcfbaOsnOMeq7KU+8eyzGyQkv1V9PerjTHX4ThIoZwcqezgFMjJMrrEB1hEvRphNyFY
         pvIvTf2Iuaw+/tP/NtPkw1DR5D7F2CnBNL5WJqV1g7iHhr8iAQv5SVqvAn0TEH7g4cDY
         Ca+A==
MIME-Version: 1.0
X-Received: by 10.66.160.97 with SMTP id xj1mr1436982pab.5.1372262842212; Wed,
 26 Jun 2013 09:07:22 -0700 (PDT)
Received: by 10.70.78.197 with HTTP; Wed, 26 Jun 2013 09:07:22 -0700 (PDT)
In-Reply-To: <20130626151854.GC7171@linux-mips.org>
References: <20130621110301.GA23195@hades.local>
        <20130626143115.GA7171@linux-mips.org>
        <20130626151854.GC7171@linux-mips.org>
Date:   Wed, 26 Jun 2013 18:07:22 +0200
X-Google-Sender-Auth: 4zKOSMI_O9D4je2Ap5ekrqAJSj4
Message-ID: <CAMuHMdWVTu2fzfOuxwsuvP9COKvuhMA+aNaWVESQZhBh9um9bA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add missing cpu_has_mips_1 guardian
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Tony Wu <tung7970@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37139
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

On Wed, Jun 26, 2013 at 5:18 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> If it's running Linus, that is.

Hmm, didn't know Linus is MIPS-based...

> Little complication: traps.c: was using a test for a pure MIPS I ISA as

Stray colon right after "traps.c".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
