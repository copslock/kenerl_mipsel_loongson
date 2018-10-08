Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 09:06:35 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:49083 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993030AbeJHHGbFqqD6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Oct 2018 09:06:31 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 68FBC208C2; Mon,  8 Oct 2018 09:06:24 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 10858206A2;
        Mon,  8 Oct 2018 09:06:14 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:06:13 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH v2 0/5] net: phy: mscc: add support for VSC8584 and
 VSC8574 Microsemi quad-port PHYs
Message-ID: <20181008070613.oblez3hryx5cxk3v@qschulz>
References: <20181004131710.14978-1-quentin.schulz@bootlin.com>
 <20181005.144243.1971242720262167660.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34ipe57f45vaxlwi"
Content-Disposition: inline
In-Reply-To: <20181005.144243.1971242720262167660.davem@davemloft.net>
User-Agent: NeoMutt/20171215
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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


--34ipe57f45vaxlwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Oct 05, 2018 at 02:42:43PM -0700, David Miller wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
> Date: Thu,  4 Oct 2018 15:17:05 +0200
>=20
> > I suggest patches 1 to 3 go through net tree and patches 4 and 5 go
> > through MIPS tree. Patches going through net tree and those going throu=
gh
> > MIPS tree do not depend on one another.
>=20
> Sounds like a good plan but patches 1-3 do not apply to net-next, please
> respin.
>=20

Could it be because we're missing the patch series dependency? This
series depends on
https://lore.kernel.org/lkml/20181004124728.9821-1-quentin.schulz@bootlin.c=
om/
which isn't merged yet.

I'll address the comment in the aforementioned patch series ASAP, send a
new version and respin this patch series at the same time.

Thanks,
Quentin

--34ipe57f45vaxlwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7AeUACgkQhLiadT7g
8aO+Nw/8CnNPFt7oJHFjvbYUPmOcH/DMNApRmyGMm3buPau5JPLDtgI/Sy9/b7ML
rEV1cXtD54Owl57HFklT+IlpP9H0dFRg1Kcju1IiouVPemzuPOn6vjwNpEvDq3fp
9a1k4sPXTwOhbNGhZmcdunetWgmOLBbTi3C8PrbLp/vZAKVG877ExivPn2aID3u7
oC5z39L9jYKwJW31gJgvXNb7a5y0f3f+AHjHK1VVwYdHOWH8MS29lEj1T7svqj4u
XQvhba8gnfR2+e59Bf+1tviGo+HPVKrosOrCV9W/tyWZsJTut/cv79Tqs6o0vpBv
UlCB+epffuntLACFhU+Z05RpLWHaW9iTHW5unanrvK5Xd7Nl/BAZGU7XAd070f9/
+GaTqqbw2HOD+QTfCA7O/agX+inJ0SLZVOM46rOo0r9/A1Bf0njKlwQlsZ8HZFM9
5s4hNljo3RqE5r15qz7NGusc+sYKlYp9hqyD/ICYq6BHoXnnfO2GU/T32Fpfj4Uk
lbMRy6zA082/r8Idbko9ppAYTagOEIgHfoxGJtxUY8FbOeS3vqIjJ0BqqGTYcRAE
1b1ry57MwzlGvtrLd8zlE2PVSuPIyd5h0I2HjZonQBelRyL2SZVdz7p3DYIIlWT5
eDyTHXWFKjo+/ffeLuTPm0wf9XtMo+Mb9cFSRlE8NBsoKjEdk84=
=LbGF
-----END PGP SIGNATURE-----

--34ipe57f45vaxlwi--
