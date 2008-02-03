Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 15:52:53 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:16304 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20025543AbYBCPwo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 3 Feb 2008 15:52:44 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 044E1200A23C;
	Sun,  3 Feb 2008 16:52:41 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16989-01-91; Sun, 3 Feb 2008 16:52:40 +0100 (CET)
Received: from [192.168.0.2] (cust.fiber-lan.vnet.lk.85.194.49.173.stunet.se [85.194.49.173])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 16BD4200A219;
	Sun,  3 Feb 2008 16:52:40 +0100 (CET)
Cc:	linux-mips@linux-mips.org
Message-Id: <5BFC57F9-7E81-4667-9D15-72F5F20FA4DD@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
In-Reply-To: <1202050578.7035.11.camel@scarafaggio>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16-408453187"
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [SPAM] new type of crash report?
Date:	Sun, 3 Feb 2008 16:52:32 +0100
References: <1202050578.7035.11.camel@scarafaggio>
X-Pgp-Agent: GPGMail d51 (Leopard)
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.915)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16-408453187
Content-Type: multipart/alternative; boundary=Apple-Mail-15-408453153


--Apple-Mail-15-408453153
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

You can always start with running run gdb at the read address (ra: =20
0x2ac2bfdc), I'd also try listing 0x2ac2bffc.

//Markus

On 3 Feb 2008, at 15:56, Giuseppe Sacco wrote:

> Hi all,
> with latest kernel I started getting problem like this one. How may I
> understand what part of the kernel produced the problem? Is it =20
> possible
> to get a stack trace from this report?
>
> Thank you very much,
> Giuseppe
>
> Got dbe at 0x2ac2bffc
> Cpu 0
> $ 0   : 0000000000000000 0000000000000014 0000000000000000 =20
> 000000002acf1758
> $ 4   : 0000000000000000 00000000000073b0 0000000000000000 =20
> 0000000000000000
> $ 8   : 000000007fd06a64 0000000000000000 47a5ca5900000000 =20
> 0000100000000000
> $12   : 0000000000000000 0000000047a5ca59 0000000047a5ca59 =20
> 0000000000000000
> $16   : 0000000000000000 000000002acef588 000000002accbd68 =20
> 0000000000000000
> $20   : 0000000000546408 0000000000545e68 0000000000000000 =20
> 0000000000530bb8
> $24   : 0000000000000000 000000002abf8e58
> $28   : 000000002acf7960 000000007fd069e0 000000007fd069f0 =20
> 000000002ac2bfdc
> Hi    : 0000000000000000
> Lo    : 0000000000000000
> epc   : 000000002ac2bffc 0x2ac2bffc     Not tainted
> ra    : 000000002ac2bfdc 0x2ac2bfdc
> Status: 8001fcf3    KX SX UX USER EXL IE
> Cause : 0000041c
> PrId  : 00002321 (R5000)
> Index:  1 pgmask=3D4kb va=3Dc00000ffc0126000 asid=3D6b
>        [pa=3D00053946000 c=3D3 d=3D1 v=3D1 g=3D1] [pa=3D000538da000 =
c=3D3 d=3D1 v=3D1 =20
> g=3D1]
> Index:  2 pgmask=3D4kb va=3Dc00000ffc003a000 asid=3D6b
>        [pa=3D00054e25000 c=3D3 d=3D1 v=3D1 g=3D1] [pa=3D00000000000 =
c=3D0 d=3D0 v=3D0 =20
> g=3D1]
> Index:  4 pgmask=3D4kb va=3Dc00000ffc00d8000 asid=3D6b
>        [pa=3D00000000000 c=3D0 d=3D0 v=3D0 g=3D1] [pa=3D00053921000 =
c=3D3 d=3D1 v=3D1 =20
> g=3D1]
> Index:  7 pgmask=3D4kb va=3Dc00000ffc0042000 asid=3D6b
>        [pa=3D00054cf7000 c=3D3 d=3D1 v=3D1 g=3D1] [pa=3D00054eaa000 =
c=3D3 d=3D1 v=3D1 =20
> g=3D1]
> Index:  8 pgmask=3D4kb va=3Dc00000ffc012c000 asid=3D6b
>        [pa=3D000539e5000 c=3D3 d=3D1 v=3D1 g=3D1] [pa=3D00000000000 =
c=3D0 d=3D0 v=3D0 =20
> g=3D1]
> Index: 10 pgmask=3D4kb va=3Dc00000ffc00fa000 asid=3D6b
>        [pa=3D000539ae000 c=3D3 d=3D1 v=3D1 g=3D1] [pa=3D000539af000 =
c=3D3 d=3D1 v=3D1 =20
> g=3D1]
> [...]
>
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com




