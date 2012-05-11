Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 16:13:44 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:28505 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903558Ab2EKONk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 May 2012 16:13:40 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 11 May 2012 07:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="asc'?scan'208";a="141889235"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by azsmga001.ch.intel.com with ESMTP; 11 May 2012 07:13:33 -0700
Received: from [10.237.72.159] (sauron.fi.intel.com [10.237.72.159])
        by linux.intel.com (Postfix) with ESMTP id 074396A4007;
        Fri, 11 May 2012 07:13:31 -0700 (PDT)
Message-ID: <1336745818.2625.83.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 12/14] MTD: MIPS: lantiq: implement OF support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org
Date:   Fri, 11 May 2012 17:16:58 +0300
In-Reply-To: <4FAD1C6D.5080701@openwrt.org>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>
                 <1336133919-26525-12-git-send-email-blogic@openwrt.org>
         <1336745193.2625.81.camel@sauron.fi.intel.com>
         <4FAD1C6D.5080701@openwrt.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-zXnWHEqmyreC7CpAjN4H"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-zXnWHEqmyreC7CpAjN4H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-11 at 16:04 +0200, John Crispin wrote:
> The lantiq platform selects USE_OF
>=20
> config USE_OF
>         bool "Flattened Device Tree support"
>         select OF
>         select OF_EARLY_FLATTREE
>         select IRQ_DOMAIN
>         help
>           Include support for flattened device tree machine descriptions.

OK.

> Do i still need an explicit dependency on OF in this case ?

Not sure, but probably not.

--=20
Best Regards,
Artem Bityutskiy

--=-zXnWHEqmyreC7CpAjN4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPrR9aAAoJECmIfjd9wqK0JtAQAMVj4D8Ychz3AVWasMykpFe5
YWGFxRMT6Sp0QF5ABDnsvf9fG0waXC8kF+HxO9hsM+bp/1kom0FO5QN5ZZ8oxZS1
Ik8v81GlKiWqQdWXKCODIlfRVwtL0jqs0g2QTCyEXympSnDJM2SAGZjhDbbq4GkM
36ZxInqFIvmmN8mUtvRvbKv39AHkxljk0+LJriVAPDR1xUnSD0lmbajVqMoKqApm
gPsmAFc0oWj2b5dwu5VmCpj0VMl2MPGY47ygy9j/xFE4+NTYutnQiauuZ2N+9f3Q
BiRb3su1dFl/uro8r3glXcNku9Rf5NuzLMrUvkvjEJf1uXTOjmvBdH94jDXlVTpC
rEKN12HWfPx6/nNEobvWQaaPdTRzzn/8e+TgFq2zNIkqmw7JN9oZa7XFcCXv4Rbx
3jJa3H6ucWIPuaD4VTzk0oW0FUAQtO4cnHA06KCqVcPvzcpsPxTyZCrmZptKCm8x
zfwE1iR2OoEZloKBBGiaa9k27RIUsoKnR4cOazyhB/7KotcI0LN616W+9t+Hp+qz
b8+bPMZu1jAdYAFq24AGEUxrm/F+v81zzRlYW2hEfUVN3bfG58OrswEES9F3cumi
QEQ5JyRnMhy9J2t+7AXCybQ7Lpd04BG9zHRhjN1xWjOzEBIXC6cJm5UoVb8Ts3Jc
mnYupoRZ4QgVcQouzoWK
=VoI7
-----END PGP SIGNATURE-----

--=-zXnWHEqmyreC7CpAjN4H--
