Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2018 23:48:56 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993945AbeDEVss22NfD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Apr 2018 23:48:48 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEFE2075E;
        Thu,  5 Apr 2018 21:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEFE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 5 Apr 2018 22:48:37 +0100
From:   James Hogan <jhogan@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Dan Haab <riproute@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Dan Haab <dan.haab@luxul.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Use standard reset button for Luxul
 XWR-1750
Message-ID: <20180405214836.GB31336@saruman>
References: <1522362107-3363-1-git-send-email-riproute@gmail.com>
 <CACna6rwJYVUVwvi9U87V=u5_T29JCi0VT9knsxwauci5xFAE5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <CACna6rwJYVUVwvi9U87V=u5_T29JCi0VT9knsxwauci5xFAE5w@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63419
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


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 09:28:48AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 30 March 2018 at 00:21, Dan Haab <riproute@gmail.com> wrote:
> > From: Dan Haab <dan.haab@luxul.com>
> >
> > The original patch submitted for support of the Luxul XWR-1750 used a
> > non-standard button handler for the reset button. This patch will allow
> > using the standard KEY_RESTART
> >
> > Signed-off-by: Dan Haab <dan.haab@luxul.com>
>=20
> Looks correct, thanks.
>=20

Thanks, applied for 4.17.

Cheers
James

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrGmbQACgkQbAtpk944
dnpwqw/+KoFAFLtiuTsl2SN2m+lJJzt6OdvffQWyrBBW2lxjDvtrttZx7AYHxxce
MqrkuzABnxQbxP5y0xs2xL7p3TwITYWV1rEAvd+n2bT4JD2IavN4iPksPF7mOrMU
0MdDrN8mqxBoZego7KY12EI4yxASKM9X11IcERWiro90QHar4hy2u2q2JC9WMO2c
Q87o7INx85ORRebj0zb/uCQNQXVszPK9KsYKqY4P7QHOWwShKKGrvu0cU+a3OgDM
idA64GEjiQjDlU0dzDZmoCcGCiCb/DlqdQlncuWH8T92XvbCUW+i2PjJeF/JmdWe
Wrbeb8HE6ojsVS3VMfk3GH84KMt08w4eUwqu2fEcKGIX4X+jRlfkn9X54XimFRbt
v+OTGPAbAxjqWbm9Jtopz08Q64PFspo5EHOyqMDnubLCQ2MkUavF6AdXdUQVjlf7
1kdeP8R4r/E91cOCjBnHFF1IpeOHBlZJkXAME9jg1irKfV2uXOvqYQ3EWyyH2Lt7
aHUMZdPf3mHWwHnI85ASbYsuJf7SgSzrYWbgYMN2gp2kRhgZKHnHthE3QX4NOi1d
gXk0h//xtN9mauDzi5/YXOLs8hnTQgbG3h+yy36A3yNhjWoqw3tXLRbhml5M45Tp
HNPIwpL/8d95WUtw5bTXV9Zi6fd7SerHfK/RTmQZ6ohb9uX8m2E=
=AIKy
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
