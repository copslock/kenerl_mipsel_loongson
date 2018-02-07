Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 16:09:28 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeBGPJUyiFOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 16:09:20 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C64F204EE;
        Wed,  7 Feb 2018 15:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C64F204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Feb 2018 15:09:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, Alice Michael <alice.michael@intel.com>,
        netdev@vger.kernel.org, nhorman@redhat.com, sassmann@redhat.com,
        jogreene@redhat.com, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [net-next,06/15] i40e: change flags to use 64 bits
Message-ID: <20180207150907.GB5092@saruman>
References: <20180126212459.4246-7-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <20180126212459.4246-7-jeffrey.t.kirsher@intel.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62454
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


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 01:24:50PM -0800, Jeff Kirsher wrote:
> From: Alice Michael <alice.michael@intel.com>
>=20
> As we have added more flags, we need to now use more
> bits and have over flooded the 32 bit size.  So
> make it 64.
>=20
> Also change all the existing bits to unsigned long long
> bits.
>=20
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 67 +++++++++++++-------=
------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  4 +-
>  2 files changed, 36 insertions(+), 35 deletions(-)

=2E..

> @@ -4323,7 +4323,7 @@ static int i40e_set_priv_flags(struct net_device *d=
ev, u32 flags)
>  	 * originally. We'll just punt with an error and log something in the
>  	 * message buffer.
>  	 */
> -	if (cmpxchg(&pf->flags, orig_flags, new_flags) !=3D orig_flags) {
> +	if (cmpxchg64(&pf->flags, orig_flags, new_flags) !=3D orig_flags) {

This breaks allyesconfig builds on certain architectures, for example
MIPS 32-bit with SMP enabled, which doesn't support cmpxchg64:

  CC      drivers/net/ethernet/intel/i40e/i40e_ethtool.o  =20
drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function =E2=80=98i40e_s=
et_priv_flags=E2=80=99:
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4326:6: error: implicit decl=
aration of function =E2=80=98cmpxchg64=E2=80=99; did you mean =E2=80=98__cm=
pxchg=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  if (cmpxchg64(&pf->flags, orig_flags, new_flags) !=3D orig_flags) {
      ^~~~~~~~~                                              =20
      __cmpxchg                                             =20

Should the driver now depend on 64BIT or something?

Cheers
James

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp7FowACgkQbAtpk944
dnpISw/+KJSNpWcMAm9Ofcr1CoLgRIGHKoMrOsJ2ee4Gmc6NCwY7Zt2dxemT6MFH
XaJL+WAEm7pCjFhdzzfOcXC4pZ+iMhf42MP+FWQ3k2AncYOtg3PAIjAloXyMKht3
Y1NWgMfNIbZoqZm4Q0XfVNISuIs2encNJLMe+pQOPVMnBcA2TwNVxsc6LwFOQq8P
a2/AZKu2f4PN/MkAMJXoL3L1wcCdaN7+yK3lpsdVQFka7NT3CpCyDUdtV6pmytef
Y/DCdt3sfGVBxa4Em3HVllykN2qcbQrdLZ2/8tYD7eq8HrCRgQFj4rzOAnb/CRgP
d2y0P6k6uw2S9dycH/F4pL9qUqMWnk2t6twMDA1fySpeIRyndrI/UVVFZQkip0I5
VeARSENwcSD86RIDZBlpl55k2rZ4v+mf3roRg18eY/dtEDqQ8114wD7dCmabDNT1
x+WvGeL6c/lXld8rf0fMTsllEQGj36lp/+/tKxlK0IYdvpUSwQ4XOQGZtMrgQDNs
LtRzpOBGrEcvoRXsiQPCyFMHAa66lKRDcf/4yVBuZwRNJYy1gFBNp6YrJohaJ/Zc
iI5sOh9wGENGjO47ZBsQP2ywbUbXtnPsswMNqaOvOnNohvxjmUHSARzlrNSntLhl
FdFX4sQ8YXiblJcvrr/wT4zC4TDBywYwCPFDbblByxHg0TK5QSY=
=jZUx
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
