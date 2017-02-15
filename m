Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 11:37:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24734 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993877AbdBOKhaurP1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 11:37:30 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0E6E741F8DEB;
        Wed, 15 Feb 2017 11:41:25 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 15 Feb 2017 11:41:25 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 15 Feb 2017 11:41:25 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6A5705E9501B0;
        Wed, 15 Feb 2017 10:37:22 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 15 Feb
 2017 10:37:25 +0000
Date:   Wed, 15 Feb 2017 10:37:24 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     <ralf@linux-mips.org>, <paul.gortmaker@windriver.com>,
        <linux-mips@linux-mips.org>, <john@phrozen.org>, <lkp@intel.com>
Subject: Re: [PATCH] MIPS: lantiq: set physical_memsize
Message-ID: <20170215103724.GW24226@jhogan-linux.le.imgtec.org>
References: <20161227153143.8601-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5KENZRfAmuo1v8rU"
Content-Disposition: inline
In-Reply-To: <20161227153143.8601-1-hauke@hauke-m.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2016 at 04:31:43PM +0100, Hauke Mehrtens wrote:
> physical_memsize is needed by the vpe loader code and the platform
> specific code has to define it. This value will be given to the
> firmware loaded with the VPE loader. I am not aware of any standard
> interface or better value to provide here.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied

Thanks
James

> ---
>  arch/mips/lantiq/prom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 4cbb000e778e..96773bed8a8a 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -26,6 +26,12 @@ DEFINE_SPINLOCK(ebu_lock);
>  EXPORT_SYMBOL_GPL(ebu_lock);
> =20
>  /*
> + * This is needed by the VPE loader code, just set it to 0 and assume
> + * that the firmware hardcodes this value to something useful.
> + */
> +unsigned long physical_memsize =3D 0L;
> +
> +/*
>   * this struct is filled by the soc specific detection code and holds
>   * information about the specific soc type, revision and name
>   */
> --=20
> 2.11.0
>=20
>=20

--5KENZRfAmuo1v8rU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYpC9kAAoJEGwLaZPeOHZ6vsIP/08QXS4p5WlMaq/MEtcBLpMa
Fbz+HouNsRA8CNjT6SpSWvJeMLtM8CrjntfeZRR4ARBBZSKbSlUJrOJf2EFrX7SH
o/TSB4GJJwt1BjoONHqC/gcMyFkdzMlF8pqU+O7nd4vwINS6/0If4Utpv7smbNDz
64hxd7755xpPm6hMaHUiLP5V+UOli7J8GnfstWG/mmI+mlc636Og8CbSNWxAIQdU
YbAWb0cDQhCqgNyVTLvmX5tgrQOdsZtI/5PZLFEREqJavozc+6eoIztqiBZDPZjT
R6ltv9XTqw/FGI3usO70YT3InfOxQyYbOD0tnhingzdxXkku5Bxw7K5ho8T4+Fo/
R4A0ronw8zmfyWtjh9zfQgec1z+CYQdBIYPUynTfKxXhgW3ufQECpHGTVe9DLLHa
LQERGCgkW+zKOic57CsbIpaJhMWQIuuxv1a09lklNF8P5Tsxvg15TfxyeWC2AtcR
gTxxkwtx/90Zo4hm0dRUTutKot3n6DxQHUCJUELDvc2hS7reG899mPtVS8lqVDM/
rLRyNc6N24zR4ZvLdrNjEPVcBWLQdiYv9iQ54qVpruxfFYPg5TsLjzDUMtFUjXJ8
DgOSVR678Hkvh3QF6xm6WG/210jAzY+4KoIOwcG1I20btz+ks0NInyPi9zEyaA/X
QijfgcirhnmcO076NZy7
=jxkP
-----END PGP SIGNATURE-----

--5KENZRfAmuo1v8rU--
