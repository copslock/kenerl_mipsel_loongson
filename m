Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 09:33:37 +0000 (GMT)
Received: from ns2.sagem.com ([62.160.59.241]:42910 "EHLO mx2.sagem.com")
	by ftp.linux-mips.org with ESMTP id S8133570AbVLNJdR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2005 09:33:17 +0000
To:	linux-mips@linux-mips.org
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_R=E9f=2E_=3A_Re=3A_To_put_Linux_kernel?=
 =?ISO-8859-1?Q?_as_closer_as_possible_to_0x80000000?=
MIME-Version: 1.0
Message-ID: <OF6E2E93F3.C8E3C153-ONC12570D7.0033A3DE-C12570D7.00348427@sagem.com>
From:	Florian DELIZY <florian.delizy@sagem.com>
Date:	Wed, 14 Dec 2005 10:33:34 +0100
Content-Type: multipart/alternative; boundary="=_alternative 00348426C12570D7_="
Return-Path: <florian.delizy@sagem.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.delizy@sagem.com
Precedence: bulk
X-list: linux-mips

Message en plusieurs parties au format MIME
--=_alternative 00348426C12570D7_=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 > Hi Florian,
> We use MIPS 4kec.
> Linux runs in Interrupt Compatibility Mode, and it will use 0x80000200=20
to store the "Jump" instruction.
> Therefore, we can move Linux kernel to 0x80000204. Is it right?

Not exactly, take care that the instruction located just after your jump=20
is also loaded and executed by the pipe, so you can place it
at 0x80000208 (to have your two instructions safe), which should look like =

:

800000200:      j some=5Faddress
800000204:      nop
800000208:      LinuxFirstInstruction
=20
Off course, you must also advise your boot loader to jump at the correct=20
address within the kernel (kernel=5Fentry)

> Another new question. If we modify Linux to use Ventored Interrupt mode, =

can we gain much performance?

Ventored ?? I guess you mean "Vectored interrupt". IMO you won't get much=20
performance gain, in this particular situation,
since your interrupt vector is just making a jump ... you might just gain=20
1 instruction (the nop) but that's all.=20
Somebody may have another opinion about this ...

Regards

--- Florian
=20
> Regards,
> Colin
=20
----- Original Message -----=20
From: Florian DELIZY=20
To: Yoichi Yuasa=20
Cc: colin ; linux-mips@linux-mips.org=20
Sent: Tuesday, December 13, 2005 8:28 PM
Subject: R=E9f. : Re: To put Linux kernel as closer as possible to 0x800000=
00



> Yoichi Yuasa wrote :=20
> Hi
>
> It has no problem.
> Kernel has reserved space for exception handlers.
>=20
> Yoichi
>=20
> 2005/12/13, colin <colin@realtek.com.tw>:
> >
> > Hi all,
> > We want to put Linux kernel as closer as possible to the bottom of=20
memory.
> > I know that there is some stuff put in the beginning of memory, like
> > Exception table.
> > So, what's the closest address to 0x80000000 that is allowable to=20
store
> > kernel?=20


You should just take care to start after reserved exception/interruption=20
vectors=20

0x80000000 : TLB Refull=20
0x80000080 : General Exception Vector=20

+ 32 instructions.=20

