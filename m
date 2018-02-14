Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2018 18:05:58 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991248AbeBNRFvqQ8wf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Feb 2018 18:05:51 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A115121782;
        Wed, 14 Feb 2018 17:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A115121782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 14 Feb 2018 17:05:41 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] MAINTAINERS: Add entry for Microsemi MIPS SoCs
Message-ID: <20180214170540.GG3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-9-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-9-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62544
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


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jan 16, 2018 at 11:12:40AM +0100, Alexandre Belloni wrote:
> +MICROSEMI MIPS SOCS
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/mscc/
> +F:	arch/mips/boot/dts/mscc/

You should probably include
Documentation/devicetree/bindings/mips/mscc.txt here.

Cheers
James

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEbGQACgkQbAtpk944
dnplGBAAsAsBN3T06vY4vf3HZhBKXwNcbG85Kn4W+P7lWxQLueZ8qQGJrZ4gzss/
aQlAj1sF3ggZqcRBMzMaRRdcO9Nh0hwdlrdI1MI7+mQQBBVxeKmdJ+7DTfr2TRjj
FzLYu9rgsoooFjgfQPBGw6pPllsSBY9CK9WPz6jFwi67uNoVSyP4mk5eRV1pMDfX
k02p0oQ3snkxVB48HewLEjH80lIoQAmDUlN+X8/zU5kHb6lEhCo9kgBQ701uMFri
xc7vJyCOwUvU7DQORxorKGf/ONQD1WybqGlsNb6vgkgZtmxNVennpdwBeGWeCsuy
qC4ZFgSsOWsybqenAS6gytNb3IUBUSDqp4ts6Dq68porx/Zp6v4HZpSVCu/+FPKk
UkElW0FonJoP8OGXC3PNHghzrBmdvvWTp2x6JphS8akS4gKG0fWL7CKwCVZB2Ew7
o8SeTEqLx0lmtH9j0Ox7TASynBndP4gjuSY82GVO3hkeigFutgZgS/dmH8czTOPM
pJhZQyC7HD+/p5N6C25QKq3QzuplLxOnOlvFkVxbNBqmzBd+BKLqbCwijweSBELA
1n6upTa24OGpgJ+ubjvrpsQI4jcgI1jcKe4xrAyBYLx/mJdSMybS/7Ogi7QqNMoI
S3AUWTBqHbw2PeyzKpBiRKo4kG/yvVBcTZb80e1ZyXqvhcPV9jM=
=B4cz
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--
