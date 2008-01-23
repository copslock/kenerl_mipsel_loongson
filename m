Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2008 23:50:54 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:40082 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S28593274AbYAWXup (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jan 2008 23:50:45 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C0955200A205;
	Thu, 24 Jan 2008 00:50:31 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 11619-01-37; Thu, 24 Jan 2008 00:50:31 +0100 (CET)
Received: from [192.168.0.2] (cust.fiber-lan.vnet.lk.85.194.49.173.stunet.se [85.194.49.173])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 22ABC200A1FF;
	Thu, 24 Jan 2008 00:50:31 +0100 (CET)
Message-Id: <A3799ADB-ED5E-48F8-A352-912F7ED95EC0@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	linux-mips <linux-mips@linux-mips.org>, gregkh@suse.de
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-18--513273905"
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Embedded NXP USB controllers, helped offered... Fixing those BE-probs etc... :)
Date:	Thu, 24 Jan 2008 00:50:25 +0100
X-Pgp-Agent: GPGMail d51 (Leopard)
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.915)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-18--513273905
Content-Type: multipart/alternative; boundary=Apple-Mail-17--513273996


--Apple-Mail-17--513273996
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

For those running MIPS-EB and who needs help for fixing issues with =20
the ISP1761, driver I can point out and send you a patch. Today I =20
found the GPL'ed USB gadget drivers (for device/peripheral) as well =20
(NXP had hidden them under a carpet in a submarine near the north-=20
pole). Send a mail if you're interested. I probably will have to =20
polish them at work before I can release it to the public.

I think this is a concern of mine since it might go into the mainline-=20=

kernel pretty soon and not only the blackfin-branch. It's pretty FUBAR =20=

on BE-systems in it's initial state...

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com




--Apple-Mail-17--513273996
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">For those running MIPS-EB and =
who needs help for fixing issues with the ISP1761, driver I can point =
out and send you a patch. Today I found the GPL'ed USB gadget drivers =
(for device/peripheral)&nbsp;as well (NXP had hidden them under a carpet =
in a submarine near the&nbsp;north-pole). Send a mail if you're =
interested. I probably will have to polish them at work before I can =
release it to the public.<div><br =
class=3D"webkit-block-placeholder"></div><div>I think this is a concern =
of mine since it might go into the mainline-kernel pretty soon and not =
only the blackfin-branch. It's pretty FUBAR on BE-systems in it's =
initial state...</div><div><br><div apple-content-edited=3D"true"> <span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: 2; text-align: auto; text-indent: =
0px; text-transform: none; white-space: normal; widows: 2; word-spacing: =
0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
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

--Apple-Mail-17--513273996--

--Apple-Mail-18--513273905
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkeX0sEACgkQ6I0XmJx2Nrw72gCeOULci+Cpa7FoXs1AUHpJy/ky
16QAnizzWjNZ+jRU17m4LEQhwbUTQeZx
=pVHf
-----END PGP SIGNATURE-----

--Apple-Mail-18--513273905--