Depending on your architecture, those addresses may vary (I don't know=20
anything about MIPS64=20

BTW, what's your arch ?=20

-- Florian=20

-----BEGIN GEEK CODE BLOCK-----=20
GCS:GE:GM/ d? s-:+ a-- C+++=20
U(BLUAVHISX)++++ P++++ L++++=20
E--- W+++ N+++ o++++ w--- O M V=20
PS PE- PGP++ t 5 X+++ R+++ tv-=20
b+ BI++++ D+++ G e+++ h-- r+++ y+++=20
-----END GEEK CODE BLOC------=20


--=_alternative 00348426C12570D7_=
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<br>
<br><font size=3D3 face=3D"Times New Roman">&nbsp;</font>
<br><font size=3D3 face=3D"Times New Roman">&gt; Hi Florian,</font>
<br><font size=3D3 face=3D"Times New Roman">&gt; We use MIPS 4kec.</font>
<br><font size=3D3 face=3D"Times New Roman">&gt; Linux runs in Interrupt Co=
mpatibility Mode, and it will use 0x80000200 to store the &quot;Jump&quot; =
instruction.</font>
<br><font size=3D3 face=3D"Times New Roman">&gt; Therefore, we can move Lin=
ux kernel to 0x80000204. Is it right?</font>
<br>
<br><font size=3D3 face=3D"Times New Roman">Not exactly, take care that the=
 instruction located just after your jump is also loaded and executed by th=
e pipe, so you can place it</font>
<br><font size=3D3 face=3D"Times New Roman">at 0x80000208 (to have your two=
 instructions safe), which should look like :</font>
<br>
<br><font size=3D3 face=3D"Times New Roman">800000200: &nbsp; &nbsp; &nbsp;=
 &nbsp; j some=5Faddress</font>
<br><font size=3D3 face=3D"Times New Roman">800000204: &nbsp; &nbsp; &nbsp;=
 &nbsp;nop</font>
<br><font size=3D3 face=3D"Times New Roman">800000208: &nbsp; &nbsp; &nbsp;=
 &nbsp; LinuxFirstInstruction</font>
<br><font size=3D3 face=3D"Times New Roman">&nbsp;</font>
<br><font size=3D3 face=3D"Times New Roman">Off course, you must also advis=
e your boot loader to jump at the correct address within the kernel (kernel=
=5Fentry)</font>
<br>
<br><font size=3D3 face=3D"Times New Roman">&gt; Another new question. If w=
e modify Linux to use Ventored Interrupt mode, can we gain much performance=
?</font>
<br>
<br><font size=3D3 face=3D"Times New Roman">Ventored ?? I guess you mean &q=
uot;Vectored interrupt&quot;. IMO you won't get much performance gain, in t=
his particular situation,</font>
<br><font size=3D3 face=3D"Times New Roman">since your interrupt vector is =
just making a jump ... you might just gain 1 instruction (the nop) but that=
's all. </font>
<br><font size=3D3 face=3D"Times New Roman">Somebody may have another opini=
on about this ...</font>
<br>
<br><font size=3D3 face=3D"Times New Roman">Regards</font>
<br>
<br><font size=3D3 face=3D"Times New Roman">--- Florian</font>
<br><font size=3D3 face=3D"Times New Roman">&nbsp;</font>
<br><font size=3D3 face=3D"Times New Roman">&gt; Regards,</font>
<br><font size=3D3 face=3D"Times New Roman">&gt; Colin</font>
<br><font size=3D3 face=3D"Times New Roman">&nbsp;</font>
<br><font size=3D3 face=3D"Times New Roman">----- Original Message ----- </=
font>
<br><font size=3D3 face=3D"Times New Roman"><b>From:</b> </font><a href=3Dm=
ailto:florian.delizy@sagem.com><font size=3D3 color=3Dblue face=3D"Times Ne=
w Roman"><u>Florian DELIZY</u></font></a><font size=3D3 face=3D"Times New R=
oman"> </font>
<br><font size=3D3 face=3D"Times New Roman"><b>To:</b> </font><a href=3Dmai=
lto:yyuasa@gmail.com><font size=3D3 color=3Dblue face=3D"Times New Roman"><=
u>Yoichi Yuasa</u></font></a><font size=3D3 face=3D"Times New Roman"> </fon=
t>
<br><font size=3D3 face=3D"Times New Roman"><b>Cc:</b> </font><a href=3Dmai=
lto:colin@realtek.com.tw><font size=3D3 color=3Dblue face=3D"Times New Roma=
n"><u>colin</u></font></a><font size=3D3 face=3D"Times New Roman"> ; </font=
><a href=3D"mailto:linux-mips@linux-mips.org"><font size=3D3 color=3Dblue f=
ace=3D"Times New Roman"><u>linux-mips@linux-mips.org</u></font></a><font si=
ze=3D3 face=3D"Times New Roman"> </font>
<br><font size=3D3 face=3D"Times New Roman"><b>Sent:</b> Tuesday, December =
13, 2005 8:28 PM</font>
<br><font size=3D3 face=3D"Times New Roman"><b>Subject:</b> R=E9f. : Re: To=
 put Linux kernel as closer as possible to 0x80000000</font>
<br>
<br><font size=3D3 face=3D"Times New Roman"><br>
</font><font size=3D2 face=3D"Courier New"><br>
&gt; Yoichi Yuasa wrote :</font><font size=3D3 face=3D"Times New Roman"> </=
font><font size=3D2 face=3D"Courier New"><br>
&gt; Hi<br>
&gt;<br>
&gt; It has no problem.<br>
&gt; Kernel has reserved space for exception handlers.<br>
&gt; <br>
&gt; Yoichi<br>
&gt; <br>
&gt; 2005/12/13, colin &lt;</font><a href=3Dmailto:colin@realtek.com.tw><fo=
nt size=3D2 color=3Dblue face=3D"Courier New"><u>colin@realtek.com.tw</u></=
font></a><font size=3D2 face=3D"Courier New">&gt;:<br>
&gt; &gt;<br>
&gt; &gt; Hi all,<br>
&gt; &gt; We want to put Linux kernel as closer as possible to the bottom o=
f memory.<br>
&gt; &gt; I know that there is some stuff put in the beginning of memory, l=
ike<br>
&gt; &gt; Exception table.<br>
&gt; &gt; So, what's the closest address to 0x80000000 that is allowable to=
 store<br>
&gt; &gt; kernel?</font><font size=3D3 face=3D"Times New Roman"> <br>
<br>
</font><font size=3D2 face=3D"Courier New"><br>
You should just take care to start after reserved exception/interruption ve=
ctors </font><font size=3D3 face=3D"Times New Roman"><br>
</font><font size=3D2 face=3D"Courier New"><br>
0x80000000 : TLB Refull</font><font size=3D3 face=3D"Times New Roman"> </fo=
nt><font size=3D2 face=3D"Courier New"><br>
0x80000080 : General Exception Vector</font><font size=3D3 face=3D"Times Ne=
w Roman"> <br>
</font><font size=3D2 face=3D"Courier New"><br>
+ 32 instructions. </font><font size=3D3 face=3D"Times New Roman"><br>
</font><font size=3D2 face=3D"Courier New"><br>
Depending on your architecture, those addresses may vary (I don't know anyt=
hing about MIPS64</font><font size=3D3 face=3D"Times New Roman"> <br>
</font><font size=3D2 face=3D"Courier New"><br>
BTW, what's your arch ?</font><font size=3D3 face=3D"Times New Roman"> <br>
</font><font size=3D2 face=3D"Courier New"><br>
-- Florian</font><font size=3D3 face=3D"Times New Roman"> <br>
</font><font size=3D2 face=3D"Courier New"><br>
-----BEGIN GEEK CODE BLOCK-----</font><font size=3D3 face=3D"Times New Roma=
n"> </font><font size=3D2 face=3D"Courier New"><br>
GCS:GE:GM/ d? s-:+ a-- C+++ <br>
U(BLUAVHISX)++++ P++++ L++++ <br>
E--- W+++ N+++ o++++ w--- O M V <br>
PS PE- PGP++ t 5 X+++ R+++ tv- <br>
b+ BI++++ D+++ G e+++ h-- r+++ y+++</font><font size=3D3 face=3D"Times New =
Roman"> </font><font size=3D2 face=3D"Courier New"><br>
-----END GEEK CODE BLOC------</font><font size=3D3 face=3D"Times New Roman"=
> </font>
<br>
<br>
--=_alternative 00348426C12570D7_=--
