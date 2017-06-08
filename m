Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 13:58:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4313 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990517AbdFHL5ySs4Ru (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 13:57:54 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BAA7541F8E51;
        Thu,  8 Jun 2017 14:06:56 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 08 Jun 2017 14:06:56 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 08 Jun 2017 14:06:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 05BEE11B27571;
        Thu,  8 Jun 2017 12:57:46 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 8 Jun
 2017 12:57:48 +0100
Date:   Thu, 8 Jun 2017 12:57:48 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS: Branch straight to ll in mips_atomic_set()
Message-ID: <20170608115748.GU6973@jhogan-linux.le.imgtec.org>
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
 <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com>
 <580e1148-aaf9-895c-09ec-8b38772a9154@gmail.com>
 <20170531164754.GM6973@jhogan-linux.le.imgtec.org>
 <d671ae4e-f58b-6f7e-4814-f8ef764a8625@gmail.com>
 <alpine.DEB.2.00.1706080734010.21750@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="udzYTtuEmHLUHegf"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1706080734010.21750@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58305
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

--udzYTtuEmHLUHegf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 07:37:14AM +0100, Maciej W. Rozycki wrote:
> On Wed, 31 May 2017, David Daney wrote:
>=20
> > > > The subsection keeps the code for the (hopefully) cold path out of =
line
> > > > which should result in a smaller cache footprint in the hot path.
> > >=20
> > > Hmm, yes that would make sense if it did something useful there, but =
it
> > > just immediately jumps back to the ll.
> >=20
> > In this case, it could be that the pattern was copied without carefully
> > examining what was being done.
>=20
>  A PAUSE might be in order here.

Quite possibly, though I'm not sure its worth bothering to optimise this
old/unused code.

I had a patch somewhere to add PAUSE to spinlock loops...

Cheers
James

--udzYTtuEmHLUHegf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlk5O6wACgkQbAtpk944
dnqfTxAAnN+9nmOfMJym9gJ5Ul83irC8NMfC8rIyEptKvrgtGoq9qyvCeUX7XUt7
8YOl0aX+XFp0jeodcP9GibCHhVKX9nPjZUUs+qn/Jyc1tuk6R9/0ccobYpNlzSmg
k7sPwMD70A6JUolA8njCxnAHepqZaSPKNXcENHQNpuo7ZFzoEGxHi7BuDQCc/p2E
UWsqPFZZtT/ytsuoY8xdtEvq4X1FmLqGgAD5/YPrT7bZ+8aNtBtjNfMdigVqg/vA
O2yiT+DFkTtyKzq340R0lO2uXY+w9gOJM2Nauwsx/8TWlpgzVWfs4UU/YJ+3tbeh
6xIiOCJ8riUuYqp5duGXzNB2rxN7RA8I0pQE7mNBqt/PH6DieOsyQMhpTjR0HyyR
B64VQFrcIh6VDSEe3zdu8Eh9Lf/Dvr21d18lIHgGGXs3cYz0sMrdTdPUOU0I35En
c33sR3L23ylO6vGBOT1x4lVp2pX3hEjmmXsLxpJftoxSzmZXOEKeQCvOqNddScie
RM9RSnYzMYnbAYloqHD7+bvsCDRWNr9OGqx9tPdmoftqoPrwxO962RE1jjy/Wrp2
DCFW91WyG9XpxUraWEK0n+iGPcBckMd2rDmFXG7z0xJqZKPl35sTeRS8yYeOiedH
+/OcLcH4MthjZcxZWQ5LnL+oolwjEJQ/3tSxLHEap38urq2xIDI=
=DEaM
-----END PGP SIGNATURE-----

--udzYTtuEmHLUHegf--
