Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 22:39:07 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeBOVi7ohiZO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 22:38:59 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8052175A;
        Thu, 15 Feb 2018 21:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8052175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 21:38:48 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Message-ID: <20180215213847.GK3986@saruman>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
 <05aec8b194d01871c2e9f62ce38d68b56dff59ca.1517437177.git-series.jhogan@kernel.org>
 <20180215174203.GA21337@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bX/mw5riLlTkt+Gv"
Content-Disposition: inline
In-Reply-To: <20180215174203.GA21337@kroah.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62563
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


--bX/mw5riLlTkt+Gv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 06:42:03PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 31, 2018 at 10:24:45PM +0000, James Hogan wrote:
> > Move the Kconfig symbols USB_UHCI_BIG_ENDIAN_MMIO and
> > USB_UHCI_BIG_ENDIAN_DESC out of drivers/usb/host/Kconfig, which is
> > conditional upon USB && USB_SUPPORT, so that it can be freely selected
> > by platform Kconfig symbols in architecture code.
> >=20
> > For example once the MIPS_GENERIC platform selects are fixed in the
> > patch "MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN", the MIPS
> > 32r6_defconfig warns like so:
> >=20
> > warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_MMIO which has unme=
t direct dependencies (USB_SUPPORT && USB)
> > warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_DESC which has unme=
t direct dependencies (USB_SUPPORT && USB)
> >=20
> > Signed-off-by: James Hogan <jhogan@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> > Cc: linux-usb@vger.kernel.org
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, I'll apply this as a MIPS fix for 4.16.

Okay to leave patch 2 for you to deal with Greg since it doesn't really
directly affect MIPS nor is it important for 4.16?

Cheers
James

--bX/mw5riLlTkt+Gv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqF/ecACgkQbAtpk944
dnpNdA/+JD4WMP5Vww7CCSSwOFTZu2OagHbNIdWX42GLbY3lKGnSMg1Bc7objovO
2nWfVMIIpTp0Glqr14bR5Nhmx4e6BkB+jRpRMZQuF12ULISPnOYb8C0FR9gqBYCf
g7MFxucwP3YlM4VEi5UHOfnT1WToGEn75iJEnwpho9rsy5eJbxHFb6CAzszQQE+b
46/t7zMbccJPF+CrCAE6attjf6hVMlSMFUFSl8xc99rjbD6OBeHsLbV4z2ANYt48
H3BaY0ijLp015qbiDNvdud/7EkEwKYpaboOhs11P+avA57jOpR5zF4D2NQkCcgFo
SWUhzO89ARE7eUeBYt4tE2gCxxvLFZRQuLNi/jH4eWDvJ0ZYTjh3LXcncKfAiZhB
GIbWhJQLc2ZIyAihOb+v+0l4MPfn7asXC+DssDkPZPDuKHfnF4VoXCnGSeMw74vY
YBYU9JRiz+VVmaESdFJpZZXGZLZsLnhZBfMC8Q69IXbB2FGwttxzDzruTvhyp4hu
cNiorkZUHi/IKn9p6KNNE+dTld6PDV7OtSK2xxMayMbQsS0err0mNj0oiZXgMMhX
mqxN5TiGyXz2C7fqHZh4CShHe2AHPqp1fEPd6h5Y8lNdY+tpgWPaNav93I2tpiBg
NLbcTK1Fvyf/NYuun1IszFaeHTMdDzjbkithyadTVhEruHEy/pI=
=kUPI
-----END PGP SIGNATURE-----

--bX/mw5riLlTkt+Gv--
