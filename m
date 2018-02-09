Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 09:49:03 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:38144
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeBIIszvpRu7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Feb 2018 09:48:55 +0100
Received: by mail-qk0-x241.google.com with SMTP id w128so9094750qkb.5
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2018 00:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AZxRHPIgvid5B4BOGdOPys1/VynIs07ANWeOJbzSUB0=;
        b=sqRbqBprQ46EvOn8wkN1vA2FHQZOLxFHpg/49eA4VxFCuqeHKQiCZ+t1PWEeJHhvbC
         GobYxsDKn1xi8tgPuhxF8a6cTMgd5DNNMTXcZ5JaRlShrI/qhDbjslEbD1Xpchg0od83
         e4qKE8mF7vT7fCKrW8eiOBqcIWI8Q6kZEt14AWlHlAUjwy2bFkUHORIZPRiaXLcTzb0C
         lVY7azdNx+jP3xVBjkowEu3MZv9I2oIOUJcnGA9iV6CyiqsP76tzdq7uoTZsr5FIbyDb
         otSiJiqKvGqBXXI1YNBgYdiFcC6einEET6s7OdFKM9EN2lnYyDFHNyQzoHNT3D97V9kB
         nmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AZxRHPIgvid5B4BOGdOPys1/VynIs07ANWeOJbzSUB0=;
        b=bWhQhed9t7b0OKs4DsUd68PToJb0hYElsNp0a7WOItxHvRPvdwS4wXx4kvSI04GogN
         bzK4VfG/qBA0QQ0eK4RJd6y9k7+YVgL53bzaSYDwDqHe/vW43JtQg7Txa76vs6Ww54TD
         2CgTjy5QzQfJQYVIRF/Obpr4HVpRg3Tde3+hpCG6i2gb3R9q279y82X4IEy25XLcOSt3
         5hfLi4ndaAGmR8iYtcVynPV+FDi/c8+Ve5hdKkcp2MVtpVrPNbgtaOTisd8KQTummWGm
         DWXiLh+DnKFXi+2AcuW89Q8MXrfgDvUTldGw4AacJPzSy/VcpoG0Eb3w8NuysAh8o1Jf
         PyIQ==
X-Gm-Message-State: APf1xPDXZTy6t3tuR0Q93EBkQY0lWv/l0SI0Nx9yTFRKVkX33Mr0pdrW
        8itH4ngvC4QDVkic9M7rKEIlv/6B+Lq/ldMu+iA=
X-Google-Smtp-Source: AH8x226jPwV2gr4bMBnd27APuJlsc3ei0XOJzfRk0+DwtlsDckh7L+dsZ51TeZG3JMvQ5BNPpGkcYYfU0UU+M+KGX38=
X-Received: by 10.55.247.26 with SMTP id q26mr2776493qkj.234.1518166129608;
 Fri, 09 Feb 2018 00:48:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.39.197 with HTTP; Fri, 9 Feb 2018 00:48:48 -0800 (PST)
In-Reply-To: <20180209021031.20631-1-jaedon.shin@gmail.com>
References: <20180209021031.20631-1-jaedon.shin@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Feb 2018 09:48:48 +0100
X-Google-Sender-Auth: RoxBSjWB4i7i220GSR2RhDFTock
Message-ID: <CAMuHMdXOtrnMrNkuexHdpX+asaG1ADwmb5JWwAYYrvvvn0P8ZQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Use %px to print pointer value
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62469
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

Hi Jaedon,

On Fri, Feb 9, 2018 at 3:10 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers printed with %p are hashed. Use %px instead of %p to print
> pointer value.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Thanks for your patch!

> --- a/drivers/irqchip/irq-bcm7038-l1.c
> +++ b/drivers/irqchip/irq-bcm7038-l1.c
> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
>                 goto out_unmap;
>         }
>
> -       pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
> +       pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>                 intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);

I believe the printing of this value should just be removed.
Printing virtual addresses of mapped registers is usually not helpful, except
for an attacker.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
