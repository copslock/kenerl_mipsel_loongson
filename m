Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 18:40:50 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:62503 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903622Ab2CaQkh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 31 Mar 2012 18:40:37 +0200
Received: by iaky10 with SMTP id y10so2863002iak.36
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1gvUBb9X8sdaSti30XhAl0cTISR6tMUAtuiEIAJV86w=;
        b=U1IAi3J1LWCGP7xJZsEbmZmqfXk87w5hPxp5E6XfHg7pfofi0kbcBD8Y7GXknOzrir
         TOitCPpxeb1EhM+IwfZylVL00yJZWIjBQNq5dGn+D2W/4ksIV7Q9iKnTMN4lF0ugb96l
         XZN2tord8gvhagxbNKyh3qhvfkE/tcD85qgHLmWpSVTa/EgRdL817BRDR3CPJBKs5Atc
         EnR7MUKYbpvSnLbf4wsbbX4B3Hjr5IHnG4UXPMHFrGR7RtSL6zsVy5TOQjiDM9donS2y
         kx4gydOL7baLGQyC7b/NANYubkXarsr7NURB5TGpuv1KoB3TYA3gzBsZB7UbEFXj7NMR
         taqg==
MIME-Version: 1.0
Received: by 10.50.184.166 with SMTP id ev6mr1560961igc.63.1333212030863; Sat,
 31 Mar 2012 09:40:30 -0700 (PDT)
Received: by 10.231.27.25 with HTTP; Sat, 31 Mar 2012 09:40:30 -0700 (PDT)
In-Reply-To: <20120331163321.GA15809@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
Date:   Sat, 31 Mar 2012 18:40:30 +0200
X-Google-Sender-Auth: UB3gQvz7O3hjrWlritX9KwARi6Q
Message-ID: <CAMuHMdWTB+_AtqM6JixY=Oo_zmzX_dNxnivpARBYSbPJzp4t6A@mail.gmail.com>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     paulmck@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org,
        linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Paul,

On Sat, Mar 31, 2012 at 18:33, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> Although there have been numerous complaints about the complexity of
> parallel programming (especially over the past 5-10 years), the plain
> truth is that the incremental complexity of parallel programming over
> that of sequential programming is not as large as is commonly believed.
> Despite that you might have heard, the mind-numbing complexity of modern
> computer systems is not due so much to there being multiple CPUs, but
> rather to there being any CPUs at all.  In short, for the ultimate in
> computer-system simplicity, the optimal choice is NR_CPUS=0.
>
> This commit therefore limits kernel builds to zero CPUs.  This change
> has the beneficial side effect of rendering all kernel bugs harmless.
> Furthermore, this commit enables additional beneficial changes, for
> example, the removal of those parts of the kernel that are not needed
> when there are zero CPUs.
>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>
>  alpha/Kconfig                     |   11 ++++++-----
>  arm/Kconfig                       |    6 +++---
>  blackfin/Kconfig                  |    3 ++-
>  hexagon/Kconfig                   |    9 +++++----
>  ia64/Kconfig                      |    9 +++++----
>  m32r/Kconfig                      |   10 ++++++----
>  mips/Kconfig                      |   21 +++++++++++----------
>  mn10300/Kconfig                   |    3 ++-
>  parisc/Kconfig                    |    6 +++---
>  powerpc/platforms/Kconfig.cputype |    8 ++++----
>  s390/Kconfig                      |   12 +++++++-----
>  sh/Kconfig                        |   11 ++++++-----
>  sparc/Kconfig                     |    8 ++++----
>  tile/Kconfig                      |    9 +++++----
>  x86/Kconfig                       |   16 +++++++++-------
>  15 files changed, 78 insertions(+), 64 deletions(-)

You forgot to fix half of the architectures, a.o. m68k?

Gr{oetje,eeting}s,

                        Geert (still at GMT+2)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
