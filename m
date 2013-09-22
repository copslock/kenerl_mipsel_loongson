Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Sep 2013 22:22:10 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:65432 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288Ab3IVUWGARpS5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Sep 2013 22:22:06 +0200
Received: by mail-pd0-f176.google.com with SMTP id q10so2401993pdj.21
        for <multiple recipients>; Sun, 22 Sep 2013 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/2lXvillmj1mVRWlmkIaOSRJGh3s2tinFfh9RWGQwAw=;
        b=XhhkoGmP9nK7o2tQgqUyo0JXyeAQ/y9iDFo4+tmX3GFnLraPuPmXdaFkknIJWsYVMP
         CIZWRnQlJMk5Dlah5QkpzFjvELijHyfFRWLMWOda7s/TO+HRRzQJqLpfLc1AYaT/cUD2
         Zmd1dskiSMH77eGmEeMmzqLNqsUGI8mcCWhqXnsfOJtvT3tRiTiLsvW4nUugGVoruRmF
         TsoNAUARgdLx6zlAfJjIeuoBP2rzSs98ynWiK38Ob6yrhPx/7QlVepyB4ksZfY4pSkRX
         eUtLeYRWJ5Ui+vez+rNKJyy+TjUE+kfZfTYwr3/LWujOjExRJUq/cZaTQP4WJbWgFx5s
         pABQ==
MIME-Version: 1.0
X-Received: by 10.68.203.34 with SMTP id kn2mr20044380pbc.82.1379881319651;
 Sun, 22 Sep 2013 13:21:59 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Sun, 22 Sep 2013 13:21:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309201946430.8379@linux-mips.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
        <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>
        <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
        <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
        <1379702587.2301.12.camel@joe-AO722>
        <alpine.LFD.2.03.1309201946430.8379@linux-mips.org>
Date:   Sun, 22 Sep 2013 22:21:59 +0200
X-Google-Sender-Auth: ieO-E5hC-Bs7I5-UphDRdWXimyc
Message-ID: <CAMuHMdXCTo4keP6vcXzxS1OQcdPC48eMu3H=D7mW-bWgrSsN6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Joe Perches <joe@perches.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37911
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

On Sun, Sep 22, 2013 at 10:09 PM, Maciej W. Rozycki
<macro@linux-mips.org> wrote:
>  Thanks, but the changes required are actually much more than that -- the
> driver has never been converted to the modern TURBOchannel API.  I have
> now dug out an old patch I was working on back in 2006 to convert this
> driver as well as drivers/video/maxinefb.c.  I'll try to complete the two
> drivers as soon as possible (unfortunately I can't test the latter at all;
> it's for an onboard graphics adapter of another DECstation model),
> although I now remember the main reason I didn't complete them back then
> was they used an old internal API that was removed and no suitable
> replacement provided.  I need to investigate again what that actually was
> though (hw cursor probably).

pmag-aa-fb.c still has struct display_switch (for the old drawing API) and the
old fb_ops (with get_var()/get_fix()), instead of the new fb_ops (rectangular
drawing API and var/fix as member data).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
