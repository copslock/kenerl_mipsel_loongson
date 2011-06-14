Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 22:32:21 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:41927 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab1FNUcP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jun 2011 22:32:15 +0200
Received: by bwz1 with SMTP id 1so5940641bwz.36
        for <multiple recipients>; Tue, 14 Jun 2011 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KzkoSRMjjxeyMdrEfq9fKim/oOIUm71Xi6HgFSwA65E=;
        b=wh5uIAK7aK1opglWkMnwKyv3dlU1zwE5dz+Rkh+DxdNpztxhe1puLAXDx7zxYNmy/g
         06DjOH1DINOQxmomwij7FuKVeli9tyWFg1i0Bzpvhj5KNGsPebTlK1iSCxK7x4vKcchK
         BODymjrul6jl3k6FqOYz7YF5li066ABgHu+5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=OQDrhiltq8cQzWLa6qKZb3zVPhcEA6/qD85YkvqEMz/t1U3kM+aMGJ9JWPkeJ+xAvj
         2+1FnXJu+ggCTmeeGTVBCiC86MEENN6PdAuyWB8oMLsyXXwZ2bww+kaYLHQTcN04VpGI
         wRmO1r0DCZHB7iYgqnh662Qt4qL8Q8Fa/Gwt4=
MIME-Version: 1.0
Received: by 10.205.83.133 with SMTP id ag5mr866783bkc.121.1308083528897; Tue,
 14 Jun 2011 13:32:08 -0700 (PDT)
Received: by 10.204.5.130 with HTTP; Tue, 14 Jun 2011 13:32:08 -0700 (PDT)
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
Date:   Tue, 14 Jun 2011 22:32:08 +0200
X-Google-Sender-Auth: sK222PWDtiEmyoKRGb0wUOnfD98
Message-ID: <BANLkTikuVsFS-UbS+Dap2Zy-f1+qLc1TLw@mail.gmail.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Lennox Wu <lennox.wu@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Mikael Starvik <starvik@axis.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11874

On Tue, Jun 14, 2011 at 21:08, Ralf Baechle <ralf@linux-mips.org> wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
>
>       depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
>               (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
>
> This isn't just ugly - it also almost certainly describes the dependencies
> too coarse grainedly.  This is an attempt at cleaing the mess up.

> --- a/arch/m68k/Kconfig.mmu
> +++ b/arch/m68k/Kconfig.mmu
> @@ -399,6 +399,7 @@ config ISA
>        bool
>        depends on Q40 || AMIGA_PCMCIA
>        default y
> +       select PARPORT_PC

Why do you select PARPORT_PC here instead of HAVE_PC_PARPORT?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
