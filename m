Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 10:18:21 +0100 (BST)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:58897 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8226646AbVGOJR4>;
	Fri, 15 Jul 2005 10:17:56 +0100
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Fri, 15 Jul 2005 11:19:07 +0200
From:	Bruno Randolf <bruno.randolf@4g-systems.biz>
To:	jaypee@hotpop.com
Subject: Re: Au1550 ethernet throughput low
Date:	Fri, 15 Jul 2005 11:17:44 +0200
User-Agent: KMail/1.8.1
Cc:	Clem Taylor <clem.taylor@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
References: <1121270402l.7656l.3l@cavan> <ecb4efd1050714171318ce81aa@mail.gmail.com> <1121415711l.5178l.3l@cavan>
In-Reply-To: <1121415711l.5178l.3l@cavan>
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2206017.K2ni6TNPXm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507151117.49012.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart2206017.K2ni6TNPXm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 15 July 2005 10:21, jaypee@hotpop.com wrote:
> Yours is using ~30% cpu to send 100Mbps.
> Mine is using 100% to send 66Mbps.

i remember that ethernet thruput dropped from nearly 100Mbps to about=20
60-70Mbps on our Au1500 based board, when we enabled CONFIG_NONCOHERENT_IO.=
=2E.

bruno

--nextPart2206017.K2ni6TNPXm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1388fg2jtUL97G4RAiD2AKCvT11QQLax1XXT5olChEol3raS1QCfU8WT
AjB/tuW/zyzA28M9LA+ovEQ=
=F5l0
-----END PGP SIGNATURE-----

--nextPart2206017.K2ni6TNPXm--
