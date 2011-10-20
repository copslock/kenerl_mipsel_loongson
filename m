Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2011 19:14:49 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:40887 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab1JTROn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2011 19:14:43 +0200
Received: by iagz35 with SMTP id z35so4021621iag.36
        for <multiple recipients>; Thu, 20 Oct 2011 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nwZ1eV/CjDM6ircaSAD9Xby4rFF4m86dFAGosArxgtE=;
        b=fY+9uZXYOLEWiWkiZH+MGWF7FU8fYr0kOfOwrueusD2nhJ5sS6CirTv4QmgJvl0shO
         GWDFWD0+i3QKBdCUXpyuS7nXfrjGJKX6ekLwcaonHw4T3IJGD57FgCHPwjklVwaHbF9N
         ZIim/Lpxj3e4te20IFOd1Ij4Q5WJXWXMCzBII=
MIME-Version: 1.0
Received: by 10.231.25.229 with SMTP id a37mr4723609ibc.8.1319130876500; Thu,
 20 Oct 2011 10:14:36 -0700 (PDT)
Received: by 10.231.14.196 with HTTP; Thu, 20 Oct 2011 10:14:36 -0700 (PDT)
In-Reply-To: <20111020161908.GA13220@linux-mips.org>
References: <20111020150859.6072A1DA26@solo.franken.de>
        <20111020161908.GA13220@linux-mips.org>
Date:   Thu, 20 Oct 2011 19:14:36 +0200
X-Google-Sender-Auth: zd9dNmkCuydNgn0O_dIiYH3lWkM
Message-ID: <CAMuHMdXuOAgwPKTUjBCp3t1_kWoJsiwGf=uQfmYP_o+t7JYxUA@mail.gmail.com>
Subject: Re: [PATCH] GIO bus support for SGI IP22/28
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15183

On Thu, Oct 20, 2011 at 18:19, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Oct 20, 2011 at 05:08:59PM +0200, Thomas Bogendoerfer wrote:
>
>> SGI IP22/IP28 machines have GIO busses for adding graphics and other
>> extension cards. This patch adds support for GIO driver/device
>> handling and converts the newport console driver to a GIO driver.
>
> I like it - finally proper driver structure in the year 15 of Indy
> support :D

Did GIO ever appeared on non-MIPS platforms?
If yes, you want to move it to drivers/gio/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