--Apple-Mail-15-408453153
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">You can always start with =
running run gdb at the read address (ra:&nbsp;0x2ac2bfdc), I'd also try =
listing&nbsp;0x2ac2bffc.<div><br =
class=3D"webkit-block-placeholder"></div><div>//Markus<br><div><div><br =
class=3D"webkit-block-placeholder"></div><div>On 3 Feb 2008, at 15:56, =
Giuseppe Sacco wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite">Hi =
all,<br>with latest kernel I started getting problem like this one. How =
may I<br>understand what part of the kernel produced the problem? Is it =
possible<br>to get a stack trace from this report?<br><br>Thank you very =
much,<br>Giuseppe<br><br>Got dbe at 0x2ac2bffc<br>Cpu 0<br>$ 0 =
&nbsp;&nbsp;: 0000000000000000 0000000000000014 0000000000000000 =
000000002acf1758<br>$ 4 &nbsp;&nbsp;: 0000000000000000 00000000000073b0 =
0000000000000000 0000000000000000<br>$ 8 &nbsp;&nbsp;: 000000007fd06a64 =
0000000000000000 47a5ca5900000000 0000100000000000<br>$12 &nbsp;&nbsp;: =
0000000000000000 0000000047a5ca59 0000000047a5ca59 =
0000000000000000<br>$16 &nbsp;&nbsp;: 0000000000000000 000000002acef588 =
000000002accbd68 0000000000000000<br>$20 &nbsp;&nbsp;: 0000000000546408 =
0000000000545e68 0000000000000000 0000000000530bb8<br>$24 &nbsp;&nbsp;: =
0000000000000000 000000002abf8e58 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>$28 &nbsp;&nbsp;: =
000000002acf7960 000000007fd069e0 000000007fd069f0 =
000000002ac2bfdc<br>Hi &nbsp;&nbsp;&nbsp;: 0000000000000000<br>Lo =
&nbsp;&nbsp;&nbsp;: 0000000000000000<br>epc &nbsp;&nbsp;: =
000000002ac2bffc 0x2ac2bffc &nbsp;&nbsp;&nbsp;&nbsp;Not tainted<br>ra =
&nbsp;&nbsp;&nbsp;: 000000002ac2bfdc 0x2ac2bfdc<br>Status: 8001fcf3 =
&nbsp;&nbsp;&nbsp;KX SX UX USER EXL IE <br>Cause : 0000041c<br>PrId =
&nbsp;: 00002321 (R5000)<br>Index: &nbsp;1 pgmask=3D4kb =
va=3Dc00000ffc0126000 asid=3D6b<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[pa=3D00053946000 c=3D3 d=3D1 =
v=3D1 g=3D1] [pa=3D000538da000 c=3D3 d=3D1 v=3D1 g=3D1]<br>Index: =
&nbsp;2 pgmask=3D4kb va=3Dc00000ffc003a000 asid=3D6b<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[pa=3D00054e25000 c=3D3 d=3D1 =
v=3D1 g=3D1] [pa=3D00000000000 c=3D0 d=3D0 v=3D0 g=3D1]<br>Index: =
&nbsp;4 pgmask=3D4kb va=3Dc00000ffc00d8000 asid=3D6b<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[pa=3D00000000000 c=3D0 d=3D0 =
v=3D0 g=3D1] [pa=3D00053921000 c=3D3 d=3D1 v=3D1 g=3D1]<br>Index: =
&nbsp;7 pgmask=3D4kb va=3Dc00000ffc0042000 asid=3D6b<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[pa=3D00054cf7000 c=3D3 d=3D1 =
v=3D1 g=3D1] [pa=3D00054eaa000 c=3D3 d=3D1 v=3D1 g=3D1]<br>Index: =
&nbsp;8 pgmask=3D4kb va=3Dc00000ffc012c000 asid=3D6b<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[pa=3D000539e5000 c=3D3 d=3D1 =
v=3D1 g=3D1] [pa=3D00000000000 c=3D0 d=3D0 v=3D0 g=3D1]<br>Index: 10 =
pgmask=3D4kb va=3Dc00000ffc00fa000 asid=3D6b<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[pa=3D000539ae000 c=3D3 d=3D1 =
v=3D1 g=3D1] [pa=3D000539af000 c=3D3 d=3D1 v=3D1 =
g=3D1]<br>[...]<br><br><br></blockquote></div><br><div =
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

--Apple-Mail-15-408453153--

--Apple-Mail-16-408453187
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkel40AACgkQ6I0XmJx2NrwvlACeJNf96D4XQAbbKeYLZ8BdW58f
DlYAn2lgdzHeKtW6rjYDRr+0y2bF2hFl
=gE5t
-----END PGP SIGNATURE-----

--Apple-Mail-16-408453187--
