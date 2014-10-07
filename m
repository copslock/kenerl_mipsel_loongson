Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 11:19:43 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:42817 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010687AbaJGJTmAptLa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 11:19:42 +0200
Received: by mail-lb0-f171.google.com with SMTP id z12so5800802lbi.16
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3bI5zwPc81h9QH8a5IVnm+hmZu7byYq4VebIe/T6rTM=;
        b=a4/Y310k8Eq5hIttT3kqJDAxWLGNuUSbJiMHAOAxRxi6hm2EyhHkQgDQc0Hn+G/nWJ
         FHE7P4fD9RZqzNcLlZCEvS2Z93GSKUT2lYyKufbM1UAwvdpq1VaAczskBRD96n8rdBo3
         HEhsPAMi/uYdGKcrP+XYJj0Mz5Pz6dDZPSYCXllbj+ZsKf4qoBJnBrub4XbqfbeBVwdb
         zasBOEgdpcFPPQCIzDQjSzobOGtdKcJKtWfms9Smbc4/4yY5GEBey5kJIMtnudUg6JT4
         KBpNXu2yUb2O0plCGJnuzBMZUBkuFC6EGDO1owVZ9bGcNVijFTmN806jzaqyzswv0NKt
         xW4Q==
MIME-Version: 1.0
X-Received: by 10.152.21.226 with SMTP id y2mr2727896lae.34.1412673576323;
 Tue, 07 Oct 2014 02:19:36 -0700 (PDT)
Received: by 10.152.30.34 with HTTP; Tue, 7 Oct 2014 02:19:36 -0700 (PDT)
In-Reply-To: <1412659726-29957-36-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
        <1412659726-29957-36-git-send-email-linux@roeck-us.net>
Date:   Tue, 7 Oct 2014 11:19:36 +0200
X-Google-Sender-Auth: H8CqPrWYHuzCKE6AZjzih_WrqS4
Message-ID: <CAMuHMdVZmsjK9FdK0T6mWwrnNc=Xc97B7ynm+QbWUMBCnvQB_g@mail.gmail.com>
Subject: Re: [PATCH 35/44] m68k: Register with kernel poweroff handler
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
        xen-devel@lists.xenproject.org, Joshua Thompson <funaho@jurai.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43046
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
> Register with kernel poweroff handler instead of setting pm_power_off
> directly.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

As someone already mentioned, having #defines instead of hardcoded
numbers for the priorities would be nice.

Apart from that:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> +       register_poweroff_handler_simple(nf_poweroff, 128);

> +       register_poweroff_handler_simple(mac_poweroff, 128);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
