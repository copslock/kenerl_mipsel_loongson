Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 14:02:17 +0100 (BST)
Received: from ns2.sagem.com ([62.160.59.241]:19156 "EHLO mx2.sagem.com")
	by ftp.linux-mips.org with ESMTP id S8133577AbVI1NB7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2005 14:01:59 +0100
To:	Yoann Allain <yallain@avilinks.com>
Cc:	linux-mips@linux-mips.org
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Compiling_a_2=2E6_kernel_for_Mips?=
MIME-Version: 1.0
Message-ID: <OF6AB06D9F.A4F86C60-ONC125708A.003730C5-C125708A.00479A09@sagem.com>
From:	Florian DELIZY <florian.delizy@sagem.com>
Date:	Wed, 28 Sep 2005 15:01:48 +0200
Content-Type: multipart/alternative; boundary="=_alternative 00479A07C125708A_="
Return-Path: <florian.delizy@sagem.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.delizy@sagem.com
Precedence: bulk
X-list: linux-mips

Message en plusieurs parties au format MIME
--=_alternative 00479A07C125708A_=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Hi,

> I am no more a newbie but I still need some help to build kernels :
> I am working on the Wintegra Evaluation Board (WEB777) and I used the=20
> 2.4 kernel Wintegra gave me with the patch for that board.
> I tried to adapt the patch for the 2.6 kernel but it doesn't work. I=20
> traced the kernel to find it crashed very early before displaying=20
anything.
> In fact the host processor makes an address and tries to read it but=20
> this makes an exception :

> * Exception 0x02 (user) : TLB (load or instruction fetch) *
> * in address: 80101ea8
> ClockDiv2+0xe38:
> [80101ea8] 8c820000 lw          r2,0x0000(r4)


> r0(zero): 00000000 r1(AT)  : 1000fc00 r2(v0)  : 0000001c r3(v1)  :=20
80360000
> r4(a0)  : 0000001c r5(a1)  : 803919f0 r6(a2)  : 0000000d r7(a3)  :=20
8038df8c

That would help a lot if you could objdump your kernel and give us 10=20
instructions before (at least)=20
and 10 instructions after it, you could try an :

mips-linux-objdump -DSz vmlinux | grep -U 20 '^\[80101ea8\]'

and send the output (that should ouput around 20 lines (which will=20
hopefully contain some C code also,
assu=F9ing that you compiled the code with debug informations. Moreover you=
=20
can also tell us in which=20
symbol (function) is located the address 0x80101ea8.


> I think this is a problem of host processor misconfiguration, but don't=20
> find out exactly what it is... To make the address in R4, the processor=20
> reads some zeroes where in 2.4 kernel, it doesn't and the address read=20
> in 2.4 is something like 0xbf010f1c.
> I don't know if this can help but here are the few functions before=20
crash:

> kernel=5Fentry
>    J start=5Fkernel
>             cpu=5Fprobe() (WEB777 patch)
>             prom=5Finit() (WEB777 patch)
>                   setup=5Fprom=5Fprintf() (WEB777 patch)
>                   wds=5Fprom=5Fprintf() (WEB777 patch)
>                            putPromChar() (WEB777 patch)
>                            --> CRASH

You should also start to figure out which variable/pointer anything is=20
consulted to get this adress (0x0000001c)=20
which might then help to understand you're problem.

Regards

Florian Delizy


--=_alternative 00479A07C125708A_=
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<br>
<br>
<br>
<br><font size=3D2 face=3D"Courier New">&gt; Hi,<br>
<br>
&gt; I am no more a newbie but I still need some help to build kernels :<br>
&gt; I am working on the Wintegra Evaluation Board (WEB777) and I used the =
<br>
&gt; 2.4 kernel Wintegra gave me with the patch for that board.<br>
&gt; I tried to adapt the patch for the 2.6 kernel but it doesn't work. I <=
br>
&gt; traced the kernel to find it crashed very early before displaying anyt=
hing.<br>
&gt; In fact the host processor makes an address and tries to read it but <=
br>
&gt; this makes an exception :<br>
<br>
&gt; * Exception 0x02 (user) : TLB (load or instruction fetch) *<br>
&gt; * in address: 80101ea8<br>
&gt; ClockDiv2+0xe38:<br>
&gt; [80101ea8] 8c820000 lw &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r2,0x0000(r4)=
<br>
<br>
<br>
&gt; r0(zero): 00000000 r1(AT) &nbsp;: 1000fc00 r2(v0) &nbsp;: 0000001c r3(=
v1) &nbsp;: 80360000<br>
&gt; r4(a0) &nbsp;: 0000001c r5(a1) &nbsp;: 803919f0 r6(a2) &nbsp;: 0000000=
d r7(a3) &nbsp;: 8038df8c<br>
<br>
That would help a lot if you could objdump your kernel and give us 10 instr=
uctions before (at least) </font>
<br><font size=3D2 face=3D"Courier New">and 10 instructions after it, you c=
ould try an :</font>
<br>
<br><font size=3D2 face=3D"Courier New">mips-linux-objdump -DSz vmlinux | g=
rep -U 20 '^\[80101ea8\]'</font>
<br>
<br><font size=3D2 face=3D"Courier New">and send the output (that should ou=
put around 20 lines (which will hopefully contain some C code also,</font>
<br><font size=3D2 face=3D"Courier New">assu=F9ing that you compiled the co=
de with debug informations. Moreover you can also tell us in which </font>
<br><font size=3D2 face=3D"Courier New">symbol (function) is located the ad=
dress 0x80101ea8.</font>
<br>
<br><font size=3D2 face=3D"Courier New"><br>
&gt; I think this is a problem of host processor misconfiguration, but don'=
t </font>
<br><font size=3D2 face=3D"Courier New">&gt; find out exactly what it is...=
 To make the address in R4, the processor <br>
&gt; reads some zeroes where in 2.4 kernel, it doesn't and the address read=
 <br>
&gt; in 2.4 is something like 0xbf010f1c.<br>
&gt; I don't know if this can help but here are the few functions before cr=
ash:<br>
<br>
&gt; kernel=5Fentry<br>
&gt; &nbsp; &nbsp;J start=5Fkernel<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cpu=5Fprobe() (WEB777 patch)=
<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; prom=5Finit() (WEB777 patch)=
<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; setup=
=5Fprom=5Fprintf() (WEB777 patch)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; wds=5Fp=
rom=5Fprintf() (WEB777 patch)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;putPromChar() (WEB777 patch)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;--&gt; CRASH</font>
<br>
<br><font size=3D2 face=3D"Courier New">You should also start to figure out=
 which variable/pointer anything is consulted to get this adress (0x0000001=
c) </font>
<br><font size=3D2 face=3D"Courier New">which might then help to understand=
 you're problem.<br>
<br>
Regards</font>
<br>
<br><font size=3D2 face=3D"Courier New">Florian Delizy</font>
<br>
<br>
--=_alternative 00479A07C125708A_=--
