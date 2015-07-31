Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 09:01:05 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:59633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010772AbbGaHBDcBGxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Jul 2015 09:01:03 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440D51402D2;
        Fri, 31 Jul 2015 17:01:01 +1000 (AEST)
Message-ID: <1438326061.29353.9.camel@ellerman.id.au>
Subject: Re: samples/kdbus/kdbus-workers.c and cross compiling MIPS
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Herrmann <dh.herrmann@gmail.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Herrmann <dh.herrmann@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Djalal Harouni <tixxdz@opendz.org>, linux-mips@linux-mips.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Date:   Fri, 31 Jul 2015 17:01:01 +1000
In-Reply-To: <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
References: <20150729161912.GF18685@windriver.com>
         <CANq1E4TgWK-8JkUtOYfTOL9Dx=jWeVpA-h881TXSA3BNjp+MPw@mail.gmail.com>
         <55BA2B91.5070107@windriver.com>
         <CANq1E4S7awCfPaNduoG8ENHmnGhR7-VT-9LvGwREZs-h8zNmzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Thu, 2015-07-30 at 16:23 +0200, David Herrmann wrote:
> Hi
> 
> On Thu, Jul 30, 2015 at 3:50 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > On 2015-07-29 12:31 PM, David Herrmann wrote:
> >> Hi
> >>
> >> On Wed, Jul 29, 2015 at 6:19 PM, Paul Gortmaker
> >> <paul.gortmaker@windriver.com> wrote:
> >>> Hi David,
> >>>
> >>> Does it make sense to build this sample when cross compiling?
> >>>
> >>> The reason I ask is that it has been breaking the linux-next build of
> >>> allmodconfig for a while now, with:
> >>>
> >>>   HOSTCC  samples/kdbus/kdbus-workers
> >>> samples/kdbus/kdbus-workers.c: In function ‘prime_new’:
> >>> samples/kdbus/kdbus-workers.c:934:18: error: ‘__NR_memfd_create’ undeclared (first use in this function)
> >>>   p->fd = syscall(__NR_memfd_create, "prime-area", MFD_CLOEXEC);
> >>>                   ^
> >>> samples/kdbus/kdbus-workers.c:934:18: note: each undeclared identifier is reported only once for each function it appears in
> >>> scripts/Makefile.host:91: recipe for target 'samples/kdbus/kdbus-workers' failed
> >>> make[2]: *** [samples/kdbus/kdbus-workers] Error 1
> >>
> >> mips does have this syscall, so I assume the problem is out-of-date
> >> kernel headers. You can fix this by running:
> >>
> >>     $ make headers_install
> >
> > No, let me try and clarify. Please note the emphasis on cross compiling
> > and automated build coverage, i.e. there is no place for manual steps.
> 
> User-space samples in ./samples/ are compiled with HOSTCC, which is
> the compiler for the _local_ machine. Regardless of cross-compiling
> the same local compiler is used. So I cannot understand why this is
> even remotely related to cross compiling. Please elaborate.
> Please note that this is HOSTCC running, so it does *NOT* require the
> toolchain for your cross-compiled architecture.

Right. Our cross toolchain wouldn't build it anyway, as it has no libc.

> Also, please tell me why your system has "linux/memfd.h" available,
> but __NR_memfd_create is undefined?

Because it's building with the HOSTCC (x86_64), against the MIPS kernel
headers. And the MIPS kernel headers are structured in such a way that on a
non-mips build they don't define the syscall numbers.

The reason we have the MIPS headers installed is because CONFIG_HEADERS_CHECK
is turned on (because allmodconfig).

So that just basically makes no sense to me.

It's obviously possible that some samples build with that configuration, but
building against another arch'es kernel headers just seems like it's asking for
trouble. Even if we can build the samples, they will never run correctly.

So I suggest we should just disable SAMPLES if we're cross compiling, full stop.

cheers
