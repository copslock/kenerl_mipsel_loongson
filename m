Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 18:36:25 +0200 (CEST)
Received: from pyxis.i-cable.com ([203.83.115.105]:37837 "HELO
	pyxis.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S1491932AbZFKQgT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2009 18:36:19 +0200
Received: (qmail 628 invoked by uid 104); 11 Jun 2009 11:09:33 -0000
Received: from 203.83.114.121 by pyxis (envelope-from <robert.zhangle@gmail.com>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.191432 secs); 11 Jun 2009 11:09:33 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 11 Jun 2009 11:09:32 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n5BB9PPK015339;
	Thu, 11 Jun 2009 19:09:25 +0800 (HKT)
Date:	Thu, 11 Jun 2009 19:09:14 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: Re: [loongson-dev] Re: [loongson-PATCH-v3 17/25] add a machtype
	kernel command line argument
Message-ID: <20090611110914.GB20906@adriano.hkcable.com.hk>
Mail-Followup-To: wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>, Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
References: <cover.1244120575.git.wuzj@lemote.com> <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com> <20090610154032.GB21877@adriano.hkcable.com.hk> <20090610203123.GA20906@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20090610203123.GA20906@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04:31 Thu 11 Jun     , Zhang Le wrote:

[...]

>=20
> diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/co=
mmon/machtype.c
> index d469dc7..34417cf 100644
> --- a/arch/mips/loongson/common/machtype.c
> +++ b/arch/mips/loongson/common/machtype.c

[...]

> -static __init int machname_setup(char *str)
> +static __init int machtype_setup(char *str)

[...]

> -	for (index =3D 0;
> -	     index < MACHTYPE_TOTAL;
> -	     index++) {
> -		if (strstr(str, machname[index]) !=3D NULL) {
> -			mips_machtype =3D index;
> -			return 0;
> +	for (; system_types[machtype]; machtype++)
> +		if (strstr(str, system_types[machtype])) {

There is a problem here.

Because I have used "inches" instead of "inch" in system_types, if you insi=
st
on using "inch" when passing value to the machtype kernel parameter, this
strstr() call's two parameters should be swapped:

             if (strstr(system_types[machtype], str)) {


> +			mips_machtype =3D machtype;
> +			break;
>  		}
> -	}
> -	return -1;
> +	return 0;
>  }
> =20
> -__setup("machtype=3D", machname_setup);
> +__setup("machtype=3D", machtype_setup);


--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkow5dkACgkQvFHICB5OKXMXGgCfeh8j713jTbDT8HmQDq25jShV
9rsAn1z4EiORJ8KUK7gzG+/siCQvtXzu
=hjzj
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
