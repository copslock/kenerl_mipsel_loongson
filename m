Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 18:38:02 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994756AbeCHRhy0kW0v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Mar 2018 18:37:54 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521C4208FE;
        Thu,  8 Mar 2018 17:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521C4208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 8 Mar 2018 17:37:42 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] FIRMWARE: bcm47xx_nvram: Replace mac address parsing
Message-ID: <20180308173742.GA24558@saruman>
References: <20171221144055.3840-1-andriy.shevchenko@linux.intel.com>
 <4671dc40-8c6e-2525-bed0-89e7844026a4@hauke-m.de>
 <1516282857.7000.1057.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <1516282857.7000.1057.camel@linux.intel.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62859
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


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 03:40:57PM +0200, Andy Shevchenko wrote:
> On Thu, 2017-12-21 at 17:42 +0100, Hauke Mehrtens wrote:
> >=20
> > On 12/21/2017 03:40 PM, Andy Shevchenko wrote:
> > > Replace sscanf() with mac_pton().
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> >=20
> > The patch looks good, but I haven't tested them on my devices.
>=20
> Any news on this, anyone?

Changes to this usually seem to go through the MIPS tree, so I've
applied for 4.17.

Thanks
James

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqhdOUACgkQbAtpk944
dnq8Bg/7B3oiAnCUzK+LMG7cCEUvkou/mX26lQqmAfWr9PqNs47gBdGf0WPD9VC0
A65H9IzHsOJ1w9VI8j0l8247nYEuhPQqF/TSVH3ttHX38abKsMCRdF8Bu1AMp4xo
bePfPzPaWS8tYomF89aMsoAXNs67Ch12c8gaeMdKsYoIZWIZcrwRyVO0Aok1H+Wc
E6nv6bwC/jYyJV/gCJk/mJeA0ywLOx65dWqaJzRcJVXGIJIAQJjU/55lKBsYBH1S
MX8bvi5q8Kn0wBZmdNQF7TffM1UaYnsW2o1KM5OFEpDNU2nE+FJEMNvwW7Ct91mi
y4mUmTcPL9qoL2bohOeoUKYgHAirrFBTDYq6reKY37h7jvCOSen8mle1mnpSRXGc
TvxqRERtrxIkb95zuoNyodfdR1VyI7iaxkJohG5JOcGGUeCILQfdt/yMJSzXF6kF
jWOkxw2e9KIAFbF0uzuWbp2P1HwadZIewhkkaC/ScWzaqYHN5nSgUVNsXYXa2TBl
1qLXPtdREJnHXsTFUtAbJ8EYEXnbq9eUO5d2/HzgYNb558xCBIpgBBiHZZtXoo+N
HRqGyseIPQtlPGa9VAky9keVAobSvcdt76dYGXREsrAYx4qB4MLgFVhC8G5yz6A0
uGvK69NfDhkODpIq6BfnShYpc159kVakd3R3neNnV1HoRJfnhVA=
=wluR
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
