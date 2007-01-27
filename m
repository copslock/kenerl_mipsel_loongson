Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2007 21:53:00 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:24760 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20037644AbXA0Vwz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jan 2007 21:52:55 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 7B0EB8D168F;
	Sat, 27 Jan 2007 22:50:58 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	"W.P." <laurentp@wp.pl>
Subject: Re: RTL-8186 follow-up
Date:	Sat, 27 Jan 2007 22:38:08 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org
References: <5C1FD43E5F1B824E83985A74F396286E041B10FB@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <200701271354.41905.florian.fainelli@int-evry.fr> <45BB8C5D.50405@wp.pl>
In-Reply-To: <45BB8C5D.50405@wp.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4757433.SZreyfRjZB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701272238.08482.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart4757433.SZreyfRjZB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Laurent,

Le samedi 27 janvier 2007 18:31, W.P. a =E9crit=A0:
> <cut>
> 1). I have added modules found in KERNEL_SRC/rtl8186 (that i wrote about
> in other post), to image, but trying to load them gives "unresolved
> symbol" errors:
>
> <example>
> # insmod ip_nat_l2tp
> Using /lib/modules/2.4.18-MIPS-01.00/ip_nat_l2tp.o
> insmod: unresolved symbol kmalloc
> insmod: unresolved symbol create_proc_entry
> insmod: unresolved symbol ip_nat_helper_register
> insmod: unresolved symbol ip_nat_helper_unregister
> insmod: unresolved symbol csum_partial
> insmod: unresolved symbol sprintf
> </example>

There might be version mismatch, or other modules to load before this one.=
=20
This can also be a kernel configuration problem, related to modules that ar=
e=20
expected to be in-kernel.

>
> This problem is very of interest, because there are modules for IP_SEC,
> and a module rtl8186 (NIC driver??) that is much SMALLER that module
> with the same name rtl8186 generated during kernel compilation. There is
> also module named wireless_ag_net.
>
> 2). Is there some possibility to "recover" using serial port if it
> happens to corrupt kernel to point to not have network access? (I mean
> NOT using JTAG).??

Well, unless you have erased the booloader, I think you should still be abl=
e=20
to reflash the device using bootloader commands, even via xmodem if the=20
loader allows it.

>
> 3). Florian, could you help me to "reverse engineer" Edimax-supplied
> firmware image? AFAIR it is composed of header, compressed vmlinux and
> compressed initrd. But how to find at what offset those images are?, and
> how are they compressed.

I think you should have a look at this page [1], where there are ressources=
 to=20
create custom rtl8181 firmwares.

>
> W.P.

[1] http://rtl8181.sourceforge.net/

=2D-=20
Regards, Florian

--nextPart4757433.SZreyfRjZB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFu8ZAQ/Yr6D8A81kRAhZPAJ0R51mLnjO8kslAUiQPuiTzYg15DQCglHNB
SEmKy85M/GJU0PQXccPaOdg=
=VUkk
-----END PGP SIGNATURE-----

--nextPart4757433.SZreyfRjZB--
