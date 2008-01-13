Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jan 2008 15:22:19 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:57256 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20025610AbYAMPWK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Jan 2008 15:22:10 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 16394200A220;
	Sun, 13 Jan 2008 16:21:54 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31827-01-6; Sun, 13 Jan 2008 16:21:53 +0100 (CET)
Received: from [192.168.0.2] (cust.fiber-lan.vnet.lk.85.194.49.173.stunet.se [85.194.49.173])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 67DB2200A21F;
	Sun, 13 Jan 2008 16:21:47 +0100 (CET)
Cc:	linux-mips@linux-mips.org
Message-Id: <DF375560-30CA-44EF-A571-437BB4B08D31@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	Jorgen Lundman <lundman@lundman.net>
In-Reply-To: <478999C4.3040708@lundman.net>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-739685264"
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [SPAM] flush_cache_page
Date:	Sun, 13 Jan 2008 16:21:40 +0100
References: <478999C4.3040708@lundman.net>
X-Pgp-Agent: GPGMail d51 (Leopard)
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.915)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-739685264
Content-Type: multipart/alternative; boundary=Apple-Mail-2-739685218


--Apple-Mail-2-739685218
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Man, 2.6.15 is like 2-3 years old....

On 13 Jan 2008, at 05:55, Jorgen Lundman wrote:

>
> Due to cache coherence bugs, Fuse has an extra call to work around it;
>
>        flush_cache_page(vma, cs->addr, page_to_pfn(cs->pg));
>
>
> But my kernel (2.6.15 for mips 4KEc Tangox board) does not have a =20
> flush_cache_page().
>
> If I use kangox_flush_all() Fuse works rather well, but the =20
> performance is abysmal. Can I simulate this call using one of the =20
> calls I do have;
>
> __flush_dcache_page
> flush_data_cache_page
> tangox_flush_cache_all
> cache_flush
> kc_flush_cache
>
> Or alternatively, does anyone have the source for flush_cache_page() =20=

> for said CPU?
>
>
>
> --=20
> Jorgen Lundman       | <lundman@lundman.net>
> Unix Administrator   | +81 (0)3 -5456-2687 ext 1017 (work)
> Shibuya-ku, Tokyo    | +81 (0)90-5578-8500          (cell)
> Japan                | +81 (0)3 -3375-1767          (home)
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com



--Apple-Mail-2-739685218
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">Man, 2.6.15 is like 2-3 years =
old....<div><br><div><div>On 13 Jan 2008, at 05:55, Jorgen Lundman =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><br>Due to cache coherence bugs, Fuse has an extra call to =
work around it;<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flush_cache_page(vma, =
cs-&gt;addr, page_to_pfn(cs-&gt;pg));<br><br><br>But my kernel (2.6.15 =
for mips 4KEc Tangox board) does not have a =
flush_cache_page().<br><br>If I use kangox_flush_all() Fuse works rather =
well, but the performance is abysmal. Can I simulate this call using one =
of the calls I do =
have;<br><br>__flush_dcache_page<br>flush_data_cache_page<br>tangox_flush_=
cache_all<br>cache_flush<br>kc_flush_cache<br><br>Or alternatively, does =
anyone have the source for flush_cache_page() for said =
CPU?<br><br><br><br>-- <br>Jorgen Lundman =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &lt;<a =
href=3D"mailto:lundman@lundman.net">lundman@lundman.net</a>&gt;<br>Unix =
Administrator &nbsp;&nbsp;| +81 (0)3 -5456-2687 ext 1017 =
(work)<br>Shibuya-ku, Tokyo &nbsp;&nbsp;&nbsp;| +81 (0)90-5578-8500 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(cell)<br>Japan =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| +81 (0)3 -3375-1767 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(home)<br><br></bloc=
kquote></div><br><div apple-content-edited=3D"true"> <span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><div =
style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><div style=3D"margin-top: 0px; =
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
margin-bottom: 0px; margin-left: 0px; ">Mobile: +46 (0)73 718 72 =
80</div><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: =
0px; margin-left: 0px; ">Diskettgatan 11, SE-583 35 Link=F6ping, =
Sweden</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><a =
href=3D"http://www.27m.com">www.27m.com</a></div></div><br =
class=3D"Apple-interchange-newline"></span> =
</div><br></div></body></html>=

--Apple-Mail-2-739685218--

--Apple-Mail-3-739685264
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkeKLIQACgkQ6I0XmJx2Nrx5IACggfLfEhu2StZ8jC6mU5CsHZJr
hiYAn3ndqiQh9uhexxhzRBLXEUv4KkO/
=uFo5
-----END PGP SIGNATURE-----

--Apple-Mail-3-739685264--
