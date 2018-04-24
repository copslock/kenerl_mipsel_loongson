Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 14:32:34 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:34796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992966AbeDXMc21nSUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 14:32:28 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD01221735;
        Tue, 24 Apr 2018 12:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD01221735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 24 Apr 2018 13:32:17 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX
 PCIe erratum
Message-ID: <20180424123216.GB25058@saruman>
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
 <20180424114956.GA28813@saruman>
 <f7af849f-f720-fc95-b6b9-8a0f94e04e9f@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <f7af849f-f720-fc95-b6b9-8a0f94e04e9f@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63725
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


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 01:06:14PM +0100, Matt Redfearn wrote:
> >> +/* ExternalSync */
> >> +#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
>=20
> Since the config7 register is implementation specific, may I suggest=20
> changing the MIPS_ prefix to something vendor specific such as
> BRCM_CONF7_ES and start a new section with a comment like:
>=20
> /* Config7 Bits specific to Broadcom implementations */

See here:

> >> +	case CPU_74K:

So its MIPS 74K specific, and some other cores have it too (I checked
P5600 and interAptiv manuals, so I'd guess most recentish MIPS cores).

So maybe its worth s/MIPS/MTI/ to clarify it isn't part of the MIPS32
architecture.

Note that the same applies to all the CONF6 and CONF7 definitions around
there, but its worth getting this one right now I think, lets not
unnecessarily add a new definition and have to rename it later.

Cheers
James

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWt8j0AAKCRA1zuSGKxAj
8kwHAQCyYBNQY8Q2og6wu3fyYoooImTqijr9NDfAuq/CKXzhLAEAx/cV9xHw0dLC
TffYKA3XBJjZLavX5AuShgjf0XA73ws=
=7png
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
