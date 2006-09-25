Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 07:12:33 +0100 (BST)
Received: from smtp2.int-evry.fr ([157.159.10.45]:52898 "EHLO
	smtp2.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20037809AbWIYGMa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 07:12:30 +0100
Received: from devsta.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 828BE2FD40;
	Mon, 25 Sep 2006 08:12:20 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	william_lei@ali.com.tw
Subject: Re: How to emulate lw/sw instruction by lb/sb instruction
Date:	Mon, 25 Sep 2006 08:03:08 +0200
User-Agent: KMail/1.9.4
Cc:	linux-mips@linux-mips.org
References: <OF041A6F77.FC0AA7D2-ON482571F4.00036CCB-482571F4.0003EC56@LocalDomain>
In-Reply-To: <OF041A6F77.FC0AA7D2-ON482571F4.00036CCB-482571F4.0003EC56@LocalDomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1198555.IEtjpEj7bK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609250803.12879.florian.fainelli@int-evry.fr>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-MCPCheck: 
X-INT-MailScanner-SpamCheck: 
X-MailScanner-From: florian.fainelli@int-evry.fr
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart1198555.IEtjpEj7bK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi William,

As far as I know, there is the nonmips project [1] which is providing a=20
toolchain for mips clones such as the Lexra 5280 we can find in Realtek 865=
x=20
SoC for instance. This SoC does not have lw/sw instruction set.

The Realtek 8181 project also provide a patch to emulate those instructions=
 by=20
the kernel, see [2].

Hope this helps !

[1] http://nonmips.sourceforge.net/
[2] http://rtl8181.sourceforge.net/


Le lundi 25 septembre 2006 02:41, william_lei@ali.com.tw a =E9crit=A0:
> Dear all
>       Could someone tell me how to modify GCC as titled?because we have m=
et
> problem while porting some middleware,which will generate some lw/sw
> instruction to unaligned address,so I would modify GCC to not generate
> lw/sw instructions for this pieces code.
> Regards
> William Lei
>
> ************* Email Confidentiality Notice ********************
>
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be convey=
ed
> only to the designated recipient(s). Any use, dissemination, distribution,
> printing, retaining or copying of this e-mail (including its attachments)
> by unintended recipient(s) is strictly prohibited and may be unlawful. If
> you are not an intended recipient of this e-mail, or believe that you have
> received this e-mail in error, please notify the sender immediately (by
> replying to this e-mail), delete any and all copies of this e-mail
> (including any attachments) from your system, and do not disclose the
> content of this e-mail to any other person. Thank you!

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
Institut National des T=E9l=E9communications
http://www.int-evry.fr/telecomint
=2D--------------------------------------------

--nextPart1198555.IEtjpEj7bK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFF3EgQ/Yr6D8A81kRAgkAAKC1m6BA97PGmE3AK+HLIbJUoPB5aQCfQwnV
K7IyvUWbw29Bu2TwTy77ZTc=
=I4Go
-----END PGP SIGNATURE-----

--nextPart1198555.IEtjpEj7bK--
