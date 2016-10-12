Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 00:26:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21420 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992663AbcJLW01GypbJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 00:26:27 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7980141F8DF7;
        Wed, 12 Oct 2016 23:26:06 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 12 Oct 2016 23:26:06 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 12 Oct 2016 23:26:06 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 96B3B616EDE9F;
        Wed, 12 Oct 2016 23:26:16 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 12 Oct 2016
 23:26:21 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 12 Oct
 2016 23:26:20 +0100
Date:   Wed, 12 Oct 2016 23:26:20 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Bhushan Attarde <bhushan.attarde@imgtec.com>,
        <gdb-patches@sourceware.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Andrew Bennett <Andrew.Bennett@imgtec.com>,
        Jaydeep Patil <Jaydeep.Patil@imgtec.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
Message-ID: <20161012222620.GW19354@jhogan-linux.le.imgtec.org>
References: <1467038991-6600-1-git-send-email-bhushan.attarde@imgtec.com>
 <1467038991-6600-2-git-send-email-bhushan.attarde@imgtec.com>
 <alpine.DEB.2.00.1607221827040.4076@tp.orcam.me.uk>
 <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk>
 <20161012180531.GV19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610122217350.31859@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2Klb18PAKd8hQ5U"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1610122217350.31859@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55401
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

--j2Klb18PAKd8hQ5U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2016 at 11:04:18PM +0100, Maciej W. Rozycki wrote:
> On Wed, 12 Oct 2016, James Hogan wrote:
>=20
> > >  Then I think it makes sense even more not to create this artificial =
API=20
> > > and use the CP1C.FRE/CP1C.NFRE registers instead which do correspond =
to=20
> > > what hardware presents to user software.
> >=20
> > well, barely. Linux at least doesn't enable Config5.UFE or Config5.UFR,
> > since FP mode changes must be done for all threads in the process, so
> > userland can't actually directly access those FCRs either.
>=20
>  Hmm, I didn't know that -- what was the reason for this design decision?=
 =20
> Offhand the limitation does not appear necessary to me, each thread has=
=20
> its own distinct register set, so it does not appear to me that its mode=
=20
> of operation has to be the same across them all.  The current setting=20
> would still of course be inherited from the parent by any new threads=20
> created with clone(2).

Paul Burton & Matt Fortune know the details and can correct me if I'm
wrong, but I believe the idea is that the mode change will usually be
initiated by the dynamic loader in repsonse to loading a new shared
library with a more specific FPU ABI (but must of course be compatible
with the current mode). As such you must be careful that all threads in
the process change mode so that they can immediately start using the new
dynamically loaded code using the more specific ABI.

https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking#10=
=2E5.2._Setting_the_FPU_mode

> > (disclaimer: I haven't looked at this gdb patchset in detail as to
> > whether any of below has changed since I worked on it).
> >=20
> > (1) Even singles and doubles always overlap one another, as do odd
> > singles and doubles when FR=3D1 (and FRE=3D0):
> > 	/* (little endian) */
> > 	union __gdb_builtin_mips_fp64 {
> > 	  float  f32;
> > 	  double f64;
> > 	  int32  i32;
> > 	  int64  i64;
> > 	};
> >=20
> > (2) Odd singles when FR=3D0 (there are no odd doubles):
> > 	union __gdb_builtin_mips_fp32 {
> > 	  float f32;
> > 	  int32_t i32;
> > 	};
> >=20
> > (3) Odd singles and doubles when FR=3D1, FRE=3D1 don't overlap at all:
> > 	struct __gdb_builtin_mips_fp96 {
> > 		union {
> > 			double f64;
> > 			int64  i64;
> > 		};
> > 		union {
> > 			float  f32;
> > 			int32  i32;
> > 		};
> > 	};
> >=20
> > i.e.
> >=20
> > FR=3D0:
> >  (1) even
> >        double:	FEDCBA9876543210
> >        single:	        76543210
> >  (2) odd
> >        single:	FEDCBA98
> >=20
> > FR=3D1, FRE=3D0:
> >  (1) even
> >        double:	FEDCBA9876543210
> >        single:	        76543210
> >  (1) odd
> >        double:	                0123456789ABCDEF
> >        single:	                        89ABCDEF
> >=20
> > FR=3D1, FRE=3D1:
> >  (1) even
> >        double:	FEDCBA9876543210
> >        single:	        76543210   (Hybrid FPR emulation)
> >  (3) odd
> >        double:	                0123456789ABCDEF
> >        single:	FEDCBA98           (Hybrid FPR emulation)
> > )
>=20
>  I haven't got to this part so far and either way will have to think abou=
t=20
> it yet.  For one as I noted we do want to present vector (paired-single)=
=20
> data with FR=3D1, FRE=3D0 in addition to what you quoted above.

Right, I hadn't looked into that.

> This was all=20
> implemented in an old MIPS UK patch originally written by Nigel Stephens=
=20
> and included with SDE, which I've never got to upstreaming; have you by=
=20
> any chance based your work on that?

No.

>  As to FR=3D1, FRE=3D1 your quoted representation of singles is a softwar=
e=20
> convention only, so I'm not sure offhand how we might represent it in GDB=
=20
> to keep it reasonable; the 96-bit cooked FP register structure does not=
=20
> appeal to me at all TBH, but maybe it's the best we can do after all.

Me neither, but it at least seems to look reasonable from an assembly
debugging point of view. It took some effort to bend GDB to my will to
be honest, especially around mode changes and the remote protocol (since
the remote could change from FR=3D0 (32-bit FP registers) to FR=3D1 (64-bit
FP registers even on 32-bit) at almost any time, but I'm really no gdb
expert.

Cheers
James

--j2Klb18PAKd8hQ5U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX/riMAAoJEGwLaZPeOHZ6WE0QAID0XoVuYf7Eo4FYa3+T1x30
I+UiaVjWlUWuos2HNakExhXpz8W5boQtseYAZ9EEsON2h8FVrqLMN2oyBIeSjyuf
zgfJSjb62mXizJJK1AFAUMGH92iND6XrFWi1OsQxyU194ix5vvC9g7aOhZ4ybzpX
KgsBDxwpoxWvI4mRcong2RUGPgSDj9Zovs948si498LqIQKCAy6oHR6ROUN4jE1t
wTZTdKrsWG44s0YgS5+74vLexh9+rqmYLjX+E6LzW+ewAfPfsOk99YPzqUehH+hS
O/Fz2IhG7vgsMKJAZA2WPD8CJolC/Q+/KS85aaBOA+mrPRuolLdprSrJqgDQxXfE
wEH+zs/6awQ/xpnzeriP+VzTvNA1kUzrkBzhvlbCMOOZWjkRO4hcTXebsTcgEcgC
teu2RO+GeV4oDv74s1WmKDSq1kb7HMxmA+u9fmwYHrwUz2gPWRSvVWofSm31T3JA
h386b2mss/QsffYgOj7c9xMPzJoZyN/0FaD9Dq45ZfufUn1yDDheRfQGCZMozk0I
HGIfPMniTasEfeLRklxJ98Ne4ksMZ1my/Rl3sUDNUX6DwoJNZ/JFBES2tfVYmnOT
rEf28jwul30QAnEWNV6eYfNNwHauE1gEEk7ZqZj5oNWrH9fnjxNtcqKOrg40Gofc
oy+ZB/B6Z3YB5A0Vs8iT
=+Arx
-----END PGP SIGNATURE-----

--j2Klb18PAKd8hQ5U--
