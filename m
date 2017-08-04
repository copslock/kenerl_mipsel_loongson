Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 17:22:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8997 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995090AbdHDPWKyNKrX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 17:22:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EA05A74164939;
        Fri,  4 Aug 2017 16:22:00 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 4 Aug
 2017 16:22:04 +0100
Date:   Fri, 4 Aug 2017 16:22:04 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Dmitry V. Levin" <ldv@altlinux.org>, <linux-mips@linux-mips.org>,
        <linux-ia64@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <sparclinux@vger.kernel.org>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        linux-arch <linux-arch@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-am33-list@redhat.com>,
        <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-alpha@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] uapi: fix another asm/shmbuf.h userspace compilation
 error
Message-ID: <20170804152203.GA31455@jhogan-linux.le.imgtec.org>
References: <20170302004607.GE27132@altlinux.org>
 <CAK8P3a1=-Q=gVRyk+PwqxTeTPXa4yrmqWKG7SyZng2d7bcbG=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ofekNuVaYCKmvJ0U"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=-Q=gVRyk+PwqxTeTPXa4yrmqWKG7SyZng2d7bcbG=g@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--ofekNuVaYCKmvJ0U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 02:07:20PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 2, 2017 at 1:46 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> > Replace size_t with __kernel_size_t to fix asm/shmbuf.h userspace
> > compilation errors like this:
> >
> > /usr/include/asm-generic/shmbuf.h:28:2: error: unknown type name 'size_=
t'
> >   size_t   shm_segsz; /* size of segment (bytes) */
> >
> > x32 is the only architecture where sizeof(size_t) is less than
> > sizeof(__kernel_size_t), but as the kernel treats shm_segsz field as
> > __kernel_size_t anyway, UAPI should follow.  Thanks to little-endiannes
> > of x32 and 64-bit alignment of the field following shm_segsz, this
> > change doesn't break ABI, and the difference doesn't manifest itself
> > easily.
> >
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Out of interest, is there a plan for merging these patches from Dmitry?

Cheers
James

--ofekNuVaYCKmvJ0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlmEkRMACgkQbAtpk944
dnrAMg/+K3doXr6onSUJPfVtAuAORRxr6EypmBdFZs5/qV4cwNTkljJ0c/yGAKaM
fUM6pJ9n56h7YGG0/y2m+YCI56TPWyh8HnoKTNyhgDtg+Sn1e2Ub4dXyEjYdQhXN
TMTzPsP/COyFkrStEulbLuGoaU4t7UMFk5nU7FTQ1BpCeyuEO5opnUpA3JMZwehK
KK7orqZYUE+iZ8QfbEXiuHr68EsvpMeHj0z6WNkXD/8gRzSFTMqf5wHFpm3cNTJ7
3BRJx3LOkkE3amkPOm1kIOPWkMAEIFF11hRc79e4Wpkak6tnoCowkLvVNadB+UH2
bb5BTgwifuU83lrWsqC6gzs6e4PR0DEAgQofoLy5uGQjVgYqJ970Q8/Cl4xsfvcL
qVVFp8oGN5oZoXFiMWhYVQydG4m9TaruA2vOZK3F9fdrNBmd4t+fNxF+l3CTfa79
dAGLliqjUunWrW8WBrFmIySw9Sxl8DbJKyl0jxaJUbfGCnmsmkCZO4fP8h3BK37Y
mjMPsH3AjUnkBSLRBK+d261LMYCBgMY/SpUWwR7RqRbtxrqO7voVeNcyXQ1c4tVE
cYJhQpy57wjDKE0luxGSU0o1ATJst6xcL+URKTvRoxIWrkZXUBPnwfusoedLqTxd
f5AIFSEhwz7t8hBSEweo8qITuBmr86QmyKPwYN4R9xkonfb2Kis=
=9M2T
-----END PGP SIGNATURE-----

--ofekNuVaYCKmvJ0U--
