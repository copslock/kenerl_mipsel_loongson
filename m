Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 16:48:58 +0100 (CET)
Received: from vmicros1.altlinux.org ([194.107.17.57]:47798 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdCBPsv7VKne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 16:48:51 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A6B1F72D9B5;
        Thu,  2 Mar 2017 18:48:45 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 972817CCB42; Thu,  2 Mar 2017 18:48:45 +0300 (MSK)
Date:   Thu, 2 Mar 2017 18:48:45 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Carlos O'Donell <carlos@systemhalted.org>
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
Subject: Re: [PATCH] uapi: fix asm/signal.h userspace compilation errors
Message-ID: <20170302154845.GB3503@altlinux.org>
References: <20170226010156.GA28831@altlinux.org> <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com> <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=x-unknown;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com>
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldv@altlinux.org
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


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 10:22:18AM -0500, Carlos O'Donell wrote:
> On Wed, Mar 1, 2017 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wro=
te:
> >> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
> >> userspace compilation errors like this:
> >>
> >> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
> >>   size_t ss_size;
> >>
> >> As no uapi header provides a definition of size_t, inclusion
> >> of <stddef.h> seems to be the most conservative fix available.
[...]
> > I'm not sure if this is the best fix. We generally should not include o=
ne
> > standard header from another standard header. Would it be possible
> > to use __kernel_size_t instead of size_t?
>=20
> In glibc we handle this with special use of __need_size_t with GCC's
> provided stddef.h.
>=20
> For example glibc's signal.h does this:
>=20
> # define __need_size_t
> # include <stddef.h>

Just to make it clear, do you suggest this approach for asm/signal.h as wel=
l?

[...]
> Changing the fundamental type causes the issues you see in patch v2
> where sizeof(size_t) < sizeof(__kernel_size_t).
>=20
> It will only lead to problem substituting the wrong type.

I don't see any appetite for creating more ABIs like x32 with
sizeof(size_t) < sizeof(__kernel_size_t), so v2 approach
is not going to be any different from v1 in maintenance.


--=20
ldv

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYuD7dAAoJEAVFT+BVnCUIun8QAIu2KR6DO6sDdAmLkPIEycqY
ZpD4t47B0iHa7P8alfr3RIhu36O4Py9o/VByWQTxs/BTGOcUnQWczMjQr7shKtHW
47qjSZTv23e17hae1Z6WOuFPn3uFU4EBun66kkuUqdZ4sFx40x/ODjXohG6GUxxd
clVZ694NPDFWCU00LZlowh+JIkoxeL0PpdiLkCJzFC/i0/CuKXU5pmWH+5z5/UlL
tNusg5EVA6bPi+toK/IWe/s/dUMIat1GLdqh9Qx0D5BfvNHHE9fK4DlcnEorISZt
fUs4TokqUP84mhzsoNQPVVdCyFeQiusc4YYNMO8T52G4ghgFJoJ627uA69pRdEzN
FVetUUPwFIZ/Z2NU8rfjJLXr0oWhelm+UnGITslKHFEr9lXnvEbE2odfExZo+O18
XFIvc+g3hZ9s5DOU8Oe37TgpiDlaUbBVFtj0CuHWVNJsx9iDzZS5n8NKEABjaaej
npWjXcOYAW4mMpQCOb3pMmij0ALU0Pd4iKU3a9utISonwPzoyAhTZcEud7EOCK+h
JrFlLSBp3pRX5gno+6sb0BkhgyXTpdqcmuqmLH4kYp2PesfJs54hzNK/WMXGNT4i
waAbG6eD4BKNBX1d3VjfmfoKUnr1MxGu3Z/kHRabE11pRTuTug7Vv8cvk6Mr6EuJ
oqIAlHG3dRVMHy3ZauCa
=5bs6
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
