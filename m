Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Oct 2016 20:05:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15595 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992781AbcJLSFiNuTsS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Oct 2016 20:05:38 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id F22B041F8DF7;
        Wed, 12 Oct 2016 19:05:17 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 12 Oct 2016 19:05:17 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 12 Oct 2016 19:05:17 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 59FE6C211E58B;
        Wed, 12 Oct 2016 19:05:28 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 12 Oct 2016
 19:05:32 +0100
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 12 Oct
 2016 19:05:32 +0100
Date:   Wed, 12 Oct 2016 19:05:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Bhushan Attarde <bhushan.attarde@imgtec.com>,
        <gdb-patches@sourceware.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Andrew Bennett <Andrew.Bennett@imgtec.com>,
        Jaydeep Patil <Jaydeep.Patil@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
Message-ID: <20161012180531.GV19354@jhogan-linux.le.imgtec.org>
References: <1467038991-6600-1-git-send-email-bhushan.attarde@imgtec.com>
 <1467038991-6600-2-git-send-email-bhushan.attarde@imgtec.com>
 <alpine.DEB.2.00.1607221827040.4076@tp.orcam.me.uk>
 <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SZSwH5G1FJ2Fz+jP"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55399
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

--SZSwH5G1FJ2Fz+jP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2016 at 05:29:53PM +0100, Maciej W. Rozycki wrote:
> Hi James,
>=20
>  Thanks for your input!
>=20
>  Cc-ing linux-mips for the discussion about a ptrace(2) kernel API update=
;=20
> anyone interested in previous talk about this change please have a look=
=20
> at: <https://sourceware.org/ml/gdb-patches/2016-06/msg00441.html> and=20
> <https://sourceware.org/ml/gdb-patches/2016-10/msg00311.html> for the=20
> earlier messages.
>=20
> > >  Hmm, has Linux kernel support for CP0.Config5 accesses gone upstream=
=20
> > > already?  Can you give me an upstream commit ID and/or reference to t=
he=20
> > > discussion where it has been approved if so?
> >=20
> > I don't think it did go upstream yet.
>=20
>  Good!
>=20
> > >  More importantly, what do we need CP0.Config5 access for in the firs=
t=20
> > > place?  It looks to me like this bit is irrelevant to GDB as it does =
not=20
> > > affect the native (raw) register format.  So the only use would be to=
 let=20
> > > the user running a debugging session switch between the FRE and NFRE =
modes=20
> > > without the need to poke at CP1C.FRE or CP1C.NFRE registers with a CT=
C1=20
> > > instruction, which by itself makes sense to me, but needs a further=
=20
> > > consideration.
> >=20
> > It allows the FRE bit to be read (I seem to remember this was the only
> > bit actually exposed through ptrace by the patch).
>=20
>  Then I think it makes sense even more not to create this artificial API=
=20
> and use the CP1C.FRE/CP1C.NFRE registers instead which do correspond to=
=20
> what hardware presents to user software.

well, barely. Linux at least doesn't enable Config5.UFE or Config5.UFR,
since FP mode changes must be done for all threads in the process, so
userland can't actually directly access those FCRs either.

> Also with CP1C.UFR/CP1C.UNFR vs=20
> CP0.Status; while we want to retain the latter register in the view for=
=20
> historical reasons, it has always been read-only and I think it ought to=
=20
> remain such, with any writes to CP0.Status.FR executed via the former CP1=
C=20
> registers only.
>=20
> > FRE simply causes certain instructions (all single precision FP
> > arithmetic instructions and FP word loads/stores) to trap to the kernel
> > so that it can emulate a variation/subset of FR=3D0, so the debugger wo=
uld
> > use it to decide how to decode the single precision FP registers based
> > on the double precision FP registers (iirc).
>=20
>  I don't think there is any value in it for GDB, I think all 64-bit FP=20
> registers ought to remain being presented as doubles and pairs of singles=
=20
> regardless of the mode selected (and also possibly fixed-point longs and=
=20
> pairs of fixed-point words).  We don't know what's emulated and what's no=
t=20
> after all, and then the contents of FPRs are not interpreted by GDB itsel=
f=20
> anyhow except in user-supplied expressions or assignment requests, which=
=20
> for users' convenience I think should retain the maximum flexibility=20
> possible.

Well it technically depends on
test_tsk_thread_flag(target, TIF_HYBRID_FPREGS)

So it allows gdb to detect Linux's Hybrid FPU mode, and present the fp
regs (e.g. f0 or f1) more like below to the user depending on the fp
mode, which is surely much more intuitive from an assembly debugging
point of view.

