Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 13:24:36 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:60907 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491040Ab1FOLYc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 13:24:32 +0200
Received: by bwz1 with SMTP id 1so466724bwz.36
        for <multiple recipients>; Wed, 15 Jun 2011 04:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z1KTW2uOCYijPRZGY4wMIXaSj/CLGvkowI1pYxwn2I8=;
        b=F9K4PnYSrphTUPFtjyx7sIDD31+KIYXR8vz1nn7Bsi7GudUqIYHBNA1N0NkQ3urp7j
         BkOJ9F/AQiGH7+HLmIt2AiUcIHLfk/6NTaroW2cd5R+5G6VoGAGnVvEmPY1dAZMLQ6Z5
         3qmsje2Gram/nMMhJUfWfHjO28eHB0hAOtrAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=n4vGYZ7jjdiWtEe00gTKMZIiGrFDZRmvPt7nrELkoZ4iBtU5D0QNxOOSsWDuGV2nr5
         FKvHaexFU8c4J2sSE0IEkV3zmRtxeLLTgPs05cu1wvhgNa5ukGWcXuRiIlrOnM3sbABE
         86r1iJydidL+06p1WwA0zSqbJg+cP+DaN2dF4=
MIME-Version: 1.0
Received: by 10.205.83.133 with SMTP id ag5mr403547bkc.121.1308137064885; Wed,
 15 Jun 2011 04:24:24 -0700 (PDT)
Received: by 10.204.5.130 with HTTP; Wed, 15 Jun 2011 04:24:24 -0700 (PDT)
In-Reply-To: <201106151146.13320.arnd@arndb.de>
References: <20110614190850.GA13526@linux-mips.org>
        <201106142333.16203.arnd@arndb.de>
        <4DF83577.6040903@zytor.com>
        <201106151146.13320.arnd@arndb.de>
Date:   Wed, 15 Jun 2011 13:24:24 +0200
X-Google-Sender-Auth: xtqG9DxGsRbwd0OHLPKkj7TFyaI
Message-ID: <BANLkTimMLDb6LL0HZv8XtHt=zvyE7eybyg@mail.gmail.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Chen Liqin <liqin.chen@sunplusct.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        microblaze-uclinux@itee.uq.edu.au,
        Chris Metcalf <cmetcalf@tilera.com>,
        Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12288

On Wed, Jun 15, 2011 at 11:46, Arnd Bergmann <arnd@arndb.de> wrote:
> * In case of floppies, the "solution" was to write a driver for every platform that
>  doesn't have PIO, since they tend to have other differences. The amiflop and
>  ataflop drivers are not even use readb(), they just derefence volatile pointers
>  to do MMIO. I doubt we can find volunteers to clean that up.

Amiflop drives the Amiga floppy controller, which is completely
different from the
PC-style floppy controller.
Ataflop drives the Atari floppy controller, which seems to be a WD1772 and not
related to PC-style floppy controllers neither.

So none of them drive PC-style hardware, and both predate the generic readb()
infrastructure.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
