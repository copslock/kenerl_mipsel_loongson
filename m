Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 13:06:07 +0100 (BST)
Received: from bobafett.staff.proxad.net ([213.228.1.121]:25830 "HELO
	bobafett.staff.proxad.net") by ftp.linux-mips.org with SMTP
	id S20043885AbYE0MGD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 May 2008 13:06:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 7B2C616586;
	Tue, 27 May 2008 14:05:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Qnw-B4xUSTTh; Tue, 27 May 2008 14:05:55 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id B3198F232;
	Tue, 27 May 2008 14:05:55 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: kexec on mips - anyone has it working?
Date:	Tue, 27 May 2008 14:05:54 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <483BCB75.4050901@wpkg.org>
In-Reply-To: <483BCB75.4050901@wpkg.org>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-01=_jk/OI48kTBdNOL0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805271405.55346.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

--Boundary-01=_jk/OI48kTBdNOL0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 27 May 2008 10:51:01 you wrote:
> I'm trying to use kexec on a ASUS WL-500gP router (BCM47XX, little
> endian MIPS) with a 2.6.25.4 kernel with some additional changes from
> OpenWRT.
>
> Unfortunately, it doesn't work for me - when I load a new kernel and try
> to execute it, it just says "Bye" and the router is dead:
>
> # kexec -l vmlinux
> # kexec -e
> (...)
> Bye
>
>
> I signalled the issue before in the past, with a 2.6.23.1 kernel:
>
> http://lists.infradead.org/pipermail/kexec/2008-February/001315.html
>
>
> Ideas? Ways to debug it?

I am using a 2.6.20 kernel on a 32bit mips platform and it is working fine.=
 however I am using this userland code (make CROSS=3D$(your cross-compiler =
prefix) to compile it) :=20

http://chac.le-poulpe.net/~nico/kexec.tar.gz

Could you try to add the following line in machine_kexec.c, just before jum=
ping to the trampoline:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0change_c0_config(CONF_CM_CMASK, C=
ONF_CM_UNCACHED);

This disables caching on KSEG0, but I would be suprised to find the bcm47xx=
 in the list of machines for which this line could be a "one way ticket to =
hell" :)

(Well I still have my doubts regarding the issue of not flushing the instru=
ction cache completely before jumping to the new kernel in the trampoline c=
ode).

Regards,

=2D-=20
Nicolas Schichan

--Boundary-01=_jk/OI48kTBdNOL0
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta name=3D"qrichtext" content=3D"1" /></head><body style=3D"=
font-size:11pt;font-family:Courier 10 Pitch">
<p>On Tuesday 27 May 2008 10:51:01 you wrote:</p>
<p><span style=3D"color:#008000">&gt; I'm trying to use kexec on a ASUS WL-=
500gP router (BCM47XX, little</span></p>
<p><span style=3D"color:#008000">&gt; endian MIPS) with a 2.6.25.4 kernel w=
ith some additional changes from</span></p>
<p><span style=3D"color:#008000">&gt; OpenWRT.</span></p>
<p><span style=3D"color:#008000">&gt;</span></p>
<p><span style=3D"color:#008000">&gt; Unfortunately, it doesn't work for me=
 - when I load a new kernel and try</span></p>
<p><span style=3D"color:#008000">&gt; to execute it, it just says &quot;Bye=
&quot; and the router is dead:</span></p>
<p><span style=3D"color:#008000">&gt;</span></p>
<p><span style=3D"color:#008000">&gt; # kexec -l vmlinux</span></p>
<p><span style=3D"color:#008000">&gt; # kexec -e</span></p>
<p><span style=3D"color:#008000">&gt; (...)</span></p>
<p><span style=3D"color:#008000">&gt; Bye</span></p>
<p><span style=3D"color:#008000">&gt;</span></p>
<p><span style=3D"color:#008000">&gt;</span></p>
<p><span style=3D"color:#008000">&gt; I signalled the issue before in the p=
ast, with a 2.6.23.1 kernel:</span></p>
<p><span style=3D"color:#008000">&gt;</span></p>
<p><span style=3D"color:#008000">&gt; http://lists.infradead.org/pipermail/=
kexec/2008-February/001315.html</span></p>
<p><span style=3D"color:#008000">&gt;</span></p>
<p><span style=3D"color:#008000">&gt;</span></p>
<p><span style=3D"color:#008000">&gt; Ideas? Ways to debug it?</span></p>
<p></p>
<p>I am using a 2.6.20 kernel on a 32bit mips platform and it is working fi=
ne. however I am using this userland code (make CROSS=3D$(your cross-compil=
er prefix) to compile it) : </p>
<p></p>
<p>http://chac.le-poulpe.net/~nico/kexec.tar.gz</p>
<p></p>
<p>Could you try to add the following line in machine_<span style=3D"color:=
#ff0000">kexec</span>.c, just before jumping to the trampoline:</p>
<p></p>
<p>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0change_c0_config(<span style=
=3D"color:#ff0000">CONF</span>_CM_<span style=3D"color:#ff0000">CMASK</span=
>, <span style=3D"color:#ff0000">CONF</span>_CM_<span style=3D"color:#ff000=
0">UNCACHED</span>);</p>
<p></p>
<p>This disables caching on <span style=3D"color:#ff0000">KSEG</span>0, but=
 I would be suprised to find the bcm47xx in the list of machines for which =
this line could be a &quot;one way ticket to hell&quot; :)</p>
<p></p>
<p>(Well I still have my doubts regarding the issue of not flushing the ins=
truction cache completely before jumping to the new kernel in the trampolin=
e code).</p>
<p></p>
<p>Regards,</p>
<p></p>
<p>-- </p>
<p>Nicolas <span style=3D"color:#ff0000">Schichan</span></p>
<p></p>
</body></html>
--Boundary-01=_jk/OI48kTBdNOL0--
