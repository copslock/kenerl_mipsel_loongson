Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 10:51:54 +0100 (CET)
Received: from mail-vb0-f51.google.com ([209.85.212.51]:41310 "EHLO
        mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823034Ab3APJvxu4q8D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 10:51:53 +0100
Received: by mail-vb0-f51.google.com with SMTP id fq11so1097357vbb.24
        for <multiple recipients>; Wed, 16 Jan 2013 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1shXhpzl2Ee/qd2brAzr2dBY68W5bdvYRXsoD/ACQOo=;
        b=mU0+lWBMhha4gRozGTX6KdkUiN1v7RJ+rd5M1lL3WqtB1IoweRl7BHOeSnzUM10O9e
         ZuWKRMHveUhTQvUtea9q0Hifib1pIq+shQHm0OtqaBfkL6H4OyK+U+n0BRqTCKWukNxX
         sotYyDCfrpx/UqzjSUr2ocGi1B+fjzI//0iwSg37JuylCfai6hJLosNVftXQw7Lsqlvu
         1vqx+cC9P2ke4ttBc/PJ0DWDyYCURS4b+31v+WWa6H62gHmfiRp8Iq5vbdSdGJsMcJXF
         ZAeLafNqJaO/8geq0vKgf/KMP98YjOGkvUV5q67LjjxfFVyQ5tgK1nTXzBXMezKxRFvS
         2XhQ==
MIME-Version: 1.0
X-Received: by 10.220.231.138 with SMTP id jq10mr456758vcb.29.1358329907501;
 Wed, 16 Jan 2013 01:51:47 -0800 (PST)
Received: by 10.58.227.168 with HTTP; Wed, 16 Jan 2013 01:51:47 -0800 (PST)
In-Reply-To: <1358320033-30032-1-git-send-email-thierry.reding@avionic-design.de>
References: <1358320033-30032-1-git-send-email-thierry.reding@avionic-design.de>
Date:   Wed, 16 Jan 2013 10:51:47 +0100
X-Google-Sender-Auth: uYOHyEzO4lfbyWdXJVxmPZ6t5Z0
Message-ID: <CAMuHMdVYCx+qyWwYh0pEZyeLOSz+5_7=fYAa7aAteGt-GmH2og@mail.gmail.com>
Subject: Re: [PATCH] MIPS: PNX8550: Fix build failures
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35461
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

On Wed, Jan 16, 2013 at 8:07 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> The OHCI support code fails to build because the PCI_BASE and udelay()
> macros which are defined in pci.h and linux/time.h respectively. Adding

> +#include <linux/delay.h>

time.h or delay.h?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
