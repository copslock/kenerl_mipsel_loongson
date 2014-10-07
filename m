Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 10:32:52 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:57038 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009571AbaJGIcuXAk0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 10:32:50 +0200
Received: by mail-lb0-f178.google.com with SMTP id w7so5765724lbi.9
        for <multiple recipients>; Tue, 07 Oct 2014 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Mg5d5qP7jH6SVcgYlxpwYggn5Iy+dnN1aWDSQMc8AgE=;
        b=AD0sqFZjKt2wPsJyaRpIYvKcdC/wefVhLMer72TSHgg3bAzFrYtJwQ0iiMH6ovvyrB
         wTqlMxwtXAU3wU6WiB9kNgeLg7SlSMG3/cYF+aiURsk504qw6VCXrlfOFxUAwo7q0ch9
         f2egpi2iVutLYIa/8GhakkeQUxr1/xv/5wds+58MSpuQSydbFYLF7yL+k5RRFjwK1/J/
         YuJHfMsQi1LUjtkEKwuVZkDHmi9OgATHnhhgQHMfBabO4Tk+m6RJ8YPv0y0+PSG+rDkI
         u2vl77wubLAqquVplhvYuDb1W+lncRS21RZuNOntv2wh7C+fNCeg7YI2ZvBSgmONrZpf
         nN+Q==
MIME-Version: 1.0
X-Received: by 10.112.142.104 with SMTP id rv8mr2231170lbb.59.1412670764837;
 Tue, 07 Oct 2014 01:32:44 -0700 (PDT)
Received: by 10.152.30.34 with HTTP; Tue, 7 Oct 2014 01:32:44 -0700 (PDT)
In-Reply-To: <1412659726-29957-9-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
        <1412659726-29957-9-git-send-email-linux@roeck-us.net>
Date:   Tue, 7 Oct 2014 10:32:44 +0200
X-Google-Sender-Auth: t1uDeYcNgUgiBYL2fRgSRtusDG8
Message-ID: <CAMuHMdXQfYqhHnVKLHZvTyqE8Ke7jWEu7LKLR9ZfVQaO8mNtBw@mail.gmail.com>
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        driverdevel <devel@driverdev.osuosl.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        lguest@lists.ozlabs.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
        Cris <linux-cris-kernel@axis.com>, linux-efi@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-m32r-ja@ml.linux-m32r.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        openipmi-developer@lists.sourceforge.net,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        David Howells <dhowells@redhat.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43043
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

On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> pm_power_off is defined for all architectures. Move it to common code.
>
> Have all architectures call do_kernel_poweroff instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_poweroff from machine_power_off instead.

>  arch/m68k/kernel/process.c         |  6 +-----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
