Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 09:14:50 +0200 (CEST)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34116 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008613AbbGMHOsmEA0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 09:14:48 +0200
Received: by oiab3 with SMTP id b3so129619794oia.1
        for <linux-mips@linux-mips.org>; Mon, 13 Jul 2015 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3P7fOsl13nMBjqfNiiX3RuhvTgQbJu69vSXdLWBq1uU=;
        b=lSI9bswGDHxgGdWhjaekvO7I8M3JMPKRoppWW2XhPzveDbdxfD569vbMPEHw5zQ6ak
         qvXOsmLToHgTB09AH6BOqzKQn97AEPbXz8MDF3KzK/YG1W/uTNYERxFJ4GeUXZzCI+CZ
         z29oIXKHGSxX72GmU8yrGgkLGNVPOyhlsqhi7iWosNIJgX7qIkRTYO/9SabBx03PmtV5
         C/V0UjOYAOdAx5hvvxL31POE0S4JpfcUsREhKknWIn0oNzv8nvcw5zgKuXE7egrY7hrP
         tR3fuUNixPBr3oNMYqwU3hV6oCuUd7Y/LupdRszmnsF62VJwGsYT2xHEkdE2VzFE5TV7
         FHdw==
MIME-Version: 1.0
X-Received: by 10.182.196.72 with SMTP id ik8mr29035273obc.36.1436771682739;
 Mon, 13 Jul 2015 00:14:42 -0700 (PDT)
Received: by 10.60.168.5 with HTTP; Mon, 13 Jul 2015 00:14:42 -0700 (PDT)
In-Reply-To: <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
        <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date:   Mon, 13 Jul 2015 09:14:42 +0200
X-Google-Sender-Auth: 7R0N7i4z0f4c4ksmekqFkKUYq28
Message-ID: <CAMuHMdWW3uHLm=rwQ8cmhxGff8vwFDx7_-eSmiy3dndpDKk35Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] IRQ: Print "unexpected IRQ" messages consistently
 across architectures
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48216
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

On Mon, Jul 13, 2015 at 12:02 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Many architectures use a variant of "unexpected IRQ trap at vector %x" to
> log unexpected IRQs.  This is confusing because (a) it prints the Linux IRQ
> number, but "vector" more often refers to a CPU vector number, and (b) it
> prints the IRQ number in hex with no base indication, while Linux IRQ
> numbers are usually printed in decimal.
>
> Print the same text ("unexpected IRQ %d") across all architectures.
>
> No functional change other than the output text.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Thanks!

>  arch/m68k/include/asm/hardirq.h    |    2 +-

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

And it looks like m68k can switch to the asm-generic version afterwards...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
