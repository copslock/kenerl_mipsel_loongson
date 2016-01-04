Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 16:26:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27800 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008336AbcADP0FOtNQV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 16:26:05 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B9B2441F8E88;
        Mon,  4 Jan 2016 15:25:59 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 04 Jan 2016 15:25:59 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 04 Jan 2016 15:25:59 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 020F3D9C55C26;
        Mon,  4 Jan 2016 15:25:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 4 Jan 2016 15:25:59 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 4 Jan
 2016 15:25:58 +0000
Date:   Mon, 4 Jan 2016 15:25:58 +0000
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
Message-ID: <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
 <20160104134128.GZ6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20160104134128.GZ6344@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e68ca197
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50856
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

--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Jan 04, 2016 at 02:41:28PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 31, 2015 at 09:08:22PM +0200, Michael S. Tsirkin wrote:
> > +#ifdef CONFIG_SMP
> > +#define fence() metag_fence()
> > +#else
> > +#define fence()		do { } while (0)
> >  #endif
>=20
> James, it strikes me as odd that fence() is a no-op instead of a
> barrier() for UP, can you verify/explain?

fence() is an unfortunate workaround for a specific issue on a certain
SoC, where writes from different hw threads get reordered outside of the
core, resulting in incoherency between RAM and cache. It has slightly
different semantics to the normal SMP barriers, since I was assured it
is required before a write rather than after it.

Here's the comment:

> This is needed before a write to shared memory in a critical section,
> to prevent external reordering of writes before the fence on other
> threads with writes after the fence on this thread (and to prevent the
> ensuing cache-memory incoherence). It is therefore ineffective if used
> after and on the same thread as a write.

It is used along with the metag specific __global_lock1() (global
voluntary lock between hw threads) whenever a write is performed, and by
smp_mb/smp_rmb to try to catch other cases, but I've never been
confident this fixes every single corner case, since there could be
other places where multiple CPUs perform unsynchronised writes to the
same memory location, and expect cache not to become incoherent at that
location.

It seemed to be sufficient to achieve stability however, and SMP on Meta
Linux never made it into a product anyway, since the other hw thread
tended to be used for RTOS stuff, so it didn't seem worth extending the
generic barrier API for it.

Cheers
James

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWio8GAAoJEGwLaZPeOHZ6kOoP+gOsyqboWQ/oGC0ratnoDEIb
8xoc8nrYKBUdTxDNOzrQq8QCFJh9Ny+0mi+wyagv652qsjpNwx+2zQXqrCjWyilJ
nT/AcO2SYPLA+jgjBAbFmf6gxnCH1e2kgjY5G+kP3NryiDAgty0QxQm6EXyhG4PC
R1GaURw7SmgfxsXp7PrtqMiXwJWQEmMjacD3iBVgmC+9IHNqtQDY+VXRZzirqs+B
kg7rzEFBqlZu2g0DVAVDT5PufMCTAet0kl2gTBA1xOO4L64ZO23UA0hozsef2jKk
jOJwgqGSjih8aMMLFF/OFWlnq7sbewh6W8BYDqetU1LxwB4lCb26grymp2NF3igS
FayGpj+0G1tPCTlLhjJ6B+LCvEVr3xtGXOprs3kXCOSogmAxG4dugi+NqLeYMY9t
e3zM9CT9vJgBo2VN1rZodUgrUJW/L/g9O5LdCjQfaa+jwESekXAYxz/GDXK7f7oP
50tUwaF4v0QMgbkd/9qAcAFeM2v1+UprgZ0YtS50oKkpGPk9qb6d/SUXc2ol2jJZ
OsBbptZATrfFNz3YU3IHs5kms7puRW9xyRV/U98x+ePJ2Ygd1L2X1uO692XMKc8w
T8cd/kO7fJO8GbQp5K4CGoLO9xN0kqjK9A2fUxx6y8WAEd3oFL7b9KFrQFDurF/W
7bYT38qvPdm2XTOsW1GB
=XuZ5
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
