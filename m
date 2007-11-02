Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 12:32:34 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:16356 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20030379AbXKBMcY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Nov 2007 12:32:24 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 04AE2200A231;
	Fri,  2 Nov 2007 13:31:54 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17478-01-12; Fri, 2 Nov 2007 13:31:53 +0100 (CET)
Received: from [10.101.1.157] (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 2A114200A22C;
	Fri,  2 Nov 2007 13:31:50 +0100 (CET)
In-Reply-To: <335463.37228.qm@web8414.mail.in.yahoo.com>
References: <335463.37228.qm@web8414.mail.in.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-951137529"
Message-Id: <CD4B7E02-9995-4496-8031-4804E268B9D6@27m.se>
Cc:	uclibc@uclibc.org, linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	buildroot@uclibc.org
Content-Transfer-Encoding: 7bit
From:	Markus Gothe <markus.gothe@27m.se>
Subject: Re: NPTL support
Date:	Fri, 2 Nov 2007 13:31:41 +0100
To:	veerasena reddy <veerasena_b@yahoo.co.in>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-951137529
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

You'll have to use the uClibc-nptl branch on their svn. In 0.9.28, no.

//Markus

On 2 Nov 2007, at 06:03, veerasena reddy wrote:

> Hi,
>
> I am trying to build the toolchain for MIPS processor using buildroot.
> I am using gcc version of 3.4.3, binutils-2.15, uclibc-0.9.28 and =20
> linux-2.6.18.8 kernel.
>
> Basically i need to enable NPTL feature support in my toolchain.
> does uclibc-0.9.28 has the support for NPTL?
> If not, how can i get it enabled for my above build configuration?
>
> I see there is separate branch "uclibc-nptl" in uclibc.
> Do i need to use this (uclibc-nptl) to meet my requirement?
>
> Could you please suggest me right approach to succssfully enable NPTL?
>
> Thanks in advance.
>
> Regards,
> Veerasena.
>
>
>       Why delete messages? Unlimited storage is just a click away. =20
> Go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/=20
> tools-08.html
>
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com



--Apple-Mail-1-951137529
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHKxiu6I0XmJx2NrwRAmL9AKC+UJvmi+faIw8jv2mTgX02lQ0SVQCgojMj
eb6d+5dvclZWIzioxljUx9A=
=PoSc
-----END PGP SIGNATURE-----

--Apple-Mail-1-951137529--
