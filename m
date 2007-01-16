Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 10:17:48 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:52904 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20051533AbXAPKRm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 10:17:42 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 45850D0E315;
	Tue, 16 Jan 2007 11:16:28 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	Peter Horton <phorton@bitbox.co.uk>
Subject: Re: [PATCH] Add support for Cobalt Server front LED
Date:	Tue, 16 Jan 2007 11:14:55 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org
References: <200701151936.57738.florian.fainelli@int-evry.fr> <45ACA08F.8000203@bitbox.co.uk>
In-Reply-To: <45ACA08F.8000203@bitbox.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4605224.VkHRzjHuEv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701161114.59117.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart4605224.VkHRzjHuEv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Peter,

The patch I resend last night is using COBALT_LED_PORT. Is there anything e=
lse=20
that needs to be changed ? Thank you in advance for your answer

Le mardi 16 janvier 2007 10:53, Peter Horton a =E9crit=A0:
> Florian Fainelli wrote:
> > This patch adds support for controlling the front LED on Cobalt Server.
> > It has been tested on Qube 2 with either no default trigger, or the
> > IDE-activity trigger. Both work fine. Please comment and test !
>
> Why did you add COBALT_LED_BASE when there was already a COBALT_LED_PORT
> define on the line above ?
>
> All your
>
> 	*(volatile uint8_t *) COBALT_LED_BASE =3D n;
>
> can be replaced by
>
> 	COBALT_LED_PORT =3D n;
>
> P.

=2D-=20
Cordialement, Florian Fainelli
=2D--------------------------------------------
5, rue Charles Fourier
Chambre 1202
91011 Evry
http://www.alphacore.net
(+33) 01 60 76 64 21
(+33) 06 09 02 64 95
=2D--------------------------------------------
Association MiNET
http://www.minet.net
=2D--------------------------------------------
Institut National des T=E9l=E9communication
http://www.int-evry.fr/telecomint
=2D--------------------------------------------

--nextPart4605224.VkHRzjHuEv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFrKWjQ/Yr6D8A81kRAtYHAJ9qGoB2LTukALRE59Ls/sUfDxPv6gCdH0Ht
psyALYY8wvhne5PW5XqUOKQ=
=6g0Q
-----END PGP SIGNATURE-----

--nextPart4605224.VkHRzjHuEv--
