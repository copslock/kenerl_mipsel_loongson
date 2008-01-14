Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 22:34:28 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:31194 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20035613AbYANWeT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 22:34:19 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 7A56A200A223;
	Mon, 14 Jan 2008 23:34:17 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16795-01-84; Mon, 14 Jan 2008 23:34:16 +0100 (CET)
Received: from [192.168.0.2] (cust.fiber-lan.vnet.lk.85.194.49.173.stunet.se [85.194.49.173])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id AC4FD200A21C;
	Mon, 14 Jan 2008 23:34:16 +0100 (CET)
Cc:	linux-mips@linux-mips.org
Message-Id: <ECBAEAB5-2C07-4FAA-AB8F-71038F9D3D4F@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	The Engineer <lper.home@gmail.com>
In-Reply-To: <1a18fe6d0801141225u2395ae6dj39d268014019b4a1@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-852035104"
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [SPAM] Cache aliasing issues using 4K pages.
Date:	Mon, 14 Jan 2008 23:34:10 +0100
References: <1a18fe6d0801141225u2395ae6dj39d268014019b4a1@mail.gmail.com>
X-Pgp-Agent: GPGMail d51 (Leopard)
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.915)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-852035104
Content-Type: multipart/alternative; boundary=Apple-Mail-2-852035061


--Apple-Mail-2-852035061
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Lemme guess, it's not a dual-core as in SMP but a sub-CPU.
This usually involves that the memory differs, for example does it =20
have a TLB. Which vendor and which core is it? I suppose you use some =20=

sort of firmware from the vendor to access the sub-CPU, right?

//Markus

On 14 Jan 2008, at 21:25, The Engineer wrote:

> We are working with a 2.6.12 kernel on a dual-core mips architecture.
> In this dual-core system, one core is running the linux kernel and the
> other is used for some real-time handling (not directly controlled by
> Linux)
> We had different stability issues, which could be pinpointed to be
> related with cache aliasing problems.
> Cache aliasing happens when the same physical memory can be cached
> twice as it is accessed by two different virtual addresses.
> Indeed, for the index to select the correct cache line the virtual
> address is used. If some bits of the virtual page address are used in
> the cache index, aliasing can occur.
>
>
> As there is no hardware solution in the mips to recover from this
> (which would provide some cache coherency, even for one core), the
> only intrinsic safe solution is to enlarge the page size, so that
> cache indexing is only done by the offset address in the page (thus
> the physical part of the address).
> Another solution is to flush the cache if a page is being remapped to
> an aliased address (but in our case linux does not has control on the
> second core, which can cause issues with shared data between both
> cores).
> Currently the second solution is used in the kernel, but we found
> different issues with it (for instance: we had to merge more recent
> mips kernels, to get a reliable copy-on-write behaviour after
> forks...).
>
> Therefore some questions:
> - Are there still some known issues with cache aliasing in the MIPS =20=

> kernel?
> - Are there known issues when using 16KB pages (8KB pages seems not be
> possible due to tlb issues).
>
> Thanks in advance,
> Luc
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com




--Apple-Mail-2-852035061
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">Lemme guess, it's not a =
dual-core as in SMP but a sub-CPU.<div>This usually involves that the =
memory differs, for example does it have a TLB. Which vendor and which =
core is it? I suppose you use some sort of firmware from the vendor to =
access the sub-CPU, right?</div><div><br =
class=3D"webkit-block-placeholder"></div><div>//Markus<br><div><div><br><d=
iv><div>On 14 Jan 2008, at 21:25, The Engineer wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite">We are =
working with a 2.6.12 kernel on a dual-core mips architecture.<br>In =
this dual-core system, one core is running the linux kernel and =
the<br>other is used for some real-time handling (not directly =
controlled by<br>Linux)<br>We had different stability issues, which =
could be pinpointed to be<br>related with cache aliasing =
problems.<br>Cache aliasing happens when the same physical memory can be =
cached<br>twice as it is accessed by two different virtual =
addresses.<br>Indeed, for the index to select the correct cache line the =
virtual<br>address is used. If some bits of the virtual page address are =
used in<br>the cache index, aliasing can occur.<br><br><br>As there is =
no hardware solution in the mips to recover from this<br>(which would =
provide some cache coherency, even for one core), the<br>only intrinsic =
safe solution is to enlarge the page size, so that<br>cache indexing is =
only done by the offset address in the page (thus<br>the physical part =
of the address).<br>Another solution is to flush the cache if a page is =
being remapped to<br>an aliased address (but in our case linux does not =
has control on the<br>second core, which can cause issues with shared =
data between both<br>cores).<br>Currently the second solution is used in =
the kernel, but we found<br>different issues with it (for instance: we =
had to merge more recent<br>mips kernels, to get a reliable =
copy-on-write behaviour after<br>forks...).<br><br>Therefore some =
questions:<br>- Are there still some known issues with cache aliasing in =
the MIPS kernel?<br>- Are there known issues when using 16KB pages (8KB =
pages seems not be<br>possible due to tlb issues).<br><br>Thanks in =
advance,<br>Luc<br><br></blockquote></div><br><div =
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
class=3D"Apple-interchange-newline"> =
</div><br></div></div></div></body></html>=

--Apple-Mail-2-852035061--

--Apple-Mail-3-852035104
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkeL42IACgkQ6I0XmJx2NrwUAQCgnbJkbDKNejK2fqF+J0qkp8oE
EkAAmwVkKVn7Gasl6NJccks6pALGMBph
=9kUe
-----END PGP SIGNATURE-----

--Apple-Mail-3-852035104--
