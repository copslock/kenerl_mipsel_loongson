Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 22:43:01 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeBOVmySLoGO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 22:42:54 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2E32175A;
        Thu, 15 Feb 2018 21:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2E32175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 21:42:43 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Message-ID: <20180215214242.GL3986@saruman>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
 <05aec8b194d01871c2e9f62ce38d68b56dff59ca.1517437177.git-series.jhogan@kernel.org>
 <20180215174203.GA21337@kroah.com>
 <20180215213847.GK3986@saruman>
 <20180215214142.GA31227@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I4VOKWutKNZEOIPu"
Content-Disposition: inline
In-Reply-To: <20180215214142.GA31227@kroah.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62565
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


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 10:41:42PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2018 at 09:38:48PM +0000, James Hogan wrote:
> > On Thu, Feb 15, 2018 at 06:42:03PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 31, 2018 at 10:24:45PM +0000, James Hogan wrote:
> > > > Move the Kconfig symbols USB_UHCI_BIG_ENDIAN_MMIO and
> > > > USB_UHCI_BIG_ENDIAN_DESC out of drivers/usb/host/Kconfig, which is
> > > > conditional upon USB && USB_SUPPORT, so that it can be freely selec=
ted
> > > > by platform Kconfig symbols in architecture code.
> > > >=20
> > > > For example once the MIPS_GENERIC platform selects are fixed in the
> > > > patch "MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN", the MIPS
> > > > 32r6_defconfig warns like so:
> > > >=20
> > > > warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_MMIO which has =
unmet direct dependencies (USB_SUPPORT && USB)
> > > > warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_DESC which has =
unmet direct dependencies (USB_SUPPORT && USB)
> > > >=20
> > > > Signed-off-by: James Hogan <jhogan@kernel.org>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > Cc: linux-usb@vger.kernel.org
> > >=20
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >=20
> > Thanks, I'll apply this as a MIPS fix for 4.16.
> >=20
> > Okay to leave patch 2 for you to deal with Greg since it doesn't really
> > directly affect MIPS nor is it important for 4.16?
>=20
> Just take both of them and be done with it :)

Okay,

Thanks
James

--I4VOKWutKNZEOIPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqF/tIACgkQbAtpk944
dno/2Q/+Mug9TCodPB67fp2sWWrOGOgk5+O+FpMZhc1jMaVnQPk4zOXUliKAki7I
uWyArJtTtrLisMSfyY50WYZIN5LWIhIwPtj5G1QCUtzibnMaiap19moIU7/v2Fdv
w6Yi3g+JyLkl1mSRyq+Qi0VKar1WqIaUdIWhs8sLLHia+rUYRbwppRKUxPb5dIni
Q62v59Je2LBgLwQaFcSpsMflehV0pBMjnU/U3vhlu5D1AsOH8yEZqFWuXw/vqOh9
gvteEgu4DNPD3ldHCWZUxPeQgtvDdjwkSl4+TvGzcuc7MYFY5vp9DCbA14EUySdk
zR6LmTxZlHZnYfHqbyCz6VqBSVPSocIBVCNjB8TAQOTcr71afHF1keeQU0vDh+Ps
NI6GrF+F32keyPaGJ+VT6/j4wb4TGkVW6luwdCikEvg/qAtj5xN5yOUN7Ioitb49
jm5AZ01LMbP/CnRZbbIw3sLDGQwQpjsfW8FkpOzVV0AsnX4ovwJ0leO9lRBl4okz
5wMqQQHTqvj6ytY/PnWyEEY0ewGg/qd54zRPVNDphlZKlw8FH3misPHWeSxtEA89
u49MFlu5G3s1cks/4GKYC1jfOV41d8FWjBfTBfOuE5yU77GzdiDBYfqDcCSDm7LM
38QiOwD3L/6F6Qos0t/JfgU9UJKPgDchHBQffKZqahB1+yn+0XU=
=6A5l
-----END PGP SIGNATURE-----

--I4VOKWutKNZEOIPu--
