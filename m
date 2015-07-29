Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2015 18:31:09 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:35719 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011693AbbG2QbHoSnGt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Jul 2015 18:31:07 +0200
Received: by lahh5 with SMTP id h5so9623814lah.2
        for <linux-mips@linux-mips.org>; Wed, 29 Jul 2015 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vSmWev2wVEbzpWNfxomRDK62az5OIUsAUzcCqGU9ygo=;
        b=U/qXjankVW4KPfAVFxEMDXhYB1QPVE9Ywtc/Jn+ctEsrp8GHSmR01PBRl5fWVVTvvr
         E9diumAwzQJhhtuBHPWO3OOtLrqYBjYfiFLE5VbEPAt8oH4uhF2nGuydcTrwikHHHG7q
         KbETxX9FPbgIVjwZfpmuxdpZecEws8p4WxyiNXZaweFxLdPdJEmq1juZkBHy6nXK7u/U
         hOLhzfSWPR6HMKFB3p+CEMaof3laQ4YTkyaXtqKbGCgMs+CJ76Qiq1HEPfyyI/KQLZSQ
         on98a/BEz5M6G+0K9F0nGza+Mj/e/UUP552YrVdwOPlnqmNxLmJADJFFuoCJvL7QJSxV
         fgoQ==
MIME-Version: 1.0
X-Received: by 10.152.18.162 with SMTP id x2mr39891487lad.73.1438187462422;
 Wed, 29 Jul 2015 09:31:02 -0700 (PDT)
Received: by 10.112.161.233 with HTTP; Wed, 29 Jul 2015 09:31:02 -0700 (PDT)
In-Reply-To: <20150729161912.GF18685@windriver.com>
References: <20150729161912.GF18685@windriver.com>
Date:   Wed, 29 Jul 2015 18:31:02 +0200
Message-ID: <CANq1E4TgWK-8JkUtOYfTOL9Dx=jWeVpA-h881TXSA3BNjp+MPw@mail.gmail.com>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
From:   David Herrmann <dh.herrmann@gmail.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     David Herrmann <dh.herrmann@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Djalal Harouni <tixxdz@opendz.org>, linux-mips@linux-mips.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <dh.herrmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dh.herrmann@gmail.com
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

Hi

On Wed, Jul 29, 2015 at 6:19 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Hi David,
>
> Does it make sense to build this sample when cross compiling?
>
> The reason I ask is that it has been breaking the linux-next build of
> allmodconfig for a while now, with:
>
>   HOSTCC  samples/kdbus/kdbus-workers
> samples/kdbus/kdbus-workers.c: In function ‘prime_new’:
> samples/kdbus/kdbus-workers.c:934:18: error: ‘__NR_memfd_create’ undeclared (first use in this function)
>   p->fd = syscall(__NR_memfd_create, "prime-area", MFD_CLOEXEC);
>                   ^
> samples/kdbus/kdbus-workers.c:934:18: note: each undeclared identifier is reported only once for each function it appears in
> scripts/Makefile.host:91: recipe for target 'samples/kdbus/kdbus-workers' failed
> make[2]: *** [samples/kdbus/kdbus-workers] Error 1

mips does have this syscall, so I assume the problem is out-of-date
kernel headers. You can fix this by running:

    $ make headers_install

This will put the sanitized headers in your local kernel tree
"./usr/". This is preferred over "/usr" as include path for the kernel
examples, hence, everything should work fine then.

The kernel samples/ directory is explicitly used for example programs
for the kernel. Hence, I think it is quite fine to use new kernel
features. Same applies to the selftests.

I'd be fine making kdbus-workers a no-op program if __NR_memfd_create
is not defined. But I'm not really sure that fixes real problems. I
mean, new samples and selftests will be added by other subsystems and
those might as well require new kernel headers.

Thanks
David
