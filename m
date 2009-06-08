Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 20:23:46 +0100 (WEST)
Received: from sitar.i-cable.com ([203.83.115.100]:39224 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20023654AbZFHTX2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2009 20:23:28 +0100
Received: (qmail 13970 invoked by uid 508); 8 Jun 2009 19:23:20 -0000
Received: from 203.83.114.122 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.09957 secs); 08 Jun 2009 19:23:20 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 8 Jun 2009 19:23:20 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n58JNHRb004345;
	Tue, 9 Jun 2009 03:23:17 +0800 (CST)
Date:	Tue, 9 Jun 2009 03:23:10 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v3 00/25] loongson-based machines support
Message-ID: <20090608192309.GE16785@adriano.hkcable.com.hk>
Mail-Followup-To: Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Yan Hua <yanh@lemote.com>, Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>
References: <cover.1244119295.git.wuzj@lemote.com> <20090608163821.GC16785@adriano.hkcable.com.hk> <1244485107.26004.164.camel@falcon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <1244485107.26004.164.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02:18 Tue 09 Jun     , Wu Zhangjin wrote:
> > >   change the naming methods
> >=20
> > In this patch, I found function get_system_type() still returns wrong n=
ame,
> > "lemote-fulong". In later patches, I found this string was changed to a=
 macro,
> > MACH_NAME. Then, the function becomes more complicated and/or sophistic=
ated,
> > because of the addition of machname array.
>=20
> the MACH_NAME macro method is originally picked from lm2e-fixes branch
> of Philippe's git://git.linux-cisco.org/linux-mips.git, this method is
> used to share the get_system_type() function between different machines.
>=20
> and the machtype with machname array is only used to share the same
> kernel image file between yeeloong-7inch(menglong?) and yeeloong-8.9inch
> source code.
>=20
> I think it will be "bad" to add a new kernel option named MENGLONG or
> something else, and add a new yeeloong-7inch directory in
> arch/mips/loongson/ for it, because the difference between
> yeeloong-7inch and yeeloong-8.0 inch is very small(the shutdown logic
> and screen size). and also, simply add two new kernel options like
> YEELOONG-7INCH and YEELOONG-89INCH with #ifdef..#else...#endif is also
> not that good, is that?
>=20
> so, i just added a machtype kernel command line(perhaps we can use the
> systype or machtype variable in pmon instead as Arnaud Patard
> suggested). and perhaps this machtype can also be used to share the the
> kernel image file among the future machines.
>=20
> what about your suggestion here? is there another good solution? or just
> keep it simple: just define the get_system_type() function for every
> machine and add a new kernel option for yeeloong-7inch?

Sorry for the confusion caused. However actually my point here has nothing =
to
do with the implementation of get_system_type().

I just hope it appears once and only once in the series of patches. I hope =
this
time it is clearer. :)

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkotZR0ACgkQvFHICB5OKXP+/gCcCR6940bwGW9JpZj+5FqbbgLm
MwUAn3grcmnz4nbavnkwOrLpkSBdlHW6
=zJNR
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
