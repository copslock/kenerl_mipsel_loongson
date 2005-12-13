Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2005 12:28:07 +0000 (GMT)
Received: from ns1.sagem.com ([62.160.59.65]:61761 "EHLO mx1.sagem.com")
	by ftp.linux-mips.org with ESMTP id S8133551AbVLMM1u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2005 12:27:50 +0000
To:	Yoichi Yuasa <yyuasa@gmail.com>
Cc:	colin <colin@realtek.com.tw>, linux-mips@linux-mips.org
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_To_put_Linux_kernel_as_closer_as?=
 =?ISO-8859-1?Q?_possible_to_0x80000000?=
MIME-Version: 1.0
Message-ID: <OFCB10026D.F6B473F3-ONC12570D6.0043AA59-C12570D6.00447CD7@sagem.com>
From:	Florian DELIZY <florian.delizy@sagem.com>
Date:	Tue, 13 Dec 2005 13:28:01 +0100
Content-Type: multipart/alternative; boundary="=_alternative 00447CD5C12570D6_="
Return-Path: <florian.delizy@sagem.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.delizy@sagem.com
Precedence: bulk
X-list: linux-mips

Message en plusieurs parties au format MIME
--=_alternative 00447CD5C12570D6_=
Content-Type: text/plain; charset="us-ascii"

> Yoichi Yuasa wrote :
> Hi
>
> It has no problem.
> Kernel has reserved space for exception handlers.
> 
> Yoichi
> 
> 2005/12/13, colin <colin@realtek.com.tw>:
> >
> > Hi all,
> > We want to put Linux kernel as closer as possible to the bottom of 
memory.
> > I know that there is some stuff put in the beginning of memory, like
> > Exception table.
> > So, what's the closest address to 0x80000000 that is allowable to 
store
> > kernel?


You should just take care to start after reserved exception/interruption 
vectors 

0x80000000 : TLB Refull
0x80000080 : General Exception Vector

+ 32 instructions. 

Depending on your architecture, those addresses may vary (I don't know 
anything about MIPS64

BTW, what's your arch ?

-- Florian

-----BEGIN GEEK CODE BLOCK-----
GCS:GE:GM/ d? s-:+ a-- C+++ 
U(BLUAVHISX)++++ P++++ L++++ 
E--- W+++ N+++ o++++ w--- O M V 
PS PE- PGP++ t 5 X+++ R+++ tv- 
b+ BI++++ D+++ G e+++ h-- r+++ y+++
-----END GEEK CODE BLOC------

--=_alternative 00447CD5C12570D6_=
Content-Type: text/html; charset="us-ascii"


<br>
<br><font size=2 face="Courier New">&gt; Yoichi Yuasa wrote :</font>
<br><font size=2 face="Courier New">&gt; Hi<br>
&gt;<br>
&gt; It has no problem.<br>
&gt; Kernel has reserved space for exception handlers.<br>
&gt; <br>
&gt; Yoichi<br>
&gt; <br>
&gt; 2005/12/13, colin &lt;colin@realtek.com.tw&gt;:<br>
&gt; &gt;<br>
&gt; &gt; Hi all,<br>
&gt; &gt; We want to put Linux kernel as closer as possible to the bottom of memory.<br>
&gt; &gt; I know that there is some stuff put in the beginning of memory, like<br>
&gt; &gt; Exception table.<br>
&gt; &gt; So, what's the closest address to 0x80000000 that is allowable to store<br>
&gt; &gt; kernel?</font>
<br>
<br>
<br><font size=2 face="Courier New">You should just take care to start after reserved exception/interruption vectors </font>
<br>
<br><font size=2 face="Courier New">0x80000000 : TLB Refull</font>
<br><font size=2 face="Courier New">0x80000080 : General Exception Vector</font>
<br>
<br><font size=2 face="Courier New">+ 32 instructions. </font>
<br>
<br><font size=2 face="Courier New">Depending on your architecture, those addresses may vary (I don't know anything about MIPS64</font>
<br>
<br><font size=2 face="Courier New">BTW, what's your arch ?</font>
<br>
<br><font size=2 face="Courier New">-- Florian</font>
<br>
<br><font size=2 face="Courier New">-----BEGIN GEEK CODE BLOCK-----</font>
<br><font size=2 face="Courier New">GCS:GE:GM/ d? s-:+ a-- C+++ </font>
<br><font size=2 face="Courier New">U(BLUAVHISX)++++ P++++ L++++ </font>
<br><font size=2 face="Courier New">E--- W+++ N+++ o++++ w--- O M V </font>
<br><font size=2 face="Courier New">PS PE- PGP++ t 5 X+++ R+++ tv- </font>
<br><font size=2 face="Courier New">b+ BI++++ D+++ G e+++ h-- r+++ y+++</font>
<br><font size=2 face="Courier New">-----END GEEK CODE BLOC------</font>
<br>
--=_alternative 00447CD5C12570D6_=--
