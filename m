Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2008 19:16:18 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:2777 "EHLO smtp4.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20025776AbYFQSQL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2008 19:16:11 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id D28E3FE41E4;
	Tue, 17 Jun 2008 20:16:05 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 359AD3EDEFE;
	Tue, 17 Jun 2008 20:15:51 +0200 (CEST)
Received: from florian.lan.tmplab.org (fbx.tmplab.org [82.228.39.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id DCD31902AC;
	Tue, 17 Jun 2008 20:15:50 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	supinlick@yahoo.com
Subject: Re: Linux Boot RAM Determination
Date:	Tue, 17 Jun 2008 20:15:43 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <368058.32705.qm@web51908.mail.re2.yahoo.com>
In-Reply-To: <368058.32705.qm@web51908.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart101153043.LDCPK54xd5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200806172015.48426.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 359AD3EDEFE.43E4D
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart101153043.LDCPK54xd5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Sean,

Le Tuesday 17 June 2008 19:45:01 Sean Parker, vous avez =E9crit=A0:
> Hello -
>
>   We're developing a PMC-Sierra RM9000 system, and when Linux boots it
> seems to only see 256M RAM (cat /proc/meminfo -> MemTotal=3D256M), despit=
e a
> Crucial 1GB double-sided SODIMM card.
>
>   The boot code is PMON, and it recognizes all 1GB (dimm0:2 Ranks each
> 512MB) and prints as much when it's done.
>
>   Is there a setting in the Linux source (we're using a single elf image
> with ramfs integrated) that might be limiting the MemTotal/RAM size found
> by Linux? I couldn't find anywhere in the Linux code (patched by PMC) that
> mentions reading the DDR DCR's to inspect what the configured RAM
> sizes/offsets are. Any ideas?

Did you check the code which reserves memory for ther kernel ? Most boards=
=20
will set this in either prom or setup code :

pmc-sierra/msp71xx/msp_prom.c:          add_memory_region(base, size, type);
pmc-sierra/yosemite/setup.c:    add_memory_region(0x00000000, 0x10000000,=20
BOOT_MEM_RAM);

If your code is based on yosemite, it seems like it should get the memsize=
=20
parameter from the bootloader, instead of hardcoding it to 256Mb like it=20
currently does.

Hope it helps you.
=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart101153043.LDCPK54xd5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIV/9Umx9n1G/316sRAsnnAKCn/5X3j3PwVXACovssJjyJHxZxEgCcD3mw
h2inO4JC7MQiwK5jkUXabnY=
=1FOB
-----END PGP SIGNATURE-----

--nextPart101153043.LDCPK54xd5--
