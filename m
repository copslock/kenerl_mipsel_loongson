Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 19:50:43 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:18327 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S28578165AbYCUTuk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 19:50:40 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id DC7AC200A21D;
	Fri, 21 Mar 2008 20:50:38 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 14608-01-8; Fri, 21 Mar 2008 20:50:38 +0100 (CET)
Received: from joyce.lan (cust.fiber-lan.vnet.lk.85.194.49.173.stunet.se [85.194.49.173])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 10E04200A1F0;
	Fri, 21 Mar 2008 20:50:38 +0100 (CET)
Cc:	linux-mips@linux-mips.org
Message-Id: <583248BA-1B57-4B3D-94E7-75F32ED951A1@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	LD <memorylost@tin.it>
In-Reply-To: <47E3E0C2.9070404@tin.it>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9-188564734"
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: AU1100 2.4.21-pre4 flash disks problems
Date:	Fri, 21 Mar 2008 20:50:31 +0100
References: <47E3E0C2.9070404@tin.it>
X-Pgp-Agent: GPGMail d51 (Leopard)
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.919.2)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-9-188564734
Content-Type: multipart/alternative; boundary=Apple-Mail-8-188564683


--Apple-Mail-8-188564683
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Have you tried with 2.4.21 (not pre4), if not start there then try =20
2.4.22 and see if it works. The USB-layer in 2.4 around that time =20
being was pretty immature IIRC.

//Markus

On 21 Mar 2008, at 17:22, LD wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi all,
> I am working on an AU1100 system, using a 2.4.21-pre4 kernel. =20
> Filesystem
> is jffs2, uclibc libraries.
>
> I have a couple of problems with USB flash disk handling:
>
> 1) it seems that my system does not "see" disks larger than 512 MB. =20=

> 1GB
> disks or more cannot be mounted. This is becoming a problem because
> 512MB disks are going out of the market.
>
> 2) Given two flash disks of different sizes (for example: one 128 MB,
> one 512 MB), if I mount/umount one of them -> I cannot then mount the
> other and vice versa.
> Example:
>
> - - mount the 128 MB one, then umount. Try to mount the 512MB ->fail.
> - - reset the device
> - - mount the 512MB device, ok. Umount. Try to mount the 128MB -> =20
> fail.
>
> Disks are vfat formatted ; did not try with other filesystem types.
>
> Tried to use a 2.6.x kernel and no problem ; I am planning to switch =20=

> all
> to 2.6.x kernel, but in this moment for me is better (if possible)
> fixing this problem, because I have a number of applications and =20
> drivers
> running on 2.4.21 and the switching to 2.6.x means revising and
> re-testing a lot of things.
>
> Back to 2.4.21...
> If I try to dmesg I see a "Partition check:" message missing when I =20=

> put
> in the second disk ; I am investigating on this (maybe some piece of
> software is called checking for partitions on the first disk but is =20=

> not
> called again when I change disk type).
>
> Any suggestions are welcome,
>
> best regards
>
> Lucio Dona'
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFH4+DCvxHCsvXy9okRApudAJwON54jwrtPtgKd2zImEjmYbPbpRwCgsnWr
> 4nWlOjZbQtNDzqFUcfRRltI=3D
> =3Dvh3N
> -----END PGP SIGNATURE-----
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com




--Apple-Mail-8-188564683
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">Have you tried with 2.4.21 (not =
pre4), if not start there then try 2.4.22 and see if it works. The =
USB-layer in 2.4 around that time being was pretty immature =
IIRC.<div><br></div><div>//Markus</div><div><br><div><html>On 21 Mar =
2008, at 17:22, LD wrote:</html><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite">-----BEGIN =
PGP SIGNED MESSAGE-----<br>Hash: SHA1<br><br>Hi all,<br>I am working on =
an AU1100 system, using a 2.4.21-pre4 kernel. Filesystem<br>is jffs2, =
uclibc libraries.<br><br>I have a couple of problems with USB flash disk =
handling:<br><br>1) it seems that my system does not "see" disks larger =
than 512 MB. 1GB<br>disks or more cannot be mounted. This is becoming a =
problem because<br>512MB disks are going out of the market.<br><br>2) =
Given two flash disks of different sizes (for example: one 128 =
MB,<br>one 512 MB), if I mount/umount one of them -> I cannot then mount =
the<br>other and vice versa.<br>Example:<br><br>- - mount the 128 MB =
one, then umount. Try to mount the 512MB ->fail.<br>- - reset the =
device<br>- - mount the 512MB device, ok. Umount. Try to mount the 128MB =
-> fail.<br><br>Disks are vfat formatted ; did not try with other =
filesystem types.<br><br>Tried to use a 2.6.x kernel and no problem ; I =
am planning to switch all<br>to 2.6.x kernel, but in this moment for me =
is better (if possible)<br>fixing this problem, because I have a number =
of applications and drivers<br>running on 2.4.21 and the switching to =
2.6.x means revising and<br>re-testing a lot of things.<br><br>Back to =
2.4.21...<br>If I try to dmesg I see a "Partition check:" message =
missing when I put<br>in the second disk ; I am investigating on this =
(maybe some piece of<br>software is called checking for partitions on =
the first disk but is not<br>called again when I change disk =
type).<br><br>Any suggestions are welcome,<br><br>best =
regards<br><br>Lucio Dona'<br>-----BEGIN PGP SIGNATURE-----<br>Version: =
GnuPG v1.4.6 (GNU/Linux)<br>Comment: Using GnuPG with Mozilla - <a =
href=3D"http://enigmail.mozdev.org">http://enigmail.mozdev.org</a><br><br>=
iD8DBQFH4+DCvxHCsvXy9okRApudAJwON54jwrtPtgKd2zImEjmYbPbpRwCgsnWr<br>4nWlOj=
ZbQtNDzqFUcfRRltI=3D<br>=3Dvh3N<br>-----END PGP =
SIGNATURE-----<br><br></blockquote></div><br><div =
apple-content-edited=3D"true"> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; -webkit-border-horizontal-spacing: =
0px; -webkit-border-vertical-spacing: 0px; color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; -webkit-text-decorations-in-effect: none; =
text-indent: 0px; -webkit-text-size-adjust: auto; text-transform: none; =
orphans: 2; white-space: normal; widows: 2; word-spacing: 0px; "><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">_______________________________________</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Mr Markus =
Gothe</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Software Engineer</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Phone: =
+46 (0)13 21 81 20 (ext. 1046)</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Fax: +46 =
(0)13 21 21 15</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Mobile: +46 (0)70 348 44 =
35</div><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: =
0px; margin-left: 0px; ">Diskettgatan 11, SE-583 35 Link=F6ping, =
Sweden</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><a =
href=3D"http://www.27m.com">www.27m.com</a></div></div><br =
class=3D"Apple-interchange-newline"></span></div></span><br =
class=3D"Apple-interchange-newline"> </div><br></div></body></html>=

--Apple-Mail-8-188564683--

--Apple-Mail-9-188564734
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkfkEYcACgkQ6I0XmJx2NrxMfQCfT125zBUDBBYUeoF1MI1ezjN1
9FkAn1JMsVQi1za9JbNf1RIOBAmf9iJp
=HeFH
-----END PGP SIGNATURE-----

--Apple-Mail-9-188564734--
