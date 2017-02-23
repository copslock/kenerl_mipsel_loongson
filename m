Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2017 13:58:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46834 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993543AbdBWM6OSH4SY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2017 13:58:14 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9C5F241F8E86;
        Thu, 23 Feb 2017 14:02:30 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 23 Feb 2017 14:02:30 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 23 Feb 2017 14:02:30 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DD5FE5ABBD7AF;
        Thu, 23 Feb 2017 12:58:05 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 23 Feb
 2017 12:58:08 +0000
Date:   Thu, 23 Feb 2017 12:58:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     John Crispin <john@phrozen.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] arch: mips: ralink: fix typo in pinctrl lna_g_func
Message-ID: <20170223125808.GA2878@jhogan-linux.le.imgtec.org>
References: <1487582851-39806-1-git-send-email-john@phrozen.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1487582851-39806-1-git-send-email-john@phrozen.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56888
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

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Mon, Feb 20, 2017 at 10:27:31AM +0100, John Crispin wrote:
> There is a copy & paste error in the definition of the 5GHz LNA pinmux.
>=20
> Tested-by: John Crispin <john@phrozen.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Can I have your signed off too please.

> ---
>  arch/mips/ralink/rt3883.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
> index c4ffd43..f9025a0 100644
> --- a/arch/mips/ralink/rt3883.c
> +++ b/arch/mips/ralink/rt3883.c
> @@ -35,7 +35,7 @@
>  static struct rt2880_pmx_func jtag_func[] =3D { FUNC("jtag", 0, 17, 5) };
>  static struct rt2880_pmx_func mdio_func[] =3D { FUNC("mdio", 0, 22, 2) };
>  static struct rt2880_pmx_func lna_a_func[] =3D { FUNC("lna a", 0, 32, 3)=
 };
> -static struct rt2880_pmx_func lna_g_func[] =3D { FUNC("lna a", 0, 35, 3)=
 };
> +static struct rt2880_pmx_func lna_g_func[] =3D { FUNC("lna g", 0, 35, 3)=
 };
>  static struct rt2880_pmx_func pci_func[] =3D {
>  	FUNC("pci-dev", 0, 40, 32),
>  	FUNC("pci-host2", 1, 40, 32),

There is at least 1 other typo in this file from that same commit:
static struct rt2880_pmx_func ge2_func[] =3D { FUNC("ge1", 0, 84, 12) };

Care to fix that one too?

Thanks
James

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYrtxfAAoJEGwLaZPeOHZ6TUYQAJbCBjM1uqd93GQO/MnfOFo1
PtNwwI0IO/ENfFqebBwWBHkZ/u9JCCX86WRtsF2N1z6X2WmYh2RgvUdJxG7QEN5K
bSeBlusJs0VjZ8zWb+ikWZuvukAsJfjELuuoXBLMIiVFkPKHAbEyHHLbkiet70E2
IWhfMF6U8lS+McSltW+T5xGIIfQcFcJQj+v02kES2tpK8FxwckldcsxukmpigSTL
D0RJGcrauu3vjYRS51QzDJBHQNgLFxMqamAERb7MsrpSCmWdHkkBhZ2No903GpvJ
yhI6iFv2XnbtenXD/mLHlAVKFJl9l45oiZfpqE+If1mwL7TvagUpmfa2/Achilef
GdhGJBBJYSiOSUUQK58eC3qU+i4NwPvEH8N6fUUoMcvrknJ8mgrt9xuiwYy5QVct
EfAI/YOq/AK4rvNwa/ulQ5i+N6J11trBNQ1R343mXA9anVmpjkf4b24d1l2dljzP
yLfoDekKVMSb8n313+OaOKh/E3kb/9GHv8A9yujaQehY49u61IRMyJLJcTLXeqd8
ugE2rbPfMtOvuCM7QgxceIDt9WW/d37rktg1cVTlLvIM7ey4bsDvMCFAGe6wXROJ
PvhJtJdaBhZuFRl688BmZTA9uhsCjYk4hJmDHehe2/GjOqzrqpa81ZXTRfhrnbvJ
z/8xPI+aEI9Ib4Ejw8Qv
=JGhC
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
