Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 01:29:09 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:38100 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S32724961AbYGBA3E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 01:29:04 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 83ECD200FCED;
	Wed,  2 Jul 2008 02:29:00 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05858-01-92; Wed, 2 Jul 2008 02:28:59 +0200 (CEST)
Received: from [192.168.10.105] (h-60-134.A163.cust.bahnhof.se [79.136.60.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id B5DCB200A240;
	Wed,  2 Jul 2008 02:28:59 +0200 (CEST)
Cc:	linux-mips@linux-mips.org
Message-Id: <1CA160A5-AC66-4BBF-9C88-0C2B9FF40E6E@27m.se>
From:	Markus Gothe <markus.gothe@27m.se>
To:	"Morten Larsen" <mlarsen@broadcom.com>
In-Reply-To: <ADD7831BD377A74E9A1621D1EAAED18F0450AC61@NT-SJCA-0750.brcm.ad.broadcom.com>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-24-428131126"
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [SPAM] RE: Bug in atomic_sub_if_positive
Date:	Wed, 2 Jul 2008 02:28:52 +0200
References: <ADD7831BD377A74E9A1621D1EAAED18F0450AC61@NT-SJCA-0750.brcm.ad.broadcom.com>
X-Pgp-Agent: GPGMail d53 (v53, Leopard)
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.926)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-24-428131126
Content-Type: multipart/alternative; boundary=Apple-Mail-23-428131087


--Apple-Mail-23-428131087
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

NACK.

You must realize that 1b stands for 'label 1, backwards', so correctly =20=

it would be '2: b 1f'... Which is a kind off inconsequent numbering in =20=

this case.

//Markus

On 2 Jul 2008, at 02:12, Morten Larsen wrote:

>
>> As far as I can tell the branch optimization fixes in 2.6.21 =20
>> introduced
>> a bug in atomic_sub_if_positive that causes it to return even when =20=

>> the
>> sc instruction fails. The result is that e.g. down_trylock becomes
>> unreliable as the semaphore counter is not always decremented.
>
> Previous patch was garbled by Outlook - this one should be clean:
>
> --- a/include/asm-mips/atomic.h	2008-06-25 22:38:43.159739000 =
-0700
> +++ b/include/asm-mips/atomic.h	2008-06-25 22:39:07.552065000 =
-0700
> @@ -292,10 +292,10 @@ static __inline__ int atomic_sub_if_posi
> 		"	beqz	%0, 2f					=
\n"
> 		"	 subu	%0, %1, %3				=
\n"
> 		"	.set	reorder					=
\n"
> -		"1:							=
\n"
> 		"	.subsection 2					=
\n"
> 		"2:	b	1b					=
\n"
> 		"	.previous					=
\n"
> +		"1:							=
\n"
> 		"	.set	mips0					=
\n"
> 		: "=3D&r" (result), "=3D&r" (temp), "=3Dm" (v->counter)
> 		: "Ir" (i), "m" (v->counter)
> @@ -682,10 +682,10 @@ static __inline__ long atomic64_sub_if_p
> 		"	beqz	%0, 2f					=
\n"
> 		"	 dsubu	%0, %1, %3				=
\n"
> 		"	.set	reorder					=
\n"
> -		"1:							=
\n"
> 		"	.subsection 2					=
\n"
> 		"2:	b	1b					=
\n"
> 		"	.previous					=
\n"
> +		"1:							=
\n"
> 		"	.set	mips0					=
\n"
> 		: "=3D&r" (result), "=3D&r" (temp), "=3Dm" (v->counter)
> 		: "Ir" (i), "m" (v->counter)

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com




--Apple-Mail-23-428131087
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">NACK.<div><br></div><div>You =
must realize that 1b stands for 'label 1, backwards', so correctly it =
would be '2: b 1f'... Which is a kind off inconsequent numbering in this =
case.</div><div><br></div><div>//Markus</div><div><br><div><div>On 2 Jul =
2008, at 02:12, Morten Larsen wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div><br><blockquote type=3D"cite">As far as I can tell =
the branch optimization fixes in 2.6.21 =
introduced<br></blockquote><blockquote type=3D"cite">a bug in =
atomic_sub_if_positive that causes it to return even when =
the<br></blockquote><blockquote type=3D"cite">sc instruction fails. The =
result is that e.g. down_trylock becomes<br></blockquote><blockquote =
type=3D"cite">unreliable as the semaphore counter is not always =
decremented.<br></blockquote><br>Previous patch was garbled by Outlook - =
this one should be clean:<br><br>--- a/include/asm-mips/atomic.h<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>2008-06-25 22:38:43.159739000 -0700<br>+++ =
b/include/asm-mips/atomic.h<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>2008-06-25 22:39:07.552065000 =
-0700<br>@@ -292,10 +292,10 @@ static __inline__ int =
atomic_sub_if_posi<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>"<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>beqz<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>%0, 2f<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>\n"<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> subu<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>%0, %1, %3<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.set<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>reorder<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"1:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.subsection 2<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>\n"<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>"2:<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>b<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1b<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>\n"<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.previous<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"1:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.set<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>mips0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>: "=3D&amp;r" (result), "=3D&amp;r" (temp), "=3Dm" =
(v->counter)<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>: "Ir" (i), "m" (v->counter)<br>@@ -682,10 +682,10 @@ static =
__inline__ long atomic64_sub_if_p<br> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>"<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>beqz<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>%0, 2f<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>\n"<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> dsubu<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>%0, %1, %3<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.set<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>reorder<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"1:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.subsection 2<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>\n"<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>"2:<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>b<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>1b<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>\n"<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.previous<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"1:<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>"<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>.set<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>mips0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>\n"<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>: "=3D&amp;r" (result), "=3D&amp;r" (temp), "=3Dm" =
(v->counter)<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>: "Ir" (i), "m" (v->counter)<br></div></blockquote></div><br><div =
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

--Apple-Mail-23-428131087--

--Apple-Mail-24-428131126
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkhqy8QACgkQ6I0XmJx2Nry2bACgxwjEQt5GQ3vtWzAHbSajQd6D
10oAn1VdcTxfdXQQIPqn9/szlSDDVHHD
=WE4W
-----END PGP SIGNATURE-----

--Apple-Mail-24-428131126--
