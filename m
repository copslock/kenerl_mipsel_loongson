Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 17:21:05 +0100 (CET)
Received: from mail-ot0-x241.google.com ([IPv6:2607:f8b0:4003:c0f::241]:35159
        "EHLO mail-ot0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbdCAQU5ULhuz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2017 17:20:57 +0100
Received: by mail-ot0-x241.google.com with SMTP id a12so2588471ota.2;
        Wed, 01 Mar 2017 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=J/sszfdzPEcWuilL0+phRX3xYbZMLodKzJ48kUz3dvY=;
        b=n5rrMZWzvnqUflt1XRJz8juFk6sea5pr5ZWi+JhrqtnZCsgEOtbBZceaOyB8XmB+6x
         H8IxuIUqpjc1nrj1wg6Syh/RTlaFIzT5gWxVNAuzviqvZyeoT/S/xTwBnLUai4hp+vr1
         O2kK+DPP65i5YnEsxFKuPcZvj3J9pSRKOBI16J83+qn1zFvh0yuZd/vCgkAbno46TaZl
         xp78VvcnZiAGRHyZmsZJgSvsT380lQTgjqwkm+vZS5RQycCfdGH/BEZ4i+NRP1qRqFC5
         CF4nB4gjJcF3coF4Mm71vO3IzBdCWXfKFLjGxV/JtneuzknZ4xOKm1bZvDjzYw9oN0Yo
         qMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=J/sszfdzPEcWuilL0+phRX3xYbZMLodKzJ48kUz3dvY=;
        b=NsIYyPLNma0KrKs/ft6J4uYPLUe/mPQXEWr9GbDFaQpZmpVp9BJ3m9+9ss+1q+HkQn
         XROVdVaHILCVHp2ncZR/f6WZXuR7MB15NnVrsZtw8bKpwJJtVCF2Q4rT+hXKcIV9L/H1
         jcPlyNMDNvlH9skTqdGPE0PJhpyImdGuwq35Q2n/shZvW6dwwfiyCLIRLSHXpe1aYMh1
         b9sgtZZlH4A3fxqLKmfqCfCR81dtKeeQDAejMC1MGzyFvd0MiNFxHJ0274WwgdPkmx8n
         3uXKyd8fIAMiT+iEqh93+cmiw9GdnTVPxyL6pqm5Z9+hnRSqM4ntp2Sqr8MyPLuG3/BM
         k5Kg==
X-Gm-Message-State: AMke39nUTNBTj/INi3+avaTmroKYvopkyq95UKh1M00zkms2+8Oybmlk8Yg8SmXAKq4QHBtwHEv8S25zKCtQyQ==
X-Received: by 10.157.37.203 with SMTP id q69mr4457164ota.255.1488385251414;
 Wed, 01 Mar 2017 08:20:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Wed, 1 Mar 2017 08:20:50 -0800 (PST)
In-Reply-To: <20170226010156.GA28831@altlinux.org>
References: <20170226010156.GA28831@altlinux.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Mar 2017 17:20:50 +0100
X-Google-Sender-Auth: mQhZmx3s1HeDQmSgqeZm6KoZNKU
Message-ID: <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix asm/signal.h userspace compilation errors
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
> userspace compilation errors like this:
>
> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
>   size_t ss_size;
>
> As no uapi header provides a definition of size_t, inclusion
> of <stddef.h> seems to be the most conservative fix available.
>
> On the kernel side size_t is typedef'ed to __kernel_size_t, so
> an alternative fix would be to change the type of sigaltstack.ss_size
> from size_t to __kernel_size_t for all architectures except those where
> sizeof(size_t) < sizeof(__kernel_size_t), namely, x32 and mips n32.
>
> On x32 and mips n32, however, #include <stddef.h> seems to be the most
> straightforward way to obtain the definition for sigaltstack.ss_size's
> type.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

I'm not sure if this is the best fix. We generally should not include one
standard header from another standard header. Would it be possible
to use __kernel_size_t instead of size_t?

     Arnd
