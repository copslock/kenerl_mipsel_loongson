Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Feb 2011 09:12:27 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:61499 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491841Ab1BYIMX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Feb 2011 09:12:23 +0100
Received: by fxm16 with SMTP id 16so1694900fxm.36
        for <linux-mips@linux-mips.org>; Fri, 25 Feb 2011 00:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gN+niR4Jxtm+i+e9wAEl7xZobLozzMz3R7EEz6pmFhA=;
        b=QPhP3sWYiFoSn5oqvq1Nkzoh/5BT6ofySzfewoYekoZMD1rMv34RlP5ovDRyFEysnz
         9qSVckD9JoR3UUtEXm4vlzrt2ytLMNXqH8jhahtry7dCbGlC9RnDxaZCC08j5aoJ2k2b
         mVLiRRdz4HyPRniKUe/N11Nblk75YAFD5undk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AkeZn4HFs5awue4fB9hurqZCCXYVITaKYJQ2d/fR8+gQo5xh2eV5EC8JQbx79Eo9+A
         B8q1d/AGMahm5/93aU/gum4b46HrinMbZGMAlAIh/5GdLcMrBWbe9xw0k5CpylffuLwv
         Zi81aUxmTsqGsqF6zxTEtNfxgF6fZOK4DIyic=
MIME-Version: 1.0
Received: by 10.223.103.4 with SMTP id i4mr1819829fao.123.1298621536367; Fri,
 25 Feb 2011 00:12:16 -0800 (PST)
Received: by 10.223.119.73 with HTTP; Fri, 25 Feb 2011 00:12:16 -0800 (PST)
In-Reply-To: <4D672850.80902@gmail.com>
References: <4D672850.80902@gmail.com>
Date:   Fri, 25 Feb 2011 09:12:16 +0100
X-Google-Sender-Auth: ksw69HasabivvvrAMY8SW7n_Z1M
Message-ID: <AANLkTik8ynTVq--A-u1nYCt_AX4RPqVGdep6JfZ7m86x@mail.gmail.com>
Subject: Re: Memory needed for hibernation too much
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jacky Lam <lamshuyin@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 25, 2011 at 04:56, Jacky Lam <lamshuyin@gmail.com> wrote:
>    I try the hibernation feature with my MIPS box which has 128MB RAM. After
> boot up, it remains to have 110MB something. Then I mount ramfs on a
> directory, create a file 100MB from /dev/urandom and enter hibernation. The
> process failed because of no memory. Then, I continue to cut the data file
> size and not success until 20MB.
>
>    I want to make sure if it is an expected behavior or I am doing some
> wrong?

How large is your swapspace? Hibernation needs space on swap to store
the contents
of RAM (that cannot be loaded again from somewhere else).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
