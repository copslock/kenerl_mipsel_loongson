Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 11:41:56 +0100 (CET)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:42473 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990435AbdKQKluL4VAu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 11:41:50 +0100
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1eFe3z-0003YE-MN; Fri, 17 Nov 2017 11:39:59 +0100
Date:   Fri, 17 Nov 2017 11:40:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com,
        David Miller <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t
 conversion
In-Reply-To: <CAK8P3a10N42rBO8XBrZWYOCwVB8jayjgZu2oa8FSpHTzszQacQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711171138510.7700@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com> <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com> <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com> <alpine.DEB.2.20.1711160958430.2191@nanos>
 <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com> <alpine.DEB.2.20.1711170954000.1709@nanos> <CAK8P3a3fcVKTwoqN0CxYchzcFqUZPBeko=oYsA9eNxu4bQoYyw@mail.gmail.com> <alpine.DEB.2.20.1711171049180.1709@nanos>
 <CAK8P3a10N42rBO8XBrZWYOCwVB8jayjgZu2oa8FSpHTzszQacQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Fri, 17 Nov 2017, Arnd Bergmann wrote:
> On Fri, Nov 17, 2017 at 10:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 17 Nov 2017, Arnd Bergmann wrote:
> >> On Fri, Nov 17, 2017 at 9:58 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> No, syscall that existing 32-bit user space enters would be handled by
> >> compat_sys_nanosleep() on both 32-bit and 64-bit kernels at that
> >> point. The idea here is to make the code path more uniform between
> >> 32-bit and 64-bit kernels.
> >
> > So on a 32bit system compat_sys_nanosleep() would be the legacy
> > sys_nanosleep() with the existing syscall number, but you don't want to
> > introduce a new sys_nanosleep64() for 32bit. That makes a lot of sense.
> >
> > So back to your original question whether to use #if (MAGIC logic) or a
> > separate config symbol. Please use the latter, these magic logic constructs
> > are harder to read and prone to get wrong at some point. Having the
> > decision logic in one place is always the right thing to do.
> 
> How about this:
> 
> config LEGACY_TIME_SYSCALLS
>       def_bool 64BIT || !64BIT_TIME
>       help
>         This controls the compilation of the following system calls:
> time, stime,
>         gettimeofday, settimeofday, adjtimex, nanosleep, alarm, getitimer,
>         setitimer, select, utime, utimes, futimesat, and
> {old,new}{l,f,}stat{,64}.
>         These all pass 32-bit time_t arguments on 32-bit architectures and
>         are replaced by other interfaces (e.g. posix timers and clocks, statx).
>         C libraries implementing 64-bit time_t in 32-bit architectures have to
>         implement the handles by wrapping around the newer interfaces.

s/handles/handling/ ????

>         New architectures should not explicitly disable this.

New architectures should never enable this, right?

Thanks,

	tglx
