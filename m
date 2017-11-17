Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 09:59:33 +0100 (CET)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:42042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990435AbdKQI70qoAbH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 09:59:26 +0100
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1eFcSv-0002Af-Dz; Fri, 17 Nov 2017 09:57:37 +0100
Date:   Fri, 17 Nov 2017 09:58:26 +0100 (CET)
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
In-Reply-To: <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711170954000.1709@nanos>
References: <20171110224259.15930-1-deepa.kernel@gmail.com> <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com> <CABeXuvpy1jbqjeUFHHX-MrJXQLA2QNYbAa6OX7qOpPp4q-mQYQ@mail.gmail.com> <alpine.DEB.2.20.1711160958430.2191@nanos>
 <CAK8P3a0wxs59T1zW4ahbJXeW6QjStm0mbCFoL_RQexAa6dzh_w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60988
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
> On Thu, Nov 16, 2017 at 10:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 15 Nov 2017, Deepa Dinamani wrote:
> >> Would this work for everyone?
> >
> > Having extra config switches which are selectable by architectures and
> > removed when everything is converted is definitely the right way to go.
> >
> > That allows you to gradually convert stuff w/o inflicting wreckage all over
> > the place.
> 
> The CONFIG_64BIT_TIME would do that nicely for the new stuff like
> the conditional definition of __kernel_timespec, this one would get
> removed after we convert all architectures.
> 
> A second issue is how to control the compilation of the compat syscalls.
> CONFIG_COMPAT_32BIT_TIME handles that and could be defined
> in Kconfig as 'def_bool (!64BIT && CONFIG_64BIT_TIME) || COMPAT',
> this is then just a more readable way of expressing exactly when the
> functions should be built.
> 
> For completeness, there may be a third category, depending on how
> we handle things like sys_nanosleep(): Here, we want the native
> sys_nanosleep on 64-bit architectures, and compat_sys_nanosleep()
> to handle the 32-bit time_t variant on both 32-bit and 64-bit targets,
> but our plan is to not have a native 32-bit sys_nanosleep on 32-bit
> architectures any more, as new glibc should call clock_nanosleep()
> with a new syscall number instead. Should we then enclose

Isn't that going to break existing userspace?

Thanks

	tglx
