Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 06:18:33 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33711 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992058AbcGYES0qAUME (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 06:18:26 +0200
Received: by mail-oi0-f67.google.com with SMTP id l9so15627431oih.0;
        Sun, 24 Jul 2016 21:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dczwZbrf2jshmJiuH9K32QWSOHoOLVMefgvZ8W9Hquo=;
        b=qS+rwXfRNqTve+MfUbJjH8XsYaKbBSWIAvUMkZvAsh0wOcMdYzjglb7y48SSgLmJKi
         xRP84Xr8sEp6x/TmDkCswobbLerSF4Ux2kmzxjrkWMHIA+3/MX0VOk4RSulSTyecLlnN
         p1l4ks40uYwzkoAVsv8G2Mab1tUc8eNOwFRv1qjjEJncGDaY0O+47AX9sc3gmut0SaS7
         MQHrC3ZeGVUU2DYNDPnItS1dJxU4wKp8AvlQkVhtIsJ7lHCWciFj3kXNusL9GxhGalOR
         jv9pscTVYtvGHZyV8dw0OdlkcMXiycMu4GXed0UdZC9w8eBYUdLpgBihRnvhYanpp+DC
         dAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dczwZbrf2jshmJiuH9K32QWSOHoOLVMefgvZ8W9Hquo=;
        b=i3Z+2b9s1KcLd8jV7UlEWsOrGsQDf+cO2eM8UVXBPd2qPOhnmZvl8G3zRVj+9ph7YZ
         W0tLM31wE0WyDw5sq3rBdx8/G+/y9Fwj5lF1kmDUfUJJLY1jieH7rr2NPjtT4vV0pEiO
         y5oLw/vRvdxaNAqXgJuMkdHnvdvb9vu3wdoXxTPdddtDQOq8veeOmhxHn3LF2B6tb1+8
         I589Ijuopq8P5QQeYsgfotK0hDcZW2GktLL5LhCFCREc8sSUjqRtMH6rU0jeGvA6+OuL
         ccVTszPql7OMdWSb9EFgBktbSU46aMEAKBf+/twsFyAqmxzMWuvoe6C8wRZ9MAhIyM8V
         Oj1w==
X-Gm-Message-State: AEkooutlzSxq7bYxZnkrNYNL3QKhZJar6IzBtUBqYfnyK68C+ShPB0Dx8FwN6td1PACqSMmOh/rXDLTpTAuKdg==
X-Received: by 10.202.86.15 with SMTP id k15mr7267612oib.178.1469420300354;
 Sun, 24 Jul 2016 21:18:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.204.35 with HTTP; Sun, 24 Jul 2016 21:18:19 -0700 (PDT)
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Jul 2016 21:18:19 -0700
X-Google-Sender-Auth: t7YqHOiU7yfO1fe6tNwpibm4QBg
Message-ID: <CA+55aFyDw_jK609LcjpWvVMTzCWuH6nLUXiZDeYC2tpSaZqhXA@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] split exception table content out of module.h
 into extable.h
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, linux-alpha@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Sun, Jul 24, 2016 at 8:42 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> While doing an audit looking for unnecessary instances of module.h
> inclusion across arch/x86/ I found a significant number of includes
> of module.h were for things like search_exception_table and friends.
>
> For historical reasons (i.e. pre-git) the exception table stuff was
> buried in the middle of the module.h file.  So we have core kernel
> files that are completely non-modular (both arch specific and arch
> independent) that are just including module.h for this.
>
> The converse is also true, in that conventional drivers, be they for
> filesystems or actual hardware peripherals or similar, do not
> normally care about the exception tables.
>
> Here we fork the exception table content [...]

This looks to be the right thing to do as far as I can tell. I'm not
sure how big of a problem the extable stuff is (we definitely have
much bigger unnecessary include files that cause a lot more problems),
but it seems like a reasonable cleanup.

              Linus
