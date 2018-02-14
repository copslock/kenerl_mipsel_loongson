Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2018 18:01:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992096AbeBNRAxWa4pf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Feb 2018 18:00:53 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5AB2177D;
        Wed, 14 Feb 2018 17:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5AB2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 14 Feb 2018 17:00:42 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] MIPS: mscc: add ocelot PCB123 device tree
Message-ID: <20180214170042.GE3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62542
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


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 11:12:38AM +0100, Alexandre Belloni wrote:
> Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Please Cc DT folk.

> diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/d=
ts/mscc/ocelot_pcb123.dts
> new file mode 100644
> index 000000000000..42bd404471f6
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2017 Microsemi Corporation */
> +
> +/dts-v1/;
> +
> +#include "ocelot.dtsi"
> +
> +/ {
> +	compatible =3D "mscc,ocelot-pcb123", "mscc,ocelot";

Should mscc,ocelot-pcb123 be added to the mscc DT binding documentation
in the other patch?

Cheers
James

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEazoACgkQbAtpk944
dnocQw//fpcnqfZS66x7TEp9LKICny/fGLn9eDLZt5hCK51w8AIdSbGdLQ4V6pB5
ps7LiLJ83HQ6+6FmITB8YIXPNQo4k2Ay8WCQbx2ONXEED2G4dcfJlTZq0n6Kc2Iz
WZto+AxV3f8bQstfxXJ1bXGsnUZ4XxpXLm2oebW319YZJWDJgeamCNxnCcQfOkvP
1chpa9covZToaGKeZkt/PiwVn8kXvUt8YtNq1DuyjlxRkYZw0dpVyrcTUjz3c8Qg
DwrIJgv4Xos2IjW1PNlvcEodx6PneXxrITyLsY4K/ojwo32QLTFpsAIOprrgnY0G
YEUsPe/nGXO1YiZc9uaugpoeZ9Z7uRTqMkJ1isQtTCE4QSws2ys0a23XvbkVX4k9
v/QuI4fhoFm2vzvXi1itctpPg6s16HhZbEy15bSjWwDHe+iB17dIUiHDVp0UyT5/
bi4rEw5yjS4Q/lXxWoIw4mC0NSzuxYzVn6hqp0bKdp4mXwkVKngDj6BF3U7MOKO/
hxHQqaW4tuIkQIzzRLwBvsR3XHRupIs5G5HTrLWT807Ot2WeQ6l3+2KSfScnozqx
F/Vduu6ygFJIhdK5sNNIJKe7bHNp2AgF0ggxA8Mw9rN/SrjtKhSsEoyXFhXp404a
uwHhISjmNZdYzsVzvy8TuBy0HqUSwOhZV2o2KQ69tYIXO929j0Q=
=DpII
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
