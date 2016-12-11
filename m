Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 23:01:35 +0100 (CET)
Received: from www.zeus03.de ([194.117.254.33]:46184 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992400AbcLKWB16D4lR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Dec 2016 23:01:27 +0100
Received: (qmail 29357 invoked from network); 11 Dec 2016 23:01:27 +0100
Received: from p54b3376b.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@84.179.55.107)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 11 Dec 2016 23:01:27 +0100
Date:   Sun, 11 Dec 2016 23:01:26 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jan Glauber <jglauber@cavium.com>
Cc:     Wolfram Sang <wsa-dev@sang-engineering.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/4] i2c: octeon: thunderx: TWSI software reset in
 recovery
Message-ID: <20161211220126.GE2552@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-2-jglauber@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <20161209093158.3161-2-jglauber@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <wsa-dev@sang-engineering.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56005
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


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 10:31:55AM +0100, Jan Glauber wrote:
> I've seen i2c recovery reporting long loops of:
>=20
> [ 1035.887818] i2c i2c-4: SCL is stuck low, exit recovery
> [ 1037.999748] i2c i2c-4: SCL is stuck low, exit recovery
> [ 1040.111694] i2c i2c-4: SCL is stuck low, exit recovery
> ...
>=20
> Add a TWSI software reset which clears the status and
> STA,STP,IFLG in SW_TWSI_EOP_TWSI_CTL.
>=20
> With this the recovery works fine and above message is not seen.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTcy2AAoJEBQN5MwUoCm2xQYP/R93T74Td5W0v2coTzSpZQlK
hlrkJ8XDlfA8lZFpzRXZRnUNtLVzP2JK5QzvdrD1HCv2OoQofMHnUkEEEz4INJCb
4U1aUz7mOSEXA3fFiaI7+Iodd4+8erBO5F/dSnP+n3L3ZdIj7+8GljXXsVubFPge
/eNGA+bsP27ME8pNVNsHj4exrrzSuOs2GeELSdJ1RjwhL7st5bVLptYA0kpkjOqU
d4L3HQZR2mRhxNzCOuEtiP1385asvgpP3C5pPxs6gQdSbRTD7Nf92IPUK5hd7hEz
PZT6bjviYvJmfjjisfF1LhE8JUDHL7HZ3L9D5Ixm9ifGQhiP0Gn5B/nmBm/in+Rp
aOMHlxgEQRz932iic7UnTu1NnuqmliN+hs+wQIt0BNLGNs518K3N8peOdNF491n3
ySCVE2cItqEZK4YSIjkmkSzbnnQjOcE0z0NaSWGNmMq51EXtIlKFf9wYL01cwTOU
A0wx4F2a9vWln1dfYwJfmoc0NdcWGsAolvSPN3f/NdPu2KFhD/8siPP4sS2ugSRO
DAEnbsMRlurfxKOcXkaTi3E7oOWx5bWPW5gwidQRR6p8rimNxOfRCwwUBFquCT8q
QzCamI46EANOwhoOtPTr89rGRWzu5F5P8urddreuP3+Upjx0ChoTayEpXGo32DIg
HHuqJ/yYiRW0OJvCFvuF
=0L5Q
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
