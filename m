Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 14:56:18 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:21681 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20033438AbYHUN4N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 14:56:13 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id C9471FE2DA4;
	Thu, 21 Aug 2008 15:56:12 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id B177B3EFACE;
	Thu, 21 Aug 2008 15:55:24 +0200 (CEST)
Received: from [192.168.10.137] (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 5813290004;
	Thu, 21 Aug 2008 15:55:24 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Yoichi Yuasa <tripeaks@gmail.com>
Subject: Re: [PATCH] cobalt: group UART definition into header
Date:	Thu, 21 Aug 2008 15:55:12 +0200
User-Agent: KMail/1.9.9
Cc:	"linux-mips" <linux-mips@linux-mips.org>, ralf@linux-mips.org
References: <200808211303.44865.florian@openwrt.org> <48ad7195.c505be0a.3500.4a15@mx.google.com>
In-Reply-To: <48ad7195.c505be0a.3500.4a15@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1269512.TutHpDuxjy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200808211555.14603.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: B177B3EFACE.AAC3F
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart1269512.TutHpDuxjy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Le Thursday 21 August 2008 15:45:52 Yoichi Yuasa, vous avez =E9crit=A0:
> NAK
>
> This value is only used in serial.c.
> Please define in serial.c.

console.c also uses it, which was the rationale for my patch.

--nextPart1269512.TutHpDuxjy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAkitc8AACgkQlyvkmBGtjyYezACYzwnJNFLlTJuxT8RnkbVxl8Ft
QQCgnTnKHE9zqBK0psnx7E9NdwOv72A=
=qgf6
-----END PGP SIGNATURE-----

--nextPart1269512.TutHpDuxjy--
