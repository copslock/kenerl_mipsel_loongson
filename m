Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 11:58:39 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.202]:36801 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133443AbWAPL6T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 11:58:19 +0000
Received: by wproxy.gmail.com with SMTP id 36so1147524wra
        for <linux-mips@linux-mips.org>; Mon, 16 Jan 2006 04:01:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=n6MjQek7XczpBZ47AxDHBbcftZ7cfba97ejI4Q+JRXnl/TeC1eesE0V6dTlK8bMdMKSL8SCRXUdHuKUBI3H5mVIbBaozfEA0UK0tDPfwu7bcZB7kBJdirFY8/lFflO30Wa8CTYjwcfO5KLav5ACdgLz0Kvhw47pn1FLmPw7Ldi8=
Received: by 10.54.104.14 with SMTP id b14mr949085wrc;
        Mon, 16 Jan 2006 04:01:49 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Mon, 16 Jan 2006 04:01:49 -0800 (PST)
Message-ID: <50c9a2250601160401ifa8337cs2f8638f0077f37ed@mail.gmail.com>
Date:	Mon, 16 Jan 2006 20:01:49 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	Florian DELIZY <florian.delizy@sagem.com>
Subject: =?ISO-8859-1?Q?Re:_R=E9f._:_does_the_linux_kernel_use_k0,_k1_regs=3F?=
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <OF4F21A98A.1F732941-ONC12570F8.00283714-C12570F8.0028B1BE@sagem.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11679_22905433.1137412909940"
References: <OF4F21A98A.1F732941-ONC12570F8.00283714-C12570F8.0028B1BE@sagem.com>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_11679_22905433.1137412909940
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

thanks for all
now in my NMI interrupt, i first move k0 value to Desave, then use k0 to
handle, and then eret.
it can work.

On 1/16/06, Florian DELIZY <florian.delizy@sagem.com> wrote:
>
>
> k0, k1 registers are used in SAVE_ALL and RESTORE_ALL macros mainly, to
> save all registers on the kernel stack,
> once all registered are properly saved, you can use them, and restore the=
m
> after, that's why kernel interrupt code does not
> uise k0,k1, and let them for critical interruption code (save/restore
> context)
>
>
> Have a look in include/asm-mips/stackframe.h (grep is your friend)
>
> -- Florian Delizy
>
>
>
>
>
> *zhuzhenhua <zzh.hust@gmail.com>*
>
> Envoy=E9 par : linux-mips-bounce@linux-mips.org
>
> 13/01/2006 03:39
> Remis le : 15/01/2006 19:29
>
>         Pour :        linux-mips <linux-mips@linux-mips.org>
>         cc :        (ccc : Florian DELIZY/EXT/SAGEM)
>         Objet :        does the linux kernel use k0, k1 regs?
>
>
>
> i have to handle a NMI interrupt in bootloader(0xBFC00000),
> and i want to return to linux after the NMI interrupt,  i think other
> regs maybe be useing by linux-kernel, i think the NMI handle only can
> use K0, K1.
>
> and i do not find the use of K0, K1 in linux-kernel interrupt or
> exception handle
> so i think if the NMI interrupt a linux interrupt handle, there is
> still no conflict.
>
> i am not sure my thinking is right, anyone can give some hints?
>
> Best regards
>
> zhuzhenhua
>
>
>
>

------=_Part_11679_22905433.1137412909940
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

thanks for all<br>
now in my NMI interrupt, i first move k0 value to Desave, then use k0 to ha=
ndle, and then eret.<br>
it can work.<br><br><div><span class=3D"gmail_quote">On 1/16/06, <b class=
=3D"gmail_sendername">Florian DELIZY</b> &lt;<a href=3D"mailto:florian.deli=
zy@sagem.com">florian.delizy@sagem.com</a>&gt; wrote:</span><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br><font face=3D"sans-serif" size=3D"2">k0, k1 registers are used in SAVE_=
ALL and RESTORE_ALL macros mainly, to save all registers on the kernel stac=
k,</font>
<br><font face=3D"sans-serif" size=3D"2">once all registered are properly s=
aved, you can use them, and restore them after, that's why kernel interrupt=
 code does not </font>
<br><font face=3D"sans-serif" size=3D"2">uise k0,k1, and let them for criti=
cal interruption code (save/restore context)</font>
<br>
<br>
<br><font face=3D"sans-serif" size=3D"2">Have a look in include/asm-mips/st=
ackframe.h (grep is your friend)</font>
<br>
<br><font face=3D"sans-serif" size=3D"2">-- Florian Delizy</font>
<br>
<br>
<br>
<br>
<br>
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td>
        <br>
</td><td><font face=3D"sans-serif" size=3D"1"><b>zhuzhenhua &lt;<a href=3D"=
mailto:zzh.hust@gmail.com" target=3D"_blank" onclick=3D"return top.js.OpenE=
xtLink(window,event,this)">zzh.hust@gmail.com</a>&gt;</b></font>
<br>
<br><font face=3D"sans-serif" size=3D"1">Envoy=E9 par : <a href=3D"mailto:l=
inux-mips-bounce@linux-mips.org" target=3D"_blank" onclick=3D"return top.js=
.OpenExtLink(window,event,this)">linux-mips-bounce@linux-mips.org</a></font=
>
<p><font face=3D"sans-serif" size=3D"1">13/01/2006 03:39</font>
<br><font face=3D"sans-serif" size=3D"1">Remis le : 15/01/2006 19:29</font>
<br>
</p></td><td><font face=3D"Arial" size=3D"1">&nbsp; &nbsp; &nbsp; &nbsp; </=
font>
<br><font face=3D"sans-serif" size=3D"1">&nbsp; &nbsp; &nbsp; &nbsp; Pour :=
 &nbsp; &nbsp; &nbsp; &nbsp;linux-mips &lt;<a href=3D"mailto:linux-mips@lin=
ux-mips.org" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,=
event,this)">linux-mips@linux-mips.org</a>&gt;
</font>
<br><font face=3D"sans-serif" size=3D"1">&nbsp; &nbsp; &nbsp; &nbsp; cc : &=
nbsp; &nbsp; &nbsp; &nbsp;(ccc : Florian DELIZY/EXT/SAGEM)</font>
<br><font face=3D"sans-serif" size=3D"1">&nbsp; &nbsp; &nbsp; &nbsp; Objet =
: &nbsp; &nbsp; &nbsp; &nbsp;does the linux kernel use k0, k1 regs?</font>
<br></td></tr></tbody></table>
<br>
<br>
<br><font face=3D"Courier New" size=3D"2">i have to handle a NMI interrupt =
in bootloader(0xBFC00000),<br>
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
</blockquote></div><br>

------=_Part_11679_22905433.1137412909940--
