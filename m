Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 17:05:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32744 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006513AbcADQFCK0q-V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 17:05:02 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BF15141F8E88;
        Mon,  4 Jan 2016 16:04:56 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 04 Jan 2016 16:04:56 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 04 Jan 2016 16:04:56 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id E54EEF98C4BA5;
        Mon,  4 Jan 2016 16:04:53 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 4 Jan 2016 16:04:56 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 4 Jan
 2016 16:04:55 +0000
Date:   Mon, 4 Jan 2016 16:04:55 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <virtualization@lists.linux-foundation.org>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>,
        <linux-ia64@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <x86@kernel.org>, <user-mode-linux-devel@lists.sourceforge.net>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-sh@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <xen-devel@lists.xenproject.org>, "Ingo Molnar" <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 20/32] metag: define __smp_xxx
Message-ID: <20160104160455.GE17861@jhogan-linux.le.imgtec.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
 <20160104134128.GZ6344@twins.programming.kicks-ass.net>
 <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
 <20160104153036.GG6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20160104153036.GG6344@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e68ca197
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50858
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

--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 04:30:36PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 04, 2016 at 03:25:58PM +0000, James Hogan wrote:
> > It is used along with the metag specific __global_lock1() (global
> > voluntary lock between hw threads) whenever a write is performed, and by
> > smp_mb/smp_rmb to try to catch other cases, but I've never been
> > confident this fixes every single corner case, since there could be
> > other places where multiple CPUs perform unsynchronised writes to the
> > same memory location, and expect cache not to become incoherent at that
> > location.
>=20
> Ah, yuck, I thought blackfin was the only one attempting !coherent SMP.
> And yes, this is bound to break in lots of places in subtle ways. We
> very much assume cache coherency for SMP in generic code.

Well, its usually completely coherent, its just a bit dodgy in a
particular hardware corner case, which was pretty hard to hit, even
without these workarounds.

>=20
> > It seemed to be sufficient to achieve stability however, and SMP on Meta
> > Linux never made it into a product anyway, since the other hw thread
> > tended to be used for RTOS stuff, so it didn't seem worth extending the
> > generic barrier API for it.
>=20
> *phew*, should we take it out then, just to be sure nobody accidentally
> tries to use it then?

SMP support on this SoC you mean? I doubt it'll be a problem tbh, and
it'd work fine in QEMU when emulating this SoC, so I'd prefer to keep it
in.

Cheers
James

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWipgnAAoJEGwLaZPeOHZ6H00QAJCE8+tFVrOY06765tPTdzed
wYC0LFfKDLv/TtsEAy4zBhWYEwJ0R1gQOTjCKsdaJMINDcpCy+1mWV4b1X1B+ptV
QD5oOYZy7Fln8VYYvzWp+2Tz/iAoBSnBV1S8rG9eIxwWmJ9NQmhRl7I+GaFO5kgS
+0p+z0sJ6Fvv8jmFdzGF4AIAgm4hFY2O2ojy2jtGArgkFmuSdrrrS2//Uls6z3ZC
thEMVwEapQUjh0JZXDxkImzKXDfMcDi7Sse8Pdz+hXn0Q8J1u2tlhNwL7mqlY5lz
JpV/L050BZ94Vpop0JXLmQRkqaO7dDgmi+zGXSvSqSUL7/qWHk3h6gE6tTShr4Qp
rccA+QoreW9oQmUaAERc/DlB7I8SFYZE08YTLLVh+6bqPPK2sZOSa1/XfRC3UC35
+/exm7MjSr4Emmfo9D5xxRAf4e+nYIuYjmf0rik9Hz5CUYqgbc6yoN570p0omqnL
7WaRZWn+KESjhPrBrEcEbHFqV3OYsRgCPcoiSL5MVXXE0PlRXQtkDG9ach9jmtyZ
gz103rjyp1FdqUVG3yYfmCsTNfWwiOJRX1IXLkuTJ0Spjmmk9KtFFO5sUxMV/2l6
aJ+ehCqr/o58IZf71tqQvLQPeJCvUZ6y8mqAjBAdx1b+FBxUlu2kZ+opl3tI96dK
DUA3rNDlPNmeqf8XVgY8
=bXcF
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
