Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2005 09:40:05 +0100 (BST)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:23818 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225935AbVESIjs>;
	Thu, 19 May 2005 09:39:48 +0100
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Thu, 19 May 2005 10:39:35 +0200
From:	Bruno Randolf <bruno.randolf@4g-systems.biz>
To:	=?iso-8859-1?q?Ren=E9_Schouten?= <reneschouten@seldi.nl>
Subject: Re: compiling pcmcia utils for mips
Date:	Thu, 19 May 2005 10:39:25 +0200
User-Agent: KMail/1.7.2
References: <002901c55c4a$2030ede0$0a21a8c0@Rene>
In-Reply-To: <002901c55c4a$2030ede0$0a21a8c0@Rene>
Cc:	linux-mips@linux-mips.org
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1406222.oERCYD85rN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505191039.29859.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart1406222.oERCYD85rN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi rene!

you could check how it is done in openembedded:

http://openembedded.bkbits.net:8080/openembedded/src/packages/pcmcia-cs?nav=
=3Dindex.html|
src/.|src/packages

this one works for me.

bruno

On Thursday 19 May 2005 10:09, you wrote:
> Hi,
>
> I want to enable pcmcia on a mips32 processor
>
> I do have everything exept the cardmgr and cardctl programs that should be
> in the /sbin directory
>
> I downloaded the pcmcia-cs-3.2.8.tar.tar., and i'm able to compile it with
> the standard compiler, but i'm not able to build "cardctl" and "cardmgr"
> with the crosscomipler.
>
> My question: Can somebody give a link on where i can download the 2 files
> already compiled, or tell me what to change in the
> "pcmcia-cs-3.2.8.tar.tar" files for only compiling the two utilitis with a
> cross compiler?
>
> Ren=E9

--nextPart1406222.oERCYD85rN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCjFDBfg2jtUL97G4RAo8aAJ0VEhnkzx++ydqyRWjCRNPA1BbfmwCeOl+u
Ar6uFfOKXuTF3pln8oLgD4I=
=IxvI
-----END PGP SIGNATURE-----

--nextPart1406222.oERCYD85rN--
