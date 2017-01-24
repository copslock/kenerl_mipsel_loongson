Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 16:45:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46735 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993932AbdAXPpnG5nwR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2017 16:45:43 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1031F41F8DB3;
        Tue, 24 Jan 2017 16:48:38 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 24 Jan 2017 16:48:38 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 24 Jan 2017 16:48:38 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 808DC54EC5F40;
        Tue, 24 Jan 2017 15:45:33 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 24 Jan
 2017 15:45:37 +0000
Date:   Tue, 24 Jan 2017 15:45:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: gcc-6.3.x miscompiling code for IP27?
Message-ID: <20170124154536.GK29015@jhogan-linux.le.imgtec.org>
References: <ee417407-6877-f49c-5893-f3b3dbc2d103@gentoo.org>
 <44d9e9df-2d77-df23-266b-9cb90b0db4c9@gentoo.org>
 <1cbb8434-d7ef-36e2-1f3e-ccbb5c52ce85@gentoo.org>
 <62c49213-812b-a9c2-b1a6-797ecdfa2829@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Content-Disposition: inline
In-Reply-To: <62c49213-812b-a9c2-b1a6-797ecdfa2829@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56474
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

--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Mon, Jan 23, 2017 at 01:00:52PM -0500, Joshua Kinard wrote:
> On 01/22/2017 21:24, Joshua Kinard wrote:
> > On 01/22/2017 20:03, Joshua Kinard wrote:
> >> On 01/22/2017 18:28, Joshua Kinard wrote:
> >>> I think I've run into a really odd gcc-6.3.x miscompile bug here on I=
P27.
> >>> But I'm not sure.  I've reproduced the issue on 4.9.5, 4.8.17, and now
> >>> 4.7.10 (which I KNOW should boot).  If I recompile the same 4.7.10 ke=
rnel
> >>> with gcc-5.4.0, though, it boots as expected.  The fault appears to b=
e in
> >>> the assembly for _raw_spin_lock_irq.
>=20
> [snip]
>=20
> > I am not sure what to call this.  This is definitely not happening with=
 a
> > gcc-5.4.x-built kernel, so it's a code-generation issue of some kind:
>=20
> With some help from the gcc mailing list, the "sd" instructions emitted a=
t the
> beginning of every function is from the -fstack-check flag.  It enables
> stack-probing to ensure there is sufficient space on the stack, else it'll
> trigger a SEGV.  My guess is for IP27, at this early point in boot, the m=
emory
> system isn't up and running yet, due to IP27's somewhat-unique nature.  T=
hus,
> this stack-probe will fail and trigger the NULL deref in _raw_spin_lock_i=
rq().
>=20
> The workaround I am going to go with is to add -fno-stack-check to IP27's
> arch/mips/sgi-ip27/Platform file to disable stack-checking.  As far as I =
can
> tell, this solves the issue on IP27 by not emitted these instructions any=
more
> (verified w/ objdump).  Not sure where this flag is getting set from.  Co=
uld be
> set in my distro's toolchain somewhere.  But since at least IP30 is not
> affected, I am going to assume it's specific to IP27 for now.

Interesting. It definitely looks like an option we should not be using
in the kernel, regardless of platform, since kernel stacks are
relatively small, put in unmapped virtual memory and don't grow when
overflowed. At least until we get mapped stacks (which has its own set
of hurdles) its more likely to just corrupt other kernel memory and
cause seemingly random crashes like this one.

Cheers
James

>=20
> I'll send a patch in later this week...
>=20
> --=20
> Joshua Kinard
> Gentoo/MIPS
> kumba@gentoo.org
> 6144R/F5C6C943 2015-04-27
> 177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943
>=20
> "The past tempts us, the present confuses us, the future frightens us.  A=
nd our
> lives slip away, moment by moment, lost in that vast, terrible in-between=
=2E"
>=20
> --Emperor Turhan, Centauri Republic
>=20

--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYh3aYAAoJEGwLaZPeOHZ6j6EQAIg0LAEnmSa7Qgx6QrXZxrUa
xmLhD+p8IwlZuWp5l3+L181hjYYs2qZpTzi9ZZmo/iF3PyyTBEems9VORhE9WTXQ
tHORV4/z6E7SZo3+JOco4BGdfhJJejakeaTxa2BE68z8xIEu3XTTkeT3rKlwadSp
BzF0f/PUOJfAajR6pP5ZXdSitOxAc0CEpairYIMo6V8w2AxTxExaMee5wv1r0iTv
+p7XxGXKETmCI2/fpVnf6TxMJi3vEYqoMonJInRfx8qaru/6vZI71P7ngOoa7xdy
z0kFsm35cuZsWzAzuvw2uao1DiEdQwemyGt2YgAw77MtVpIWiVvAeSDYn6ZpjRlF
fEgFTvyLQDaU+OkmUEOY/F7VQ65brr65rI0t9cAod9tO/eRSfwQ4Zd01tLrA5IoI
zgEDyCO59yJhNzOJ9OSrBiPC56o1hxLwvR/86FvodsVmR4AGWpgmbxeTrw8Klny+
ijDgluA4OY7tWdwPA2++z9Zhox+l4nK0oZQgnUVimydOK0Cz06wT05Cyksw2ns5d
I/m6kbhW7y3GPBL38MG0yl5gcbolNvfPF1e1bcxaIvByp3pT5fSaKmCVGCoppkpP
WIWxjA78PQ1Wik9cTG1i6Brv//ob6K+N+zIe9RRRPbKKcbK8cBOaf0hiOtZY8fcA
kmvCmg9WnteTaC1RsS0P
=+jbK
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--
