Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2005 10:21:00 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.192]:56684 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133581AbVL3KUe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2005 10:20:34 +0000
Received: by xproxy.gmail.com with SMTP id s19so1054473wxc
        for <linux-mips@linux-mips.org>; Fri, 30 Dec 2005 02:22:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=rN1UsGcDt5Wp/dO5qMWAHdnsr6QFiY5qEUJbR83SUxF3QVpjR43MYayNw9ncnNtvJpbFTuzigMAIuVePKsvxadVtuTNaDDZj/vTuGT9cFhDoyo1W5CH87OPF39rzDCkYkADIt+We2p53ff0wC2xFf711SY8BxqcalIXFP7zKBFo=
Received: by 10.70.109.10 with SMTP id h10mr6091762wxc;
        Fri, 30 Dec 2005 02:22:35 -0800 (PST)
Received: by 10.70.94.10 with HTTP; Fri, 30 Dec 2005 02:22:35 -0800 (PST)
Message-ID: <82e4189c0512300222k426764e0ldefeafb232ad36d@mail.gmail.com>
Date:	Fri, 30 Dec 2005 15:22:35 +0500
From:	Adil Hafeez <adilhafeez80@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Fixed kernel entry point suggestion
In-Reply-To: <20051230094750.GI1882@hattusa.textio>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_18571_7923318.1135938155760"
References: <82e4189c0512272336xed0fe2ax9fee6119ea2d6b00@mail.gmail.com>
	 <06af7c9f9f82dd2b306e02997869e709@embeddedalley.com>
	 <82e4189c0512300136w5112edf2kf3d243ddbc9313d@mail.gmail.com>
	 <20051230094750.GI1882@hattusa.textio>
Return-Path: <adilhafeez80@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adilhafeez80@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_18571_7923318.1135938155760
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

What about placing the jump instruction just after reserved space, like thi=
s

        .text
        /*
         * Reserved space for exception handlers.
         * Necessary for machines which link their kernels at KSEG0.
         */
        .fill   0x400

        /* The following two symbols are used for kernel profiling. */
        EXPORT(stext)
        EXPORT(_stext)
=3D>     j kernel_entry
        __INIT

I disassembled vmlinux binary and now jump instruction is placed after
reserved space



On 12/30/05, Thiemo Seufer <ths@networkno.de> wrote:
>
> Adil Hafeez wrote:
> > Hi Dan,
> >
> > Here is the patch.
> >
> > diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> > index eebdaa2..a5e6d4e 100644
> > --- a/arch/mips/kernel/head.S
> > +++ b/arch/mips/kernel/head.S
> > @@ -28,6 +28,7 @@
> > #include <asm/mipsregs.h>
> > #include <asm/stackframe.h>
> >
> > +        j kernel_entry
> > .text
> > /*
> > * Reserved space for exception handlers.
>
> But certainly not _before_ .text. Also, it shouldn't move the reserved
> space, it would need "align" instead of "space" afterwards.
>
>
> Thiemo
>
>

------=_Part_18571_7923318.1135938155760
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>What about placing the jump instruction just after reserved space, lik=
e this</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .text<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; * Reserved space for exception handlers.<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * Necessary for machines which link their kernels at=
 KSEG0.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fill&nbsp;&nbsp; 0x400</div>
<div>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The following two symbols =
are used for kernel profiling. */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; EXPORT(stext)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EXPORT(_st=
ext)<br>=3D&gt;&nbsp;&nbsp;&nbsp;&nbsp; j kernel_entry<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; __INIT</p>
<p>I disassembled vmlinux binary and now jump instruction is placed after r=
eserved space</p><br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 12/30/05, <b class=3D"gmail_sendername"=
>Thiemo Seufer</b> &lt;<a href=3D"mailto:ths@networkno.de">ths@networkno.de=
</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Adil Hafeez wrote:<br>&gt; Hi Da=
n,<br>&gt;<br>&gt; Here is the patch.<br>&gt;<br>&gt; diff --git a/arch/mip=
s/kernel/head.S b/arch/mips/kernel/head.S
<br>&gt; index eebdaa2..a5e6d4e 100644<br>&gt; --- a/arch/mips/kernel/head.=
S<br>&gt; +++ b/arch/mips/kernel/head.S<br>&gt; @@ -28,6 +28,7 @@<br>&gt; #=
include &lt;asm/mipsregs.h&gt;<br>&gt; #include &lt;asm/stackframe.h&gt;
<br>&gt;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;j kernel_=
entry<br>&gt; .text<br>&gt; /*<br>&gt; * Reserved space for exception handl=
ers.<br><br>But certainly not _before_ .text. Also, it shouldn't move the r=
eserved<br>space, it would need &quot;align&quot; instead of &quot;space&qu=
ot; afterwards.
<br><br><br>Thiemo<br><br></blockquote></div><br>

------=_Part_18571_7923318.1135938155760--