Its also worth noting that "When software changes the value of this bit
[Status.FR], the contents of the floating-point registers are
UNPREDICTABLE". I.e. there is no architectural unifying register layout
between FR=3D0 / FR=3D1, only convention. Linux will I presume intentionally
save in old mode and restore in new mode on an fp mode change according
to its own convention (such that the valid mode changes don't clobber
register state).

(disclaimer: I haven't looked at this gdb patchset in detail as to
whether any of below has changed since I worked on it).

(1) Even singles and doubles always overlap one another, as do odd
singles and doubles when FR=3D1 (and FRE=3D0):
	/* (little endian) */
	union __gdb_builtin_mips_fp64 {
	  float  f32;
	  double f64;
	  int32  i32;
	  int64  i64;
	};

(2) Odd singles when FR=3D0 (there are no odd doubles):
	union __gdb_builtin_mips_fp32 {
	  float f32;
	  int32_t i32;
	};

(3) Odd singles and doubles when FR=3D1, FRE=3D1 don't overlap at all:
	struct __gdb_builtin_mips_fp96 {
		union {
			double f64;
			int64  i64;
		};
		union {
			float  f32;
			int32  i32;
		};
	};

i.e.

FR=3D0:
 (1) even
       double:	FEDCBA9876543210
       single:	        76543210
 (2) odd
       single:	FEDCBA98

FR=3D1, FRE=3D0:
 (1) even
       double:	FEDCBA9876543210
       single:	        76543210
 (1) odd
       double:	                0123456789ABCDEF
       single:	                        89ABCDEF

FR=3D1, FRE=3D1:
 (1) even
       double:	FEDCBA9876543210
       single:	        76543210   (Hybrid FPR emulation)
 (3) odd
       double:	                0123456789ABCDEF
       single:	FEDCBA98           (Hybrid FPR emulation)
)

Cheers
James

>=20
>  So as I say it looks to me like the only, though obviously valid and=20
> wholeheartedly supported, use for CP1C.FRE/CP1C.NFRE would be for user's=
=20
> control of the execution environment.
>=20
> > >  Additionally exposing CP0.Config5 may have security implications,=20
> > > especially as parts of the register have not been defined yet in the=
=20
> > > architectures and we'd have to force architecture maintainers somehow=
 to=20
> > > ask us every time they intend to add a bit to this register to check =
if=20
> > > this has security implications and has to be avoided and/or explicitl=
y=20
> > > handled in software.
> >=20
> > yes, as above it explicity only shows certain bits. I'm fine with the
> > api changing if necessary though since it isn't upstream.
>=20
>  It sounds like a plan to me then -- any further questions or comments=20
> about the kernel API part, anyone?
>=20
>   Maciej

--SZSwH5G1FJ2Fz+jP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX/ntrAAoJEGwLaZPeOHZ6dpwP+gIY1cCFaes7M/3vm6xTjaRR
eRTTCyZshXChr0+dhzmt9wzBxruZ2cQWOeXzoUPQo/m+IP4ZCcOdL9ViVTT8wIfB
0CUVLWCicyRd42NpqsEfziMYIGIcXuP1SLerqw6ZHuOB+lDThfmn3V07YkYUlxIq
Ars50FQnaWjC1K9oTHs0uHXnApEmcqMgrwZojw6GnF+MEtZckJ+QHKY7rbRczN8r
MuWEEQVVz+ocCBubPv+D5zBLH1U1UwKrH17j8A6xfQiDlDmm+xr9PnyioM+bl5hD
glihabZzMe040goaf+s1/eqKembQI8BoPhh+SWiG6M2zj4DQkO6SuO95E3HpeoRO
hWRq67AxyD3ip0V4j7/824NlEgsGK4H3i1H2tc9vkXhIqOlmEzi/V0sgWYRAkwmV
6/fEkeVGaNoaIrTG59TlLp5tft4AltVD6h1MzwUC38xshetd0dq8TJX1AK3gNTrU
BCt0qXBWoR6Y/GoPWy/JEppwTTjw5OoXvF4tgwXKQOn1x3E9mLBfYy29Mxyn3guU
0SRA9YORp9SCxyuwXe5ldzDPuRsecqfA6bcgaPacXyEO65uNX1NFACZpvrAp/6gx
HL4rkW5SUrk0vgus9tQK1u7rwQ27NhR18IYsq0IqCiL54yyFFOrVT7iB89yQsEw7
ayGFWxSTCTjuq95ed2Jo
=tUq0
-----END PGP SIGNATURE-----

--SZSwH5G1FJ2Fz+jP--
