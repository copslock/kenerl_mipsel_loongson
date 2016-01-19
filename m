Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 15:22:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1879 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010833AbcASOWWilq5j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 15:22:22 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B272041F8D4D;
        Tue, 19 Jan 2016 14:22:14 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 19 Jan 2016 14:22:14 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 19 Jan 2016 14:22:14 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id B0AC2F1531C75;
        Tue, 19 Jan 2016 14:22:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 19 Jan 2016 14:22:14 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 19 Jan
 2016 14:22:13 +0000
Date:   Tue, 19 Jan 2016 14:22:13 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Michal Marek <mmarek@suse.com>, <linux-kernel@vger.kernel.org>,
        "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kbuild@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Message-ID: <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
 <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
 <1667268.iM977TQnEK@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <1667268.iM977TQnEK@wuerfel>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51221
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

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 03:09:14PM +0100, Arnd Bergmann wrote:
> On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> > When a header file is removed from generic-y (often accompanied by the
> > addition of an arch specific header), the generated wrapper file will
> > persist, and in some cases may still take precedence over the new arch
> > header.
> >=20
> > For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> > context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> > and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> > the wrapper when reusing a dirty build tree resulted in build failures
> > in arch/mips/kernel/signal.c:
> >=20
> > arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=80=
=99:
> > arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=E2=80=
=99 has no member named =E2=80=98uc_extcontext=E2=80=99
> >   return &uc->uc_extcontext;
> >             ^
> >=20
> > Fix by detecting and removing wrapper headers in generated header
> > directories that do not correspond to a filename in generic-y, genhdr-y,
> > or the newly introduced generated-y.
>=20
> Good idea.
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd

> Can you merge this through the mips tree, or do you need me to pick it
> up through asm-generic?

I was envisaging the kbuild tree tbh, but I don't really mind how it
gets merged. This patch depends on patch 1, which adds generated-y to
x86 so we don't delete their other generated headers, but other than
that it doesn't really have any dependencies.

Cheers
James

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnkaVAAoJEGwLaZPeOHZ6LmUQAKpWgHRKouJiF5R5uD2uvVkn
PfRiCE8HmFx4ZN6wZu5uSF8wujCGQGxUr6JTvfyC66CvHlFSgPwCwHEseoTFAvHj
rE77AQcz3qUwz30KIfS9Hj7XaBBPgi6XC9ljQ4qghijCpLANreyLvah90pg1Tgge
r9AX7SaSsXMX9jJj8h6zOuTKXELlDAzi6rGm/Zp+dzscdht9U5OoTruJ06HvxdLG
+4AdpuYpAW+qHYrqhmo6vGWwgLZaps37dOHk0pRcdRXRVaaCr9LjZmywR/FAz6+3
idr6ME2irAhSe8sMXB+A4dscHp8GFCcutyInhNFSw5JrZrifjp15sLhpbb8pgX5y
I4N8mn9ADW/bRNcvi6Y9zPBNLbnY+kOdPNKrSsJbtW9oLhS4ZR9amYjqsfzFfWzM
yvhr1BB7ENHca2aF9Cm2RM0W25luhYjOhMY1QMTg0Wk28dbGeKh5eMOt4MEuf4/1
sd/b5SRgAIoSCvq9dJfIpOv6tu0WIooepA6ZtJ7N7LYSaI7PdAbjIqKG/lNUWB66
PFzprvBh9XI/dpoUTYtWgIG7Kt6cLA8gcfwqa0ZCK+1B0kR/B2OxymaXEIig/CpL
54F2hef8q3L8aHlP6XZ4911AT2nPhtt9s4hoUhWnJBnkWlS5C5RyiSmPzfp617tn
iWeC12OMk1R0ZgpqL3HU
=Lh3+
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
