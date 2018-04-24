Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 12:48:14 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993856AbeDXKsHrl-5k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 12:48:07 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FA521774;
        Tue, 24 Apr 2018 10:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FA521774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 24 Apr 2018 11:47:56 +0100
From:   James Hogan <jhogan@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Dan Haab <riproute@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] MIPS: BCM47XX: Use __initdata for the bcm47xx_leds_pdata
Message-ID: <20180424104755.GA24874@saruman>
References: <20180323225807.13386-1-zajec5@gmail.com>
 <CACna6ryoYs75Pt7qXSuozZsEt27YMyJAhvF21QRLQVuryn_dZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <CACna6ryoYs75Pt7qXSuozZsEt27YMyJAhvF21QRLQVuryn_dZA@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63721
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


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 06:51:35AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 23 March 2018 at 23:58, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wro=
te:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > This struct variable is used during init only. It gets passed to the
> > gpio_led_register_device() which creates its own data copy. That allows
> > using __initdata and saving some minimal amount of memory.
> >
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> James, would you care to take this trivial patch?

Yes, applied for 4.18

Thanks
James

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWt8LSgAKCRA1zuSGKxAj
8tIJAP9VB18Z3/XR50KarBatlofKgPO12sf578rAMxXwxtOEbwD/RwiIFn6NH+27
WsI7Nejtbpu2TpUz/xaG4ghA2Es+QQ4=
=iLBh
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
