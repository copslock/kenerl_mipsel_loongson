Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79844C5AC81
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FB020657
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfARTdn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:33:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33979 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbfARTdn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 18 Jan 2019 14:33:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so16558949qtp.1;
        Fri, 18 Jan 2019 11:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErLXt+4MLir6MBRid1biQgec4eSYhQQBJKNsrW9q3Fs=;
        b=Cu91HrP0wa9j0pLECqvB4NSoVGSq0QHevyvV5eLXyuuhdiAu8xRirAEalLNK8Z8ogG
         7aUezEAzQW0MVrjVyf2TTo1BRdmfTCqn25TS6cBMsNQ+DIcUTeXtMjIPjnhJWVuYJac+
         20fJzLRFfYwKsCfQT6ao+iGlR13swo/58+4kItawj8TZTRi5ruwGy1w3Mzqzzb2cuuZQ
         jn6W6xOvnz05RiZDq2HX+r5hnANmU5rtRKwvul22urcMgAgpt1nOR7KHGBp7P6xXakgG
         5v2NO9k0rYndwkK1/FX7WesxIGyRmDah5fiATnAyEOyg2MhSGPPcSN6V0LG89PgnD1UZ
         Y2Bw==
X-Gm-Message-State: AJcUukcFjgF/C4afyxXek/KQr8yhTINkAeOvoB4zHSvi3iT/f8nlBlE+
        jL50/VCgMI3nVCqBD0xaEQLuMa8p9apxN9rr6+Y=
X-Google-Smtp-Source: ALg8bN51ZSz8S/UEkmKkQ76yrnTrRmtVHEOrjwWqzHKH/uRWMtRP1y/XgFacGAOrjnX1tIv/Wxgb87NR61MktkAeKK4=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr16647911qvm.149.1547840021534;
 Fri, 18 Jan 2019 11:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
In-Reply-To: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jan 2019 20:33:25 +0100
Message-ID: <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
To:     Andy Lutomirski <luto@kernel.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > - Once we get to 512, we clash with the x32 numbers (unless
> >   we remove x32 support first), and probably have to skip
> >   a few more. I also considered using the 512..547 space
> >   for 32-bit-only calls (which never clash with x32), but
> >   that also seems to add a bit of complexity.
>
> I have a patch that I'll send soon to make x32 use its own table.  As
> far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> not special.  But let's please not reuse 512..547 for other purposes
> on x86 variants -- that way lies even more confusion, IMO.

Fair enough, the space for those numbers is cheap enough here.
I take it you mean we also should not reuse that number space if
we were to decide to remove x32 soon, but you are not worried
about clashing with arch/alpha when everything else uses consistent
numbers?

       Arnd
