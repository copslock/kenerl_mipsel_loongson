Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A4C1B0FD
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F299C2086D
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfARUof (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:44:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34307 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfARUof (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 18 Jan 2019 15:44:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so16787244qtp.1;
        Fri, 18 Jan 2019 12:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORQ5TPnixziDIHsuvdhJc04sEDyDC/r90DJmiSnzeTU=;
        b=mT5Fq8haOw39l3SAJ+CmF45vyC9jpJwSF4//CAyZ2N67+F2rfBYOlb1s6uICMn22Xa
         GDpkJaIvPEFvUYYgFDTYlTD9BWzSaSZk2Q67fjt4Chx1n4/cZvZfwfwrwKJ+sHE7q4u8
         1nxN+0/5k+au8ihqPtf+s7NS8eKz/08My0DL7Nv3Dek9ObBsdBNGE1LzoMtNoRCOpNpM
         dAlBCaWI4RwQx4NdTnZL+OnHel/RhYiwP/Xro7Je4MQCPa0Mg1inRcYaXwjsVfW8gd49
         +1WWujpsrJny6GPdicKQ5MFd6LVOm7oIOj4KUW/mJLC/xS2VCIlQwLLzpQuVZtNt30IZ
         b5zA==
X-Gm-Message-State: AJcUukfiNmnSf1eEa3alHL+65BvLTEoP3fU70HFcxW1m/yBS8T/ZItSI
        kAzp3K6dUfi38UOhezhIaY3gZ12GTBYfbw0U2Rw=
X-Google-Smtp-Source: ALg8bN4ggcJ9u9iUb42HjHwnUQYctSfqKH3E3MdNfQhsEyd2ovYbbCJ8aRRYCcgq2HtqlmRxO9eWK6dWZp4WMFrZjzM=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr17616058qvj.161.1547844273008;
 Fri, 18 Jan 2019 12:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com> <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
In-Reply-To: <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jan 2019 21:44:16 +0100
Message-ID: <CAK8P3a3bGF9iL6fZyyGS1p6vw56FHNMuosVBShX=MTptb6g4Hw@mail.gmail.com>
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

On Fri, Jan 18, 2019 at 8:53 PM Andy Lutomirski <luto@kernel.org> wrote:
> I think we have two issues if we reuse those numbers for new syscalls.
> First, I'd really like to see new syscalls be numbered consistently
> everywhere, or at least on all x86 variants, and we can't on x32
> because they mean something else.  Perhaps more importantly, due to
> what is arguably a rather severe bug, issuing a native x86_64 syscall
> (x32 bit clear) with nr in the range 512..547 does *not* return
> -ENOSYS on a kernel with x32 enabled.  Instead it does something that
> is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
> but old kernels will still exist, and this will break syscall probing.
>
> Can we perhaps just start the consistent numbers above 547 or maybe
> block out 512..547 in the new regime?

I'm definitely fine with not reusing them ever, and jumping from 511 to
548 when we get there on all architectures, if you think that helps.

While we could also jump to 548 *now*, I think that would be a
bit wasteful. Syscall numbers are fairly cheap, but not entirely
free, especially when you consider architectures like mips that
have an upper bound of 1000 syscalls before they have to get
inventive.

     Arnd
