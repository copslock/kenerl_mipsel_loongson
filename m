Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 18:32:42 +0000 (GMT)
Received: from smtp4.int-evry.fr ([157.159.10.71]:40860 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20030687AbYBGScd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Feb 2008 18:32:33 +0000
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 57850350AD0
	for <linux-mips@linux-mips.org>; Thu,  7 Feb 2008 19:32:28 +0100 (CET)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 6F89C3ED168
	for <linux-mips@linux-mips.org>; Thu,  7 Feb 2008 19:32:26 +0100 (CET)
Received: from ibook (unknown [77.192.17.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 57A6D8D16BA
	for <linux-mips@linux-mips.org>; Thu,  7 Feb 2008 19:32:26 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org
Subject: early_ioremap for MIPS
Date:	Thu, 7 Feb 2008 19:32:21 +0100
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1331865.8f1bbS9ugm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200802071932.23965.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart1331865.8f1bbS9ugm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi list,

Is there any need for early_ioremap on MIPS ? Seems like only x86_64 is=20
implementing it for now.

Thank you for your answer.
=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart1331865.8f1bbS9ugm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHq063mx9n1G/316sRAk2tAJ47if9r67hp57CfcH1HWFfOOzyaEQCgxYsW
zj7v8YvkuSJQLCp9fmpPW4Y=
=1vBs
-----END PGP SIGNATURE-----

--nextPart1331865.8f1bbS9ugm--
