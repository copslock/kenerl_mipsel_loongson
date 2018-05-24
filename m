Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2018 14:07:52 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991783AbeEXMHpsGszt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 May 2018 14:07:45 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A2722086E;
        Thu, 24 May 2018 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527163659;
        bh=oFQMv20n5zhKMN13AJMgHbdP+ap2VysQ2JjPgbAAIZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfEQcXl89aGDGXnYF9MDoIETZlfJzeOOGQMLoeVwkvk/eoQx8V37VRMiV0vgcMzTD
         4KrfSMdE8/OIGKW9uCZNP06Zvy9IL2rALwCfLRT93EE6afWg7kX+yQSLtfd1O8NHLS
         bkM/dDqESHWJbaJl9cGLPL/0/1l1C25VaQcOitzU=
Date:   Thu, 24 May 2018 13:07:34 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Mathias Kresin <dev@kresin.me>
Cc:     john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, martin.blumenstingl@googlemail.com,
        hauke@hauke-m.de, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
Message-ID: <20180524120733.GA24269@jamesdev>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
 <20180521163932.GA12779@jamesdev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20180521163932.GA12779@jamesdev>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64006
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


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2018 at 05:39:32PM +0100, James Hogan wrote:
> On Sun, Apr 08, 2018 at 10:30:03AM +0200, Mathias Kresin wrote:
> > While doing a global software reset, these bits are not cleared and let
> > some bootloader fail to initialise the GPHYs. The bootloader don't
> > expect the GPHYs in reset, as they aren't during power on.
> >=20
> > The asserts were a workaround for a wrong syscon-reboot mask. With a
> > mask set which includes the GPHY resets, these resets aren't required
> > any more.
> >=20
> > Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RC=
U syscon-mfd")
> > Cc: stable@vger.kernel.org # 4.14+
> > Signed-off-by: Mathias Kresin <dev@kresin.me>
>=20
> Applied for 4.17. Thanks for the acks/reviews folk!

drivers/soc/lantiq/gphy.c: In function =E2=80=98xway_gphy_remove=E2=80=99:
drivers/soc/lantiq/gphy.c:198:6: warning: unused variable =E2=80=98ret=E2=
=80=99 [-Wunused-variable]
  int ret;
      ^~~
drivers/soc/lantiq/gphy.c:196:17: warning: unused variable =E2=80=98dev=E2=
=80=99 [-Wunused-variable]
  struct device *dev =3D &pdev->dev;
                 ^~~

Easily fixed, I can drop those two lines:

diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
index 8c31ae750987..feeb17cebc25 100644
--- a/drivers/soc/lantiq/gphy.c
+++ b/drivers/soc/lantiq/gphy.c
@@ -193,9 +193,7 @@ static int xway_gphy_probe(struct platform_device *pdev)

 static int xway_gphy_remove(struct platform_device *pdev)
 {
-	struct device *dev =3D &pdev->dev;
	struct xway_gphy_priv *priv =3D platform_get_drvdata(pdev);
-	int ret;

	iowrite32be(0, priv->membase);

However it does raise the question, it sounds like a fix, but was this
patch tested and the warning just overlooked?

Cheers
James

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwarBAAKCRA1zuSGKxAj
8jdfAQDtnf7symakcWD4AS3WzH47QVijebMTfKH00E6gisIwBgD+LwAIaWipyGiS
eMh14y1Gq1rNYFesjlI+TGlrdRrzhw4=
=b82W
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
