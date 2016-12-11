Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 23:02:27 +0100 (CET)
Received: from www.zeus03.de ([194.117.254.33]:46502 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992986AbcLKWBtSmXoR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Dec 2016 23:01:49 +0100
Received: (qmail 29501 invoked from network); 11 Dec 2016 23:01:48 +0100
Received: from p54b3376b.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@84.179.55.107)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 11 Dec 2016 23:01:48 +0100
Date:   Sun, 11 Dec 2016 23:01:48 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jan Glauber <jglauber@cavium.com>
Cc:     Wolfram Sang <wsa-dev@sang-engineering.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/4] i2c: octeon: thunderx: Limit register access retries
Message-ID: <20161211220148.GG2552@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-4-jglauber@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
In-Reply-To: <20161209093158.3161-4-jglauber@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <wsa-dev@sang-engineering.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 10:31:57AM +0100, Jan Glauber wrote:
> Do not infinitely retry register readq and writeq operations
> in order to not lock up the CPU in case the TWSI gets stuck.
>=20
> Return -EIO in case of a failed data read. For all other
> cases just return so subsequent operations will fail
> and trigger the recovery.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

I can't apply this one?


--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTczMAAoJEBQN5MwUoCm2wkgQAKYVDugoFQ+ZMHXlqxvIhEOW
9T2IhiEawt4cSnj5JhDngnkNeCbnQpj1nX73L5w5Dk6ZYWa9SwmQHaBY5I/R2bWO
JCGa+ZNTt5toB9Mby+rhNJZMztuzopYl8ylGMSEcc8IfTiKEgx3tMn1yiMipmCUk
z92wUR3Fw2Mbi9H9DhbkhYZZrq4wuQHxENhxUEJVxZgMdKBo4oUMfXC1rF2Sxjz2
hncyBm0LlWrDMNlklUQjtcdTRPb3sNA3vvkAfGf3vSg/XZDYN/mfuwqYGwq6cpwA
w3kFM8lAm8erxZVojmvnFlgbzBmvf1obIL5Xi7aoZS1+Yu7trAhp7qQAgdOyDeME
8lpBM+jrd/wcD4doquSApa5Aqn7zgLf09HnS+Ut6NGr3D2zfmcUQeA9yYejiGgb0
4yI+Y07d1Vd3OqUfDcTOJN2+kdngkdxdhaDOeFgfcFtz5eJvqnXWhRv17E1oHBv2
wiZFIfTUlLtqFmr773zAfaAGmF6g6Imi5FvkGVOt++geZTrgUaIhEq2Hzhk2vP6F
czaMqUB6R8NcaHf9Qe+4Cn2Olhrs46GHnPibE4MebR1IDJMNpyXtKnXQYuU/HXN9
yD60i8BDQevIo9dqeMnMDyFui/KSRi5axK6iJawNV6s1bnbibo3XWwNk0c/XlHYD
Sw8SKaEr/hxuQK1ju2ry
=3S4s
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
