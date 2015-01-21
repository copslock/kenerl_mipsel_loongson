Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 10:44:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55682 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011344AbbAUJo6LJxd3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 10:44:58 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C173141F8DC6;
        Wed, 21 Jan 2015 09:44:52 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 21 Jan 2015 09:44:52 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 21 Jan 2015 09:44:52 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5552C45B67549;
        Wed, 21 Jan 2015 09:44:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 09:44:52 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 09:44:50 +0000
Message-ID: <54BF7512.2090409@imgtec.com>
Date:   Wed, 21 Jan 2015 09:44:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 35/36] MIPS: initial MIPS Creator CI20 board support
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com> <1421620987-25796-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1421620987-25796-1-git-send-email-paul.burton@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="NKIC9ADX7OWD81bxG34VwmTfNSiVBS9Ej"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45394
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

--NKIC9ADX7OWD81bxG34VwmTfNSiVBS9Ej
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 18/01/15 22:43, Paul Burton wrote:
> diff --git a/arch/mips/boot/dts/ci20.dts b/arch/mips/boot/dts/ci20.dts
> new file mode 100644
> index 0000000..69f7a9a
> --- /dev/null
> +++ b/arch/mips/boot/dts/ci20.dts
> @@ -0,0 +1,21 @@
> +/dts-v1/;
> +
> +#include "jz4780.dtsi"
> +
> +/ {
> +	compatible =3D "imgtec,ci20", "ingenic,jz4780";

The vendor prefix for Imagination Technologies is just img.

> diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_=
defconfig
> new file mode 100644
> index 0000000..927bd43
> --- /dev/null
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -0,0 +1,128 @@


> +CONFIG_INITRAMFS_SOURCE=3D"arch/mips/boot/ramdisk.cpio.xz"

don't think you should have this one.

also, I think SERIAL_8250_JZ47XX=3Dy needs adding.

Cheers
James


--NKIC9ADX7OWD81bxG34VwmTfNSiVBS9Ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUv3USAAoJEGwLaZPeOHZ6jIgP/iYqjSdBVyI1oCCOvMVAX5XC
nEFDVZ6LlfE/un1ElnzlkKQ/6PPgDCMWPoYCgfSqN9hCec2WNWYF2N39Kl4o/z5c
P2swD8DWocufgseKurliLLYz8G7k3VwGkI3NF2sLkw2+LB1HI/4BA5ksq/KpDwxI
RyP/SOJZZAhIStqaEMLLCNeA5kj8z/ay2yPUnoYnzYSxUS4j5Vz3ZedcGoV9hTbs
ydjSQk4cFDXwk+AM1StdAQvlWb70FTvJgTel+DIvv9BJA2D2MpVyJEpbOViRV8WK
FJWkbKGgfHIe2XQLhlMjqCWifGJD2IEdHWysB/JkzsBUKPmpvsFHSbOghiOkHxG+
/UYY2xYybgYjrn9aKTS1lXEpOwRWGe1djvZkz8p0I4glO0J0o6cMD6FBEeKTadhF
MN30ilb1GqdT8djUbmHuqFxo1kQ5RDdD3d3OWqP2+0ScCebwXBG2f+d5CuWULSAK
BM80gVwzZM/CEWhivOGi7VvEKSj8KvH8obQrQ7VSSbaEruvQxpxz6Fbl5Q4Jn1ZM
EdcTExxvYzU8I06DbSXgV7YOe5+Iee2IvXN+5gNfzgCn2sR5YX31nI9pl66d62yo
ZkSBwpDnxdHz1YHVKjjPZI51HXD4B7Akd8gw+TkR1tmPrX2I1IofR0tg5uT5oUaW
Af5varh5VtMMysSFq3vt
=1tdS
-----END PGP SIGNATURE-----

--NKIC9ADX7OWD81bxG34VwmTfNSiVBS9Ej--
