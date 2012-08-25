Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2012 21:32:52 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:41637 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903681Ab2HYTcn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Aug 2012 21:32:43 +0200
Received: by vbbfo1 with SMTP id fo1so3446266vbb.36
        for <multiple recipients>; Sat, 25 Aug 2012 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WMSInLrBspDvrmPhhEmbt9mWRnqtkFzsLafRwZ0+eCE=;
        b=pNPmrTeg2fWsjdmlGGO+UNZRTOt+6nzoACqL/X2FPDtSlu6sf+cUOmvCHiAcmxPTdy
         sHilDYy2wRzB/HL3F/NLHhpzQki/4G3gjHP+11/Y2aeCicAnVavtaEfKPxSRvK15KQvQ
         4sJCI4SlUDLabSSrdeLgCkmPOrwadMSiIryVd5IFh+txVgip8PCE/FY+4RB9KpDeGAec
         j1XNwKyoUSlANx+KUSj5grUa4c+11KyA9Ra6zKPdEpF1zUEpR7rpgP7c5ll+ycqy23xA
         FZG2ww1DLOVv9HOiLAdCGC+xOT0Fp0TFAX+iq480ilBRg5ZHLrXOlHZd7aX9TUGXI+HQ
         0Vww==
MIME-Version: 1.0
Received: by 10.220.141.208 with SMTP id n16mr7731998vcu.22.1345923157165;
 Sat, 25 Aug 2012 12:32:37 -0700 (PDT)
Received: by 10.220.22.202 with HTTP; Sat, 25 Aug 2012 12:32:37 -0700 (PDT)
In-Reply-To: <20120822131130.d669275edf903d9a38a35789@canb.auug.org.au>
References: <20120822131130.d669275edf903d9a38a35789@canb.auug.org.au>
Date:   Sat, 25 Aug 2012 21:32:37 +0200
X-Google-Sender-Auth: kTfPM6SjwBm-jxz0IrPTKGxeWGQ
Message-ID: <CAMuHMdV9VdJ__yWZwzUnM3=XiRo7NWxiJnnoOBgZ9Jg8v0RTNg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rr tree with the mips tree
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>
Cc:     Rusty Russell <rusty@rustcorp.com.au>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34356
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Stephen, David,

On Wed, Aug 22, 2012 at 5:11 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the rr tree got a conflict in
> arch/mips/kernel/module.c between commit c54de490a2e4 ("MIPS: Module:
> Deal with malformed HI16/LO16 relocation sequences") from the mips tree
> and commit 9db0bbe072c8 ("MIPS: Fix module.c build for 32 bit") from the
> rr tree.
>
> Just context changes (I think).  I fixed it up (see below) and can carry
> the fix as necessary.

> + #endif

At first I thought this merge conflict resolution introduced the bogus #endif:

arch/mips/kernel/module.c:247:2: error: #endif without #if

(e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/6999289/)

but it seems to be present already in David's commit
bd029f48459adc8a72a2db95f7d79a7296c5ad5a ("Make most arch
asm/module.h files use asm-generic/module.h")..

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
