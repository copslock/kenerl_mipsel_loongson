Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 16:56:28 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994724AbeCGP4U0Ipdy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 16:56:20 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBC2204EE;
        Wed,  7 Mar 2018 15:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBC2204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Mar 2018 15:56:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/5] MIPS: mscc: add ocelot dtsi
Message-ID: <20180307155605.GS4197@saruman>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
 <20180306121607.1567-3-alexandre.belloni@bootlin.com>
 <20180307151753.GQ4197@saruman>
 <20180307152751.GM3035@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PhxIMoEr374zxJm2"
Content-Disposition: inline
In-Reply-To: <20180307152751.GM3035@piout.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62842
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


--PhxIMoEr374zxJm2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 04:27:51PM +0100, Alexandre Belloni wrote:
> On 07/03/2018 at 15:17:56 +0000, James Hogan wrote:
> > On Tue, Mar 06, 2018 at 01:16:04PM +0100, Alexandre Belloni wrote:
> > > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts=
/mscc/ocelot.dtsi
> > > new file mode 100644
> > > index 000000000000..8c3210577410
> > > --- /dev/null
> > > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > @@ -0,0 +1,117 @@
> > > +//SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >=20
> > Niggle: there should be a space after // for consistency with other
> > files. Same in patch 3.
> >=20
>=20
> Ah, yes...
>=20
> If that is the only thing left, I can resend right away

There are a couple of irqchip patches from v2 which have gone from the
latest versions:
https://patchwork.linux-mips.org/project/linux-mips/list/?series=3D568

and the vendor prefix too from v4:
https://patchwork.linux-mips.org/project/linux-mips/list/?series=3D856

I presume they're all still relevant. Were you expecting the irqchip
ones to go through MIPS too? We'd need an ack from the irqchip folk if
so.

Cheers
James

--PhxIMoEr374zxJm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqgC5UACgkQbAtpk944
dnqpZxAAhdOHk4mQz5uDlvDsxv02A9Zn0D04DY5dAfGqYa6PoqNNrx7+Mj0rxo5s
G0LweMNaHETxNlIae1bbOEF0FqT3jlRw4t6QQE4cdBYKq+v02rcmCCKlSPBLACSy
gVpvSvl9QU3bJjMFErUTtboS3Ohn0SAC5TmSyVnUFxNGTCfZfT14/xLVE+nZLhBv
R79kLdKwwWm/Cmk8yfSFAWEDygkSAPWoZ2VYgeE9DHbRMWTNUPNujF5HMug3j4rx
suHmOpI1Hr/aP0eD5iY5YW5wXCeDqSCAQN8U6QVjttE9O1MZrWW3iKzSkuFc0f8h
dgfDIj8sNazAO7rrvgwEMG8L4KiAD3fdwKazIxtkH941lJVJlOYPnXsG+i5agadw
VpNJR/WvkQdXsUIOp5F9ETwSTwXbTti2DaoPqtOC7eC9fXFIx5Ie+5IaeZF3/uEv
RKRkHcOrc2jxxQzF9SX9CM+n/ZDsr8zbfLSlsuDfZQEsDbLQr2ul69IqY7h5WOWH
6coqoXWJESUG1mZwoLn62uschdbcALLFRoJ8Thm+u5moFkcXxaTRwPqerb9IqXLP
X6eTgIyUvMIxCJNpMAv/W1dBZ3FRdL8IYzGbdHnRxfED+pF4T4IKpe4K6PRiJAK9
gSfYeKJ3NCjAGMldOjtkzGkJ27o2wwpgXnpL2CcZKxXbSfoAXcg=
=vF5I
-----END PGP SIGNATURE-----

--PhxIMoEr374zxJm2--
