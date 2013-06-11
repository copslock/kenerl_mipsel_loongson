Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 12:00:33 +0200 (CEST)
Received: from mail-wg0-f54.google.com ([74.125.82.54]:65348 "EHLO
        mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835165Ab3FKNhwnBXJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jun 2013 15:37:52 +0200
Received: by mail-wg0-f54.google.com with SMTP id b12so1225305wgh.9
        for <linux-mips@linux-mips.org>; Tue, 11 Jun 2013 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3a5ak/HNh+roXBtZHiVLTxZSoYo06N16safRWMseoZg=;
        b=xPXqvnOSCOGywHHLZW0N8oGrIAkb2eY8YIFgPC8oWwYZdGtV+5uQRgnX/NsBHwF2cb
         sbtLiarw0lSxqr4QF9qSWo1ZQHBUJ3nKGwcIpJ6LNNHlGyPOWMNL+BnSFXQw/IB7Zd3a
         T3q+HBwENVTgDQJchO4197F47LXSCXWe+2GvyZNUOKC7fbMOuvMjyTfr9zj4CHa7CmUr
         XEZgXggMy5GHZR/idjTT4iwzDCs3MWjKAKytm7YcYqxuU+KGzl4IZ1vMMDQgGKDqCPZS
         YkRCEMyQ4Zjd/dBuINkh21SipCWU95+6/f3kyCClFTJLw4b4dLzFX1xEszuycHdz/rrN
         aeiw==
X-Received: by 10.194.87.100 with SMTP id w4mr6225631wjz.34.1370957867279;
 Tue, 11 Jun 2013 06:37:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.136.115 with HTTP; Tue, 11 Jun 2013 06:37:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305122245510.5463@ayla.of.borg>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg>
 <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg> <alpine.DEB.2.00.1305122245510.5463@ayla.of.borg>
From:   Markos Chandras <markos.chandras@gmail.com>
Date:   Tue, 11 Jun 2013 14:37:07 +0100
Message-ID: <CAG2jQ8gLOGM4YkPi_utj6+2SkXRyQj8cwUTfaJiZMjqEMPHenA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.10-rc1 (mips)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Development <linux-kernel@vger.kernel.org>,
        "Linux/MIPS Development" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37195
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@gmail.com
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

On 12 May 2013 21:46, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, 12 May 2013, Geert Uytterhoeven wrote:
>> However, the full list of errors isn't that unmanageable, so I'm following
>> up with a digested list...
>
> arch/mips/kernel/crash_dump.c:67:17: error: assignment makes pointer from integer without a cast [-Werror]: 1 errors in 1 logs
> arch/mips/kernel/crash_dump.c:67:2: error: implicit declaration of function 'kmalloc' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
>         v3.10-rc1/mips/mips-allmodconfig
>
>
> drivers/net/ethernet/3com/3c59x.c:1026:2: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
> drivers/net/ethernet/3com/3c59x.c:1038:3: error: implicit declaration of function 'pci_iounmap' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
>         v3.10-rc1/mips/mips-allmodconfig
>
>
> sound/oss/soundcard.c:69:31: error: 'MAX_DMA_CHANNELS' undeclared here (not in a function): 1 errors in 1 logs
>         v3.10-rc1/mips/mips-allmodconfig
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
>

Hi Geert,

My understanding is that this driver shouldn't depend on (PCI || EISA)
but rather on PCI because the PCI support in that driver do not
seem to be optional.

--
Regards,
Markos Chandras
