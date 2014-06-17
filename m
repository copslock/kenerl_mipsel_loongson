Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jun 2014 13:43:16 +0200 (CEST)
Received: from [217.156.156.69] ([217.156.156.69]:65142 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6855025AbaFSLnNkzSxM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jun 2014 13:43:13 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 24A1D41F8E54;
        Tue, 17 Jun 2014 17:25:16 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 17 Jun 2014 17:25:16 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 17 Jun 2014 17:25:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8EBD816D7C415;
        Tue, 17 Jun 2014 17:25:09 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 17 Jun 2014 17:25:12 +0100
Received: from localhost (192.168.159.86) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 17 Jun
 2014 17:25:10 +0100
Date:   Tue, 17 Jun 2014 17:25:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Joseph S. Myers" <joseph@codesourcery.com>
CC:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>
Subject: Re: MIPS MSA sigcontext changes in 3.15
Message-ID: <20140617162509.GB7020@pburton-laptop.home>
References: <Pine.LNX.4.64.1406171447030.23412@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1406171539240.23412@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1406171539240.23412@digraph.polyomino.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.86]
X-ESG-ENCRYPT-TAG: f2c42831
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 03:44:36PM +0000, Joseph S. Myers wrote:
> On Tue, 17 Jun 2014, Joseph S. Myers wrote:
>=20
> > signal mask at a particular offset in the ucontext.  As far as I can se=
e,=20
> > extending sigcontext requires a new sigaction flag that could be used t=
o=20
> > opt in, for a particular signal handler, to receiving the new-layout=20
> > ucontext (so new symbol versions of sigaction in glibc could then pass=
=20
> > that flag to the kernel, but existing binaries would continue to get=20
> > old-layout ucontext from the kernel), or else putting the new data at t=
he=20
>=20
> And a new flag would itself be problematic - signal handlers would need=
=20
> wrapping with userspace code to convert structure layout when new-version=
=20
> sigaction is used on an older kernel.  That suggests putting the new data=
=20
> at the end of ucontext is to be preferred (but in any case it would be=20
> best to revert the incompatible changes until something compatible with=
=20
> existing userspace can be produced).
>=20
> --=20
> Joseph S. Myers
> joseph@codesourcery.com
>=20

True. Oops. I hadn't realised this...

I wonder if the sensible thing is to switch to sigcontext merely
containing a pointer to another struct holding FP state, much like x86.
Only in response to a flag as you describe of course. That way the
kernel could avoid the games it currently plays with splitting the
vector registers into 64b pieces, and it would probably be more open
to wider vector registers if they appear in the future.

Anyway, I agree with reverting the sigcontext change (eec43a224cf1
"MIPS: Save/restore MSA context around signals") in the meantime.

Given:

 - This issue.

 - A couple of other MSA fixes I have pending cleanup.

 - The fact that the only CPU the kernel supports which has MSA is the
   P5600, and since that is 32b it can't actually make use of MSA
   without the experimental CONFIG_MIPS_O32_FP64_SUPPORT option. Thus
   MSA isn't actually being used yet beyond a few small groups who
   accepted that big shouty experimental warning.

=2E..I wonder if it makes sense to disable MSA support by default for the
moment also.

Thanks,
    Paul

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJToGvlAAoJENzvn0paErs5osAQAIA00p/HcRCU4jMtBi0YH4he
lUjUPwXU1dNas4AJOaiQBs/IW42byyvTNoRQ1XQXhZdbcpoVtCjdW2nSCL3ZL93d
4m8f8VXVpQXEM2RpjWW+Y4ecCNSBqCNiBWw8+0jmOsxO/LOjdGZFucbNqReGn6lK
2qNErsz0YgoupZ2MGW8+K+a7GG3IStc56/jeLM0fsvn2pSb0jAvgLIjsxRnl2Ou8
4z/WPqxm67w0cUuCr0WBfPosH6+nZKpwO0t1Y49AbrG2Y/dPyHyKUkdAUdtTSryV
giaahS//GWWj2bG+v4hmNvD08CfgGMb/5eMI3megLHS7KLH+rAu9Q9IsCyRs6Ekq
ediQITxMag1xhjm18RwUyP1PsRnz85kClqYeXmTXpkX0fb4Qn/Mt0fRcgWVDSZML
DRztIEkO/wGMeYwbUtsrn3UmEGlMhjBNBOhQmBToA0Lkxr+QXkgXU1EdnHvgxK78
zChtiwXJIPqIm3AXgUXA3AeqabrqMXZkUc95zr5v5VovH2OFm+64/gbhiEdGIWpT
IUJOVpMMrg/JlRgk6Mav4trXzVlKU7w/EmXTBfxtN53E6981EsWnDtgtGd91Z9QT
nOsNWq94pSKew1rFKSlgbMEyYEe+pmeRFkm10ebqkmZ64e++FbWran/Mi00RDf6V
7D7tSQldjlkpVbVidHiu
=MwAg
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
