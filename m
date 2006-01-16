Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 07:21:25 +0000 (GMT)
Received: from ns1.sagem.com ([62.160.59.65]:6068 "EHLO mx1.sagem.com")
	by ftp.linux-mips.org with ESMTP id S8133351AbWAPHVF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 07:21:05 +0000
To:	linux-mips <linux-mips@linux-mips.org>
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_does_the_linux_kernel_use_k0=2C_k1_regs=3F?=
MIME-Version: 1.0
Message-ID: <OF4F21A98A.1F732941-ONC12570F8.00283714-C12570F8.0028B1BE@sagem.com>
From:	Florian DELIZY <florian.delizy@sagem.com>
Date:	Mon, 16 Jan 2006 08:24:27 +0100
Content-Type: multipart/alternative; boundary="=_alternative 0028B1A5C12570F8_="
Return-Path: <florian.delizy@sagem.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.delizy@sagem.com
Precedence: bulk
X-list: linux-mips

Message en plusieurs parties au format MIME
--=_alternative 0028B1A5C12570F8_=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

k0, k1 registers are used in SAVE=5FALL and RESTORE=5FALL macros mainly, to=
=20
save all registers on the kernel stack,
once all registered are properly saved, you can use them, and restore them =

after, that's why kernel interrupt code does not=20
uise k0,k1, and let them for critical interruption code (save/restore=20
context)


Have a look in include/asm-mips/stackframe.h (grep is your friend)

-- Florian Delizy






zhuzhenhua <zzh.hust@gmail.com>

Envoy=E9 par : linux-mips-bounce@linux-mips.org
13/01/2006 03:39
Remis le : 15/01/2006 19:29

=20
        Pour :  linux-mips <linux-mips@linux-mips.org>
        cc :    (ccc : Florian DELIZY/EXT/SAGEM)
        Objet : does the linux kernel use k0, k1 regs?



i have to handle a NMI interrupt in bootloader(0xBFC00000),
 and i want to return to linux after the NMI interrupt,  i think other
regs maybe be useing by linux-kernel, i think the NMI handle only can
use K0, K1.

and i do not find the use of K0, K1 in linux-kernel interrupt or
exception handle
so i think if the NMI interrupt a linux interrupt handle, there is
still no conflict.

i am not sure my thinking is right, anyone can give some hints?

Best regards

zhuzhenhua




--=_alternative 0028B1A5C12570F8_=
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">k0, k1 registers are used in SAVE=5F=
ALL and RESTORE=5FALL macros mainly, to save all registers on the kernel st=
ack,</font>
<br><font size=3D2 face=3D"sans-serif">once all registered are properly sav=
ed, you can use them, and restore them after, that's why kernel interrupt c=
ode does not </font>
<br><font size=3D2 face=3D"sans-serif">uise k0,k1, and let them for critica=
l interruption code (save/restore context)</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Have a look in include/asm-mips/stac=
kframe.h (grep is your friend)</font>
<br>
<br><font size=3D2 face=3D"sans-serif">-- Florian Delizy</font>
<br>
<br>
<br>
<br>
<br>
<table width=3D100%>
<tr valign=3Dtop>
<td>
<td><font size=3D1 face=3D"sans-serif"><b>zhuzhenhua &lt;zzh.hust@gmail.com=
&gt;</b></font>
<br>
<br><font size=3D1 face=3D"sans-serif">Envoy=E9 par : linux-mips-bounce@lin=
ux-mips.org</font>
<p><font size=3D1 face=3D"sans-serif">13/01/2006 03:39</font>
<br><font size=3D1 face=3D"sans-serif">Remis le : 15/01/2006 19:29</font>
<br>
<td><font size=3D1 face=3D"Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Pour : &=
nbsp; &nbsp; &nbsp; &nbsp;linux-mips &lt;linux-mips@linux-mips.org&gt;</fon=
t>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc : &nb=
sp; &nbsp; &nbsp; &nbsp;(ccc : Florian DELIZY/EXT/SAGEM)</font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Objet : =
&nbsp; &nbsp; &nbsp; &nbsp;does the linux kernel use k0, k1 regs?</font>
<br></table>
<br>
<br>
<br><font size=3D2 face=3D"Courier New">i have to handle a NMI interrupt in=
 bootloader(0xBFC00000),<br>
 and i want to return to linux after the NMI interrupt, &nbsp;i think other=
<br>
regs maybe be useing by linux-kernel, i think the NMI handle only can<br>
use K0, K1.<br>
<br>
and i do not find the use of K0, K1 in linux-kernel interrupt or<br>
exception handle<br>
so i think if the NMI interrupt a linux interrupt handle, there is<br>
still no conflict.<br>
<br>
i am not sure my thinking is right, anyone can give some hints?<br>
<br>
Best regards<br>
<br>
zhuzhenhua<br>
<br>
</font>
<br>
<br>
--=_alternative 0028B1A5C12570F8_=--
