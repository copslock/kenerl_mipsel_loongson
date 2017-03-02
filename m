Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 16:22:39 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:36135
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdCBPWbvBGVH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 16:22:31 +0100
Received: by mail-qk0-x241.google.com with SMTP id m67so2186824qkf.3
        for <linux-mips@linux-mips.org>; Thu, 02 Mar 2017 07:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=systemhalted.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=St39ZtXC5/gSSoYnYKjmCUDeytpC7lgfAzu8QnjPPYM=;
        b=W6P1nPLd7pNFJu3drM9W7o0Y6yv6k1vZpJNf4Uxlbuxb6JX28P/nkNSPwdTZh0XUX6
         yQBdj4UWa9t+RjLIsokz9V2a/lk3CXFUmAWxt6prU3mTSsf2EyGbXyZOXAXhCaqZQGnw
         QQ1wM2XBdfgxgrIilNqAN3xPk9wHAX0sRlz+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=St39ZtXC5/gSSoYnYKjmCUDeytpC7lgfAzu8QnjPPYM=;
        b=BVQ/QR+KfOrX0MPBbCDHvkVsmAYevK8jdtNrdnujEWXp7f2tN755DrOJR52kYZZDSw
         o0OO0wOUB9So3EKet0ALpAcfmBH/zHqDpFn1D4HQuIQrBnaQpFXfdAexpGoi1VwBToXc
         jCdV9p6yMFyS0lNpWusr6KsUAGb8KCmZwZvAmV74pnf6iXzYhUGuGHCHplKPSDqa23o+
         +K4ySGqUh7+mX6J7MdV5Wj3yBVd41ASI0FpsyZJlJiHxI1SO6NaoSNiRbCocazz43CCO
         389ozyFlyBd2gn6iwXb+bOKQvmrlkfsoGYBaXqzCyU1GGBZOsKq3YAK/l/0ftxXPIbP9
         WzBQ==
X-Gm-Message-State: AMke39lz6+K+UPbePvcFpl674LTxNXXw6pu9oGapzU5rQps/mzku4Ikou27DqyWJyVXjTU69cqdg2p2Z9L5QgA==
X-Received: by 10.55.104.138 with SMTP id d132mr17603761qkc.210.1488468139347;
 Thu, 02 Mar 2017 07:22:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.61.167 with HTTP; Thu, 2 Mar 2017 07:22:18 -0800 (PST)
X-Originating-IP: [65.93.71.239]
In-Reply-To: <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
References: <20170226010156.GA28831@altlinux.org> <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
From:   "Carlos O'Donell" <carlos@systemhalted.org>
Date:   Thu, 2 Mar 2017 10:22:18 -0500
Message-ID: <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix asm/signal.h userspace compilation errors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
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
X-archive-position: 57000
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

On Wed, Mar 1, 2017 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
>> userspace compilation errors like this:
>>
>> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
>>   size_t ss_size;
>>
>> As no uapi header provides a definition of size_t, inclusion
>> of <stddef.h> seems to be the most conservative fix available.
>>
>> On the kernel side size_t is typedef'ed to __kernel_size_t, so
>> an alternative fix would be to change the type of sigaltstack.ss_size
>> from size_t to __kernel_size_t for all architectures except those where
>> sizeof(size_t) < sizeof(__kernel_size_t), namely, x32 and mips n32.
>>
>> On x32 and mips n32, however, #include <stddef.h> seems to be the most
>> straightforward way to obtain the definition for sigaltstack.ss_size's
>> type.
>>
>> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>
> I'm not sure if this is the best fix. We generally should not include one
> standard header from another standard header. Would it be possible
> to use __kernel_size_t instead of size_t?

In glibc we handle this with special use of __need_size_t with GCC's
provided stddef.h.

For example glibc's signal.h does this:

# define __need_size_t
# include <stddef.h>

And...

/* Any one of these symbols __need_* means that GNU libc
   wants us just to define one data type.  So don't define
   the symbols that indicate this file's entire job has been done.  */
#if (!defined(__need_wchar_t) && !defined(__need_size_t)        \
     && !defined(__need_ptrdiff_t) && !defined(__need_NULL)     \
     && !defined(__need_wint_t))

The idea being that the type you want is really defined by stddef.h,
but you just one the one type.

Changing the fundamental type causes the issues you see in patch v2
where sizeof(size_t) < sizeof(__kernel_size_t).

It will only lead to problem substituting the wrong type.

Cheers,
Carlos.
