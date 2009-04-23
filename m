Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 13:51:52 +0100 (BST)
Received: from apollo.i-cable.com ([203.83.115.103]:2710 "HELO
	apollo.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20021887AbZDWMvn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 13:51:43 +0100
Received: (qmail 15445 invoked by uid 508); 23 Apr 2009 12:51:30 -0000
Received: from 203.83.114.121 by apollo (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.230722 secs); 23 Apr 2009 12:51:30 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 23 Apr 2009 12:51:30 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n3NCp3Nu024446;
	Thu, 23 Apr 2009 20:51:14 +0800 (HKT)
Date:	Thu, 23 Apr 2009 20:50:56 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Philippe Vachon <philippe@cowpig.ca>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
Message-ID: <20090423125055.GG6707@adriano.hkcable.com.hk>
Mail-Followup-To: Philippe Vachon <philippe@cowpig.ca>,
	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
References: <20090422063747.GA2009@cowpig.ca> <m363gxgic8.fsf@anduin.mandriva.com> <20090422161631.GA2317@cowpig.ca> <m3skjzg4mk.fsf@anduin.mandriva.com> <20090423100312.GC6138@cowpig.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <20090423100312.GC6138@cowpig.ca>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06:03 Thu 23 Apr     , Philippe Vachon wrote:
> I've laid out the directories as follows:
>=20
> arch/mips/
> 	+- loongson/
> 	|	+- common/ /* common code */
> 	|	+- gdium/    /* all the other directories are for */
> 	|	+- fulong-2e /* particular platforms */

Hi, Philippe,

Sorry for nitpicking, but fulong actually was a typo which slipped in someh=
ow.
The correct English name should be fuloong as shown here:
http://www.lemote.com/english/fuloong.html

Also please take a look at this:
http://www.linux-mips.org/archives/linux-mips/2009-03/msg00225.html

BTW, Thank you for hard work on this. I really hope loongson 2f's code woul=
d be
merged soon, and have all the loongson related code sorted out.

> 	|
> 	...
> 	+- include/asm/
> 		+- mach-loongson/=20
> 			/* platform-specific headers */
> 			+- fulong-2e/
> 			+- gdium/
>=20

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAknwZC8ACgkQvFHICB5OKXPEygCeKhnme11P88UM2aVRQnA8cEQL
kUQAoIXGYZ/h33o0zaHeNu+2LTZy90rS
=1LKJ
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
