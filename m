Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 10:06:50 +0100 (BST)
Received: from ns2.sagem.com ([62.160.59.241]:35188 "EHLO mx2.sagem.com")
	by ftp.linux-mips.org with ESMTP id S8133566AbVI0JGd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2005 10:06:33 +0100
To:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc:	linux-mips@linux-mips.org
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_linux-mips_Vs_kernel=2Eorg?=
MIME-Version: 1.0
Message-ID: <OF09624E56.0EE9A8E5-ONC1257089.0031D0AF-C1257089.00320CF1@sagem.com>
From:	Florian DELIZY <florian.delizy@sagem.com>
Date:	Tue, 27 Sep 2005 11:06:25 +0200
Content-Type: multipart/mixed; boundary="=_mixed 00320CF0C1257089_="
Return-Path: <florian.delizy@sagem.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.delizy@sagem.com
Precedence: bulk
X-list: linux-mips

--=_mixed 00320CF0C1257089_=
Content-Type: multipart/alternative; boundary="=_alternative 00320CF0C1257089_="


--=_alternative 00320CF0C1257089_=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Is that meaning that kernel.org source code is merged into linux-mips.org=20
repository,=20
or that linux-mips.org code is merged into the kernel.org source=20
repository ?






Jan-Benedict Glaw <jbglaw@lug-owl.de>

Envoy=E9 par : linux-mips-bounce@linux-mips.org
27/09/2005 10:12
Remis le : 27/09/2005 10:13

=20
        Pour :  linux-mips@linux-mips.org
        cc :    (ccc : Florian DELIZY/EXT/SAGEM)
        Objet : Re: linux-mips Vs kernel.org



On Tue, 2005-09-27 09:52:01 +0200, Florian DELIZY=20
<florian.delizy@sagem.com> wrote:
> We currently working with the 2.6.12 kernel, and wondering which from
> linux-mips or kernel.org version we should use,
> in a more general manner, what are the differences between linux-mips=20
and
> kernel.org kernel source code, is one the
> mirror of the other, or is there one that frequently merge with the=20
other

Use the linux-mips.org tree to do any work.

To find out about the differences, just download a kernel.org kernel
and run a 'diff -Nurp' against what you find on linux-mips.org.

Up to now, merges happened every now-and-then, but not on a very
regular basis. However, there's hope for more timely merges since Ralf
is on the way to move the souce base over to GIT, which should ease
further merges...

MfG, JBG

--
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481 =5F O =5F
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg=20
=5F =5F O
f=FCr einen Freien Staat voll Freier B=FCrger"  | im Internet! |   im Irak!=
 O=20
O O
ret =3D do=5Factions((curr | FREE=5FSPEECH) & ~(NEW=5FCOPYRIGHT=5FLAW | DRM=
 |=20
TCPA));



--=_alternative 00320CF0C1257089_=
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Is that meaning that kernel.org sour=
ce code is merged into linux-mips.org repository, </font>
<br><font size=3D2 face=3D"sans-serif">or that linux-mips.org code is merge=
d into the kernel.org source repository ?</font>
<br>
<br>
<br>
<br>
<br>
<table width=3D100%>
<tr valign=3Dtop>
<td>
<td><font size=3D1 face=3D"sans-serif"><b>Jan-Benedict Glaw &lt;jbglaw@lug-=
owl.de&gt;</b></font>
<br>
<br><font size=3D1 face=3D"sans-serif">Envoy=E9 par : linux-mips-bounce@lin=
ux-mips.org</font>
<p><font size=3D1 face=3D"sans-serif">27/09/2005 10:12</font>
<br><font size=3D1 face=3D"sans-serif">Remis le : 27/09/2005 10:13</font>
<br>
<td><font size=3D1 face=3D"Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Pour : &=
nbsp; &nbsp; &nbsp; &nbsp;linux-mips@linux-mips.org</font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc : &nb=
sp; &nbsp; &nbsp; &nbsp;(ccc : Florian DELIZY/EXT/SAGEM)</font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Objet : =
&nbsp; &nbsp; &nbsp; &nbsp;Re: linux-mips Vs kernel.org</font>
<br></table>
<br>
<br>
<br><font size=3D2><tt>On Tue, 2005-09-27 09:52:01 +0200, Florian DELIZY &l=
t;florian.delizy@sagem.com&gt; wrote:<br>
&gt; We currently working with the 2.6.12 kernel, and wondering which from<=
br>
&gt; linux-mips or kernel.org version we should use,<br>
&gt; in a more general manner, what are the differences between linux-mips =
and<br>
&gt; kernel.org kernel source code, is one the<br>
&gt; mirror of the other, or is there one that frequently merge with the ot=
her<br>
</tt></font>
<br><font size=3D2><tt>Use the linux-mips.org tree to do any work.<br>
</tt></font>
<br><font size=3D2><tt>To find out about the differences, just download a k=
ernel.org kernel<br>
and run a 'diff -Nurp' against what you find on linux-mips.org.<br>
</tt></font>
<br><font size=3D2><tt>Up to now, merges happened every now-and-then, but n=
ot on a very<br>
regular basis. However, there's hope for more timely merges since Ralf<br>
is on the way to move the souce base over to GIT, which should ease<br>
further merges...<br>
</tt></font>
<br><font size=3D2><tt>MfG, JBG<br>
</tt></font>
<br><font size=3D2><tt>--<br>
Jan-Benedict Glaw &nbsp; &nbsp; &nbsp; jbglaw@lug-owl.de &nbsp; &nbsp;. +49=
-172-7608481 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =5F O =5F<br>
&quot;Eine Freie Meinung in &nbsp;einem Freien Kopf &nbsp; &nbsp;| Gegen Ze=
nsur | Gegen Krieg &nbsp;=5F =5F O</tt></font>
<br><font size=3D2><tt>f=FCr einen Freien Staat voll Freier B=FCrger&quot; =
&nbsp;| im Internet! | &nbsp; im Irak! &nbsp; O O O<br>
ret =3D do=5Factions((curr | FREE=5FSPEECH) &amp; ~(NEW=5FCOPYRIGHT=5FLAW |=
 DRM | TCPA));</tt></font>
<br>
<br>
<br>
--=_alternative 00320CF0C1257089_=--
--=_mixed 00320CF0C1257089_=
Content-Type: application/octet-stream; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NClZlcnNpb246IEdudVBHIHYxLjQuMSAoR05V
L0xpbnV4KQ0KDQppRDhEQlFGRE9QN3ZIYjFlZFlPWjRic1JBbXB0QUowYkhGS2Z6Z05IcWZiYjhw
S3VIYXZQTzlkU1VBQ2ZTLzNyDQppbHJsTG5kUk9UeHZDcEVQMi8yaDk1QT0NCj0yTXpLDQotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg0K

--=_mixed 00320CF0C1257089_=--
