Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 13:55:04 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:35160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991416AbeBLMyz1lFHL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Feb 2018 13:54:55 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4590620685;
        Mon, 12 Feb 2018 12:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4590620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 12 Feb 2018 12:54:22 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Rob Gardner <rob.gardner@oracle.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net
Subject: Re: Build regressions/improvements in v4.16-rc1
Message-ID: <20180212125421.GA4290@saruman>
References: <1518430656-21669-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdW5qRH93CMyRL-gbWgiA_rnizErbjNtSMT5b3d58N3ZTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW5qRH93CMyRL-gbWgiA_rnizErbjNtSMT5b3d58N3ZTQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 11:28:32AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2018 at 11:17 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.16-rc1[1] compared to v4.15[2].
> >
> > Summarized:
> >   - build errors: +13/-5
> >   - build warnings: +1653/-1537
> >
> > Note that there may be false regressions, as some logs are incomplete.
> > Still, they're build errors/warnings.
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/head/7928b2cbe55b2a410a0f5c1f15=
4610059c57b1b2/ (all 273 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/d8a5b80568a9cb66810e75b182=
018e9edb68e8ff/ (271 out of 273 configs)
> >
> >
> > *** ERRORS ***
=2E..
> >   + /home/kisskb/slave/src/drivers/net/ethernet/intel/i40e/i40e_ethtool=
=2Ec: error: implicit declaration of function 'cmpxchg64' [-Werror=3Dimplic=
it-function-declaration]:  =3D> 4443:6, 4443:2
>=20
> mips{,el}-allmodconfig

FYI I reported this here:
https://lkml.kernel.org/r/20180207150907.GB5092@saruman

but I haven't seen any action on it yet.

Cheers
James

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqBjncACgkQbAtpk944
dnrzRA/8C7zFp+hDGfaEMTJvchN1s/KPNhINmM6xqiQkuWMAkYrRx/kGiscsIdtc
8CGG+u0oFl+yuTI/MY/FQi5MZQ78M2WyXMPTJsvaAHjvtFG3DYGFeDVXRVfGrB6Q
UvcoERC20bv9ihLy9tI9tR3Mf5OvTsUvjOvN9Cp2tPiOlfTjqWSuqm9UDU9fQ3Y+
rUkIoUOWOBZKNNdnmYopFEXyH831NM2VzZrLVYT+rkskOptk40chwbMuRt4dN8Rw
lvYzl+b1Guj6F4tY/fbGQ/VRXOLz1/hWI4mCg/0RIZwBQHuel1sTi2Mjp/PoQsBD
H7pAQVAkVVR+uu2K0B9dIxj1Dvp98RA3BEU4OHDIYs540BDpI4vd8h29urXhjMNq
g6BiathgvxPH+fhK8VLDtUwa6CN+tf9h19NHgTFakyj5VJuSl86bcciueq4L7dYv
fBzxlCfZqfMT6qwV0ifqG8Z+fP6T8+cXBV2bzNnHq0fXLVGvsch0pA/AcoL0PgvD
MuNpC3fuaZLs9L1z2PM7dSuqU5nUoQBVzUDRNCkMUqGS8tlMgI1Au73zR2SQnvFR
GsALvr8+eF/EHr1Ona6l9gpn1IDZOnVYi6eUu3kXpRv/+sel19+avnxC9JCMRm6q
MOvtWqDkU1IY1XnLAAN/8q96FKYTn+ZzfeQu5i/D8r73SjGp1Vo=
=8KE3
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
