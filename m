Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 12:26:07 +0200 (CEST)
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38397 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993008AbeGEK0AM0lJ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 12:26:00 +0200
Received: by mail-ua0-f194.google.com with SMTP id 59-v6so5087115uas.5;
        Thu, 05 Jul 2018 03:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWIZwMKupWPY1Kb/3d4c4VyQGP3Xh0ygBTR8X3bQEIs=;
        b=alb369NaC4pnu6/qk/jBK9W01pOcuHuqF9iXQLg1sT+ucwl8ApnsM1SWbx9bjGfty/
         eVOn0fZaJYqkpHouqagTC+VkwUVo3IjfqaKFSZDdkKPaH/3D0eYZc+Me7bQg2f55eKii
         UD2dPUg5uQtdLS8gXMp1kBrSY0n6Zwu4yH2JLKYAhdAFghCGa5B9O9rZbnP/y++OSHQb
         /fNrdRDoE8PIk7c/wzIHlaMx5tUxN0MSu/UNoii8hIyGZGH3RidS4ivaLzWdAaZTwhN6
         9C3k/xdnB0bdEVkCvwwK8i0OYUwunL3VmPjtMBuki47ydBRCfJMR0u3T3FiI6teIubkt
         8xmw==
X-Gm-Message-State: APt69E0GwlzPZ1BSWePXriRZi4AZsiT3/FQ5JLQHhjj3gpMV5U3zvtzc
        ui9efGzSNZjewGbXakL+Ju1TWa+fSEfZOKP+CzM=
X-Google-Smtp-Source: AAOMgpc+3TWCBT+n77254bRvqf70rAKzj21LSHgfy/2YNcnokXISYimoRTuWqz77WEAN3hwvCDUi/s3uooVqER8Pvw8=
X-Received: by 2002:ab0:1b6c:: with SMTP id n44-v6mr3157211uai.4.1530786354114;
 Thu, 05 Jul 2018 03:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180705094522.12138-1-boris.brezillon@bootlin.com>
In-Reply-To: <20180705094522.12138-1-boris.brezillon@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Jul 2018 12:25:42 +0200
Message-ID: <CAMuHMdU2pFmhWvR6ZvvjmL6FdTWKQysJ31SW-FEvcdbi5mQhGA@mail.gmail.com>
Subject: Re: [PATCH 00/27] mtd: rawnand: Improve compile-test coverage
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64682
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

Hi Boris,

On Thu, Jul 5, 2018 at 12:09 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> This is an attempt at adding "depends || COMPILE_TEST" to all NAND
> drivers that have no compile-time dependencies on arch
> features/headers.
>
> This will hopefully help us (NAND/MTD maintainers) in detecting build
> issues earlier. Unfortunately we still have a few drivers that can't
> easily be modified to be arch independent.
>
> I tried to put all patches that only touch the NAND subsystem first,
> so that they can be applied even if other patches are being discussed.
>
> Don't hesitate to point any missing dependencies when compiled with
> COMPILE_TEST. I didn't have any problem when compiling, but that might
> be because the dependencies were already selected.
>
> I have Question for Geert. I know you worked on HAS_DMA removal when
> combined with COMPILE_TEST, do you plan to do something similar with
> HAS_IOMEM?

No plans for that.

NO_IOMEM is Richard's itch, now s390 has gained PCI support.
NO_DMA matters for UML and Sun-3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
