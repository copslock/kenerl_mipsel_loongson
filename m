Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 10:51:28 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.17.10]:52067 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823034Ab3APJv0Z9Wlw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 10:51:26 +0100
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0MRQIm-1TX6Rp2kyu-00SqKL; Wed, 16 Jan 2013 10:51:17 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id EC4102A28162;
        Wed, 16 Jan 2013 10:51:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TAWXlbPpfWvR; Wed, 16 Jan 2013 10:51:15 +0100 (CET)
Received: from mailman.adnet.avionic-design.de (mailman.adnet.avionic-design.de [172.20.31.172])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 4824E2A28066;
        Wed, 16 Jan 2013 10:51:15 +0100 (CET)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        by mailman.adnet.avionic-design.de (Postfix) with ESMTP id 6938A1003EB;
        Wed, 16 Jan 2013 10:51:11 +0100 (CET)
Date:   Wed, 16 Jan 2013 10:51:14 +0100
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH] MIPS: bcm47xx: Fix BCMA build failure
Message-ID: <20130116095114.GC18848@avionic-0098.adnet.avionic-design.de>
References: <1358321286-8695-1-git-send-email-thierry.reding@avionic-design.de>
 <50F67719.5010005@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <50F67719.5010005@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:gZfzY3MOLKk0mTW/Jp6S5O8OGup52RgaFFVrvvFim4j
 3nMi0CubbCB6ZLXwcgxZBD/ZwbtGbMeNATRZAQ6KPvU8B5LqI+
 Og5151TNjtGjalbJ71bC5Gijfl4uNZ0Zl/dL3kQFJgafjYrpdU
 MhY7TRK+FPV4+XRBH9iWlH2JDxyYpeXVNPuGbGmVysP+F3wgWN
 6GLfLU/pxVIJywT2VnXcvfVxYc4X5ioa3hQOCG05pBXavYFgpM
 /4srPIH3nSYiPcLUZY9FqY4M8frWd0ufC9CGPwfPLja++3+7Y1
 onUpnEp5mAPyk4oyj0dxc35HLRXWO+onn6g28rp7AckqnICbxn
 KBMhu/8xTjLGkbsXyEyXKwBJPkpsWESkVU0SdY0+otoZB9UzER
 ndaMJ7NwDyLg9zP1Gt3qw7tAtswWcjTHMQ=
X-archive-position: 35460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2013 at 10:47:05AM +0100, Hauke Mehrtens wrote:
> On 01/16/2013 08:28 AM, Thierry Reding wrote:
> > Enabling the BCMA driver automatically selects BCMA_DRIVER_GPIO, which
> > in turn depends on GPIOLIB. GPIOLIB support is not enabled by default,
> > however, so Kconfig complains about it:
> >=20
> > 	warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO which has unmet direc=
t dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
> > 	warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO which has unmet direct =
dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
> > 	warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO which has unmet direct =
dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
> > 	warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO which has unmet direc=
t dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
> >=20
> > This patch fixes the issue by explicitly selecting GPIOLIB if
> > BCM47XX_BCMA is enabled.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Arend van Spriel already send a similar patch fixing this issue, but it
> was not applied yet:
> https://patchwork.linux-mips.org/patch/4759/
>=20
> CONFIG_GPIOLIB should also be selected by CONFIG_BCM47XX_SSB.

Okay, great. I wasn't aware of it, sorry for the noise.

Thierry

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ9ngSAAoJEN0jrNd/PrOhtxoQALCFlWIKnW7TUXuLQRNjs70K
CkjcX6qrAAsS7lUlP+pE/6JMi0xYwpKP/VfEA+uZh0uU4UA0e0mZpteOcjuA/o/S
+zH/hcoWJ7mmC1E/IFD5sSchlsAdsp0qHcITBV9SpLXBM6omh7YJrA3OV+L2s6SI
k5tF6KM4PT4dZRDdgTcC1WSxClvyEXOHcQ/wAU7c5WRA1HyOfskC5OO4T33Vvixd
lgAlWoaTn27pM9q272FvAJNGfF/OZKwopXt8noaWvhETJI/Iid8+7dE0/4T+bM3F
3Asf2fB+BnuRpfy4VwylNIJF60dl/uWfsm8qMsiZvdAWNBIplyNqPR5UXLjGkSNz
/fQMmQ5aMvMFkiEPYrOkRUkF9Opeevr7DI76h+5KjZ2TQJWmzalP/7UrihMRCh7q
zoLAlyct1sHZ3YJ6OwxtVJusiSnmG3233SktiLQ+O0mHdLm8VFlj3Kf64yndGvbp
uqg4HBpub6MxxeXEAjkuQls0cIf7e+XXtXNApxBe1QbBtUUXBCn7eVZWZGZnM2Tw
ox1hj0D9C90yHnI+lRUlm2sAAuXuUXiT6pGVU/+jGSdy7zqCnptAsxz9iNHEPIC0
wzXggVb1FFATjvoBfgECIGVsy/PJlkPD34c/WeeVc3PTmIbgHEwN2oHmoVv46J3v
j5N8CvkXm10V6Cyz82Zv
=EWfH
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
