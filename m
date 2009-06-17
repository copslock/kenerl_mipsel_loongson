Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 21:37:16 +0200 (CEST)
Received: from sitar.i-cable.com ([203.83.115.100]:60536 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S1492005AbZFQThK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 21:37:10 +0200
Received: (qmail 28392 invoked by uid 508); 17 Jun 2009 19:35:35 -0000
Received: from 203.83.114.121 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.086237 secs); 17 Jun 2009 19:35:35 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 17 Jun 2009 19:35:35 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n5HJZZLl018395;
	Thu, 18 Jun 2009 03:35:35 +0800 (HKT)
Date:	Thu, 18 Jun 2009 03:35:15 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	linux-mips@linux-mips.org, manuel.lauss@gmail.com
Subject: Re: [PATCH v2] -git compile fixes for MIPS
Message-ID: <20090617193515.GT9611@adriano.hkcable.com.hk>
Mail-Followup-To: Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-mips@linux-mips.org, manuel.lauss@gmail.com
References: <1245266590-31999-1-git-send-email-r0bertz@gentoo.org> <f861ec6f0906171231o1e5e4b1ei5525dcf5180127ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pd495SECmvzXpBRb"
Content-Disposition: inline
In-Reply-To: <f861ec6f0906171231o1e5e4b1ei5525dcf5180127ac@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--pd495SECmvzXpBRb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21:31 Wed 17 Jun     , Manuel Lauss wrote:
> On Wed, Jun 17, 2009 at 9:23 PM, Zhang Le<r0bertz@gentoo.org> wrote:
>=20
> > =C2=A0CC =C2=A0 =C2=A0 =C2=A0arch/mips/kernel/traps.o
> > cc1: warnings being treated as errors
> > /home/zhangle/linux/arch/mips/kernel/traps.c: In function =E2=80=98set_=
uncached_handler=E2=80=99:
> > /home/zhangle/linux/arch/mips/kernel/traps.c:1604: error: format not a =
string literal and no format arguments
>=20
> This one is caused by one of the Gentoo patches to GCC
> (10-format-string-security patch),
> I usually remove this patch when building GCC to avoid these stupid
> compile failures ;-)

Ah, thanks for telling me this.
Maybe I should enable "vanilla" USE flag.
:)

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--pd495SECmvzXpBRb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAko5RXMACgkQvFHICB5OKXO1uACfbNPG362gWIwdllq+ETNwaghT
CQcAn2AtJdd1oBg+X6diMUVgH+Uas61R
=qhn8
-----END PGP SIGNATURE-----

--pd495SECmvzXpBRb--
