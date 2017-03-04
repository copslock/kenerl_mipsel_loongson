Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 02:23:37 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:35929
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993420AbdCDBX0ngs0W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 02:23:26 +0100
Received: by mail-qk0-x243.google.com with SMTP id n141so7661772qke.3
        for <linux-mips@linux-mips.org>; Fri, 03 Mar 2017 17:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=systemhalted.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WATg6wghVwQqK8lIVmzN45OxVBaaUPjfgpkkdfwxork=;
        b=Gm+dMj4ch8A5wx/SS2vA+iegMUCl4qN8LhDpuz2JF1eH6ZV0t3jdk27ZnTatilD645
         3V8ccBbjhAh7pjECzmoNlfkrzjIcl9UisOBEWXyuFAoK2fhsemEvAowxyRwjPBjBgslr
         ufuLEDqpXYnzmhpA4lQa99CvUkYKIdzeimYQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WATg6wghVwQqK8lIVmzN45OxVBaaUPjfgpkkdfwxork=;
        b=hIZRCJCMYbX9p/8hw9xUlvm9ZkHZWhG3xft6Tp0etEI3Qvw03F1pQ6a7wye3Gk4SNQ
         dAuI0CBAOHVrfLdYxSzn+FobsGJcZfFN4mjA7pUQlLPPyNjycXunPnJi1GiABZ177MJs
         /B0ohye/IlbCq921Q7Zu5ItZCfzkPOxCFB07yHT10qz59+PY35Gp3YD4+2zDe5jNIpKb
         ksCREcMS3A7YhhNXPDVOVgudmXtyXNUTl6TASYTGcQfXk7eXvL/rDGYbT7OC+BB+IgOI
         m/vTY1EsWCIuUMpdRsr1M8t/Ac1A9vW7UQnBIGP45t/lwaMu6WXmIjzJeTWYvz8puH23
         /ekw==
X-Gm-Message-State: AMke39l+yQyeAvvQRK7fYeA0MHVxnvSaLWZBEZjGdtImZ2azGc9AS6W9rFASJZH9kTDYUFR3Of6YH4k4QGn1sQ==
X-Received: by 10.237.36.116 with SMTP id s49mr5835114qtc.128.1488590600809;
 Fri, 03 Mar 2017 17:23:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.61.167 with HTTP; Fri, 3 Mar 2017 17:23:20 -0800 (PST)
X-Originating-IP: [184.145.137.27]
In-Reply-To: <20170302154845.GB3503@altlinux.org>
References: <20170226010156.GA28831@altlinux.org> <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
 <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com> <20170302154845.GB3503@altlinux.org>
From:   "Carlos O'Donell" <carlos@systemhalted.org>
Date:   Fri, 3 Mar 2017 20:23:20 -0500
Message-ID: <CAE2sS1i-xezJu2hHfzOxpCMZHc2J+dsturtqFPMRWHa6mm6ccQ@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix asm/signal.h userspace compilation errors
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
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
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <carlos@systemhalted.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlos@systemhalted.org
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

On Thu, Mar 2, 2017 at 10:48 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Thu, Mar 02, 2017 at 10:22:18AM -0500, Carlos O'Donell wrote:
>> On Wed, Mar 1, 2017 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> >> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
>> >> userspace compilation errors like this:
>> >>
>> >> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
>> >>   size_t ss_size;
>> >>
>> >> As no uapi header provides a definition of size_t, inclusion
>> >> of <stddef.h> seems to be the most conservative fix available.
> [...]
>> > I'm not sure if this is the best fix. We generally should not include one
>> > standard header from another standard header. Would it be possible
>> > to use __kernel_size_t instead of size_t?
>>
>> In glibc we handle this with special use of __need_size_t with GCC's
>> provided stddef.h.
>>
>> For example glibc's signal.h does this:
>>
>> # define __need_size_t
>> # include <stddef.h>
>
> Just to make it clear, do you suggest this approach for asm/signal.h as well?

The kernel is duplicating userspace headers in the UAPI implementation
and running into exactly the same problems we have already solved in
userspace. We currently have no better solution than the "__need_*"
interface for avoiding the duplication of the type definitions and the
problems that come with that.

I am taking this up with senior glibc developers on libc-alpha to see
if we have a better suggestion. If you give me 72 hours I'll either
have a better suggestion or the acknowledgement that my suggestion is
the best practical solution we have.

Note that in a GNU userspace stddef.h here comes from gcc, which
completes the implementation of the C development environment that
provides the types you need. The use of "__need_size_t" is a collusion
between the components of the implementation and use by the Linux
kernel would mean expecting something specific to a GNU
implementation.

I might suggest you use include/uapi/linux/libc-compat.h in an attempt
to abstract away the GNU-specific magic for getting just size_t from
stddef.h. That way you have documented the places that other runtime
authors need to fill out for things to work.

Cheers,
Carlos.
