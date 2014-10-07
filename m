Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 10:29:59 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:56145 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009571AbaJGI35zobjY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 10:29:57 +0200
Received: by mail-la0-f46.google.com with SMTP id gi9so5876080lab.19
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SDL72kCKNF8JLpJHnz58hqvvIcY2NY0ZTjQBnQQwIEE=;
        b=GWmNef4MQuOAlLAVcHRnHoClxxSM/7VBvY+uDuK+H5MSOwd7yMNbFGD0A39Vma118o
         YvCzyUqLbxpfIcX7MMMuIyidvq6nTf6Hlf6WYA3MUOmcCTCsWrpzxaSJ43VOyUPPyZlC
         Hv52z8K6qsYRgkBwWcKAoSfitc2E5v0MuSpjOIUJHH/a5UXxNJ9A46Ipks0R4pF8X8gN
         jiNRFW7OYAN2Lbwnw+RJPQIPZ9tGleV2jrzC47d8d79WeCYOMCj5Ilowea5uqangg9se
         SauL3QtiAGIbr4psUZsz9beREWywAen0teLc+M7vROVyTtw2WZnfcugepTwTIZLnuwmb
         nL3A==
MIME-Version: 1.0
X-Received: by 10.152.115.229 with SMTP id jr5mr2425721lab.7.1412670592421;
 Tue, 07 Oct 2014 01:29:52 -0700 (PDT)
Received: by 10.152.30.34 with HTTP; Tue, 7 Oct 2014 01:29:52 -0700 (PDT)
In-Reply-To: <1412659726-29957-5-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
        <1412659726-29957-5-git-send-email-linux@roeck-us.net>
Date:   Tue, 7 Oct 2014 10:29:52 +0200
X-Google-Sender-Auth: YVmk6G6Y_arslkhUkh3UeU79PuU
Message-ID: <CAMuHMdVK+h0DAysDrfYQSwN9zjygTpHRkdkfeDucyoTBN5f=+w@mail.gmail.com>
Subject: Re: [PATCH 04/44] m68k: Replace mach_power_off with pm_power_off
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
        xen-devel@lists.xenproject.org, Greg Ungerer <gerg@uclinux.org>,
        Joshua Thompson <funaho@jurai.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43042
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
> Replace mach_power_off with pm_power_off to simplify the subsequent
> move of pm_power_off to generic code.

Thanks!

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks OK, so since you said it builds ;-)

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
