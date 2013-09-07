Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Sep 2013 15:53:40 +0200 (CEST)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50852 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab3IGNxg5VGlA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Sep 2013 15:53:36 +0200
Received: by mail-ie0-f174.google.com with SMTP id k10so948442iea.33
        for <multiple recipients>; Sat, 07 Sep 2013 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=85brpEYDAkgNltEE7Rr3H6EzS6bhncmUJCnw2sYo3kI=;
        b=WuVBA7w2GS+r5l9Gnggmakg9Q+TYxOvc+pQ1mfGfFZSpYrf4+H2XNjIm5JaYDW2jkD
         PfY5eVHIL75gwomw3xVMDOVE/WVCRQSbzkIZHXaChoc5CK4a7jNUT6TS5T+OpjJ/4LLO
         VLxI/LOtAIxqcBUtszNQ4H4ViPOY0Qy3QT5bxGWkmCQvz8qZYBhuBudComaf339EAGZC
         Z/mE6icAgOIyMx7zCYueHglKO8X6HpRvHLBMxz6ET6cQ6okOvgWw8m61iiWscCQaJKsr
         RU6mrMOMuisy9uB6yunRPIOWDD6+HCUu0l9+1o0rFDW0jovEKVPB/Kfg77vsULvZnOmD
         E6Dw==
MIME-Version: 1.0
X-Received: by 10.50.7.101 with SMTP id i5mr2161758iga.48.1378562010428; Sat,
 07 Sep 2013 06:53:30 -0700 (PDT)
Received: by 10.64.245.240 with HTTP; Sat, 7 Sep 2013 06:53:30 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>
        <20130905180825.GB11592@linux-mips.org>
        <alpine.LFD.2.03.1309052118560.11570@linux-mips.org>
        <20130907073450.GE11592@linux-mips.org>
        <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
Date:   Sat, 7 Sep 2013 15:53:30 +0200
X-Google-Sender-Auth: RYdeJq-e-UqvTN7QOywO0MYYdR8
Message-ID: <CAMuHMdWdc1ncuh4vcLFPmZPj1bdK6ma_Zu9RTJrbMk2ysPuEug@mail.gmail.com>
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37777
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

On Sat, Sep 7, 2013 at 2:48 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>  BTW, is it normal these days that /proc entries like /proc/iomem,
> /proc/net or /proc/sys are omitted from the /proc directory listing?  They
> can still be opened if you know the name.  I've been wondering if it's
> been a change made sometime or an odd effect of a possible compiler bug.

That's a regression introduced in early v3.11-rcX, and fixed in v3.11-rc7.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
