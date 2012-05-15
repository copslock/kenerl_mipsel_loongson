Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 12:47:48 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:25920 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903612Ab2EOKrf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 May 2012 12:47:35 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 15 May 2012 03:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="asc'?scan'208";a="140806055"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2012 03:47:27 -0700
Received: from [10.237.72.78] (sauron.fi.intel.com [10.237.72.78])
        by linux.intel.com (Postfix) with ESMTP id BE9576A4001;
        Tue, 15 May 2012 03:47:26 -0700 (PDT)
Message-ID: <1337079056.2528.158.camel@sauron.fi.intel.com>
Subject: Re: [RESEND PATCH V2 14/17] MTD: MIPS: lantiq: verify that the NOR
 interface is available on falcon soc
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org
Date:   Tue, 15 May 2012 13:50:56 +0300
In-Reply-To: <1337017363-14424-14-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
         <1337017363-14424-14-git-send-email-blogic@openwrt.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-yIDHwD/xOLPxK6Aa6Kas"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-yIDHwD/xOLPxK6Aa6Kas
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-14 at 19:42 +0200, John Crispin wrote:
> When running on a FALC-ON SoC, we need to check the bootstrap options to =
see
> if NOR is available.
>=20
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mtd@lists.infradead.org

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

--=20
Best Regards,
Artem Bityutskiy

--=-yIDHwD/xOLPxK6Aa6Kas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPsjUQAAoJECmIfjd9wqK09MkP/ROD0uVJvW4K4YbZmJtxuMvj
z9iJDqNSxDXxVofo6ykPrL3RjedwI0iYnu1A9cN2X3tzSu5DDzO8+xJ3JeENcuMR
x7prXmzaKViUtX9LtnaKXR/tGcJ9CWL5NqiqBo3ltrjsBWsehwW5RKFNLJV/2LJD
hes7Mytr6ua/3pwpuLEJMKhuLvH7fXWTa8Hhswoh1sBRT//qh1w1Ch1kviXdcvZL
2s/pBAdksnwmiQ9Z1I+b9SXEI8xbZ5bcolEeMXZn1tO1QHXf4+Ai3pDseqQm1PGh
HC6Co8D6cwHLhu7ZpcTaz/OE9rC7UKa5IunNgINeVvMeQskOnhwfUsp22GUt0Dcs
PeVwJxQcSx1EQWOojrPVQsoeXQP+NARQqswQkeFlzwjzW7VhizjanPi8JVT+evnG
nHczq6non40kPM6mQbFOSM4s+xk9HxmpWyqbFvk5tSI2LBMrUjCTYJNU/1sra1rJ
Th5NGz97NhPJcUbvEhmMDMTjw42eEJnA0iGbYTwD0EJItrzWWYolie1YJ/RrAaRu
H2A9kpUcXPqcQq6xfAERoNcd7YGJda6YqZK6NjX0i82anhiZi6WTGWfb/Xq8z7R0
X0X/OtRgSCKcwRDObJ4ItaWVTco7MDqjcmNs3lFnfKkIza1QmD7mAC1r7OmSmX3p
i9T0HcTnIGuCyVzm4AK6
=8K2j
-----END PGP SIGNATURE-----

--=-yIDHwD/xOLPxK6Aa6Kas--
