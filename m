Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 16:56:03 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.175]:6924 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022245AbZD1Pz5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 16:55:57 +0100
Received: by wf-out-1314.google.com with SMTP id 28so416273wfa.21
        for <multiple recipients>; Tue, 28 Apr 2009 08:55:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ygRXOrYN/gP0iHTARpLlj13G/ja51lidxBibyUDlf3w=;
        b=IJ2ZOjUaWAxJnqgzfYpKr9N2Y/Ib1kFeeb9Jorvh8gLvmVdnIasKKywIvtKHb5HBbS
         Dap6F2GLPNCdpT2UJoBMlqsIne6XCmbNcPZAhyH0XqQibi4XOQzSyzUxqZlU/U2U0wss
         Oo7mJU3Her/34n0gv9U4FPuKwkySB5U8J9LPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RzMv+8GAra/qgwBVR0vHlMSaOBctF1EM9+9MGn0n9sz3DsY8b2qiCqB28yZ6rl4BHC
         Ici5BXO9FPMHgyleuans+r1kxI1T2wu9fK3B6Gu4X1qLw279Iq5LgjB/ibPAFwk+2HN9
         hP6CUwO3tbTQDROz0kwesTP9MSkpt8IZIPkmo=
MIME-Version: 1.0
Received: by 10.220.99.6 with SMTP id s6mr13313402vcn.96.1240934154421; Tue, 
	28 Apr 2009 08:55:54 -0700 (PDT)
In-Reply-To: <200904281705.54721.florian@openwrt.org>
References: <E1LyQQX-00047N-6E@localhost> <20090428092005.GA2408@lst.de>
	 <b2b2f2320904280748q3a45ecf6r46dcb536877663c@mail.gmail.com>
	 <200904281705.54721.florian@openwrt.org>
Date:	Tue, 28 Apr 2009 09:55:54 -0600
Message-ID: <b2b2f2320904280855i7b9893ei407608a565751160@mail.gmail.com>
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Christoph Hellwig <hch@lst.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64755a476cbfe04689f7fc5
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64755a476cbfe04689f7fc5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Florian:

On Tue, Apr 28, 2009 at 9:05 AM, Florian Fainelli <florian@openwrt.org>wrot=
e:

> Hi Shane,
>
> Le Tuesday 28 April 2009 16:48:52 Shane McDonald, vous avez =E9crit :
> >
> > On Tue, Apr 28, 2009 at 3:20 AM, Christoph Hellwig <hch@lst.de> wrote:
> > > If the rootfs really is in ram only (and thus you discard any changes
> to
> > > it) you can just use an initramfs which is a lot simpler than any of
> the
> > > cramfs and squashfs hacks and supported by platform-independent code.
> >
> > The rootfs is ram only with a union mount of a jffs2 filesystem to reta=
in
> > changes.  The target system is a resource-constrained router board, and
> we
> > were trying to keep everything as small as possible.  If I remember
> > correctly, this code originally came over from an internal 2.4 port on =
an
> > even more resource-constrained platform; perhaps there are better optio=
ns
> > in today's world.
>
> Initramfs is supposed to address that kind of issue, coupled to the use o=
f
> mini_fo/unionfs with a jffs2 partition for instance.
>
> If you want to compress initramfs even more you may want to have a look a=
t
> the
> patch we maintain here:
>
> https://dev.openwrt.org/browser/trunk/target/linux/brcm47xx/patches-2.6.2=
8/500-lzma_initramfs.patch
>


Excellent -- it looks like I have a good path forward!  Thanks for the
pointer.


> > I will look into a better solution to this problem.  In the meantime, I=
'm
> > hesitant to remove the existing code -- I think I prefer to leave it
> > uncompilable until that solution is found.
>
> It is likely to confuse people that may want to try get it compiling agai=
n,
> removing sounds like a safe bet to me.


Based on your and Ralf's request, I'll prepare a patch tonight to get this
compiling again.

Shane

--0016e64755a476cbfe04689f7fc5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Florian:<br><br>
<div class=3D"gmail_quote">On Tue, Apr 28, 2009 at 9:05 AM, Florian Fainell=
i <span dir=3D"ltr">&lt;<a href=3D"mailto:florian@openwrt.org">florian@open=
wrt.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Shane,<br><br>Le Tuesday 28 A=
pril 2009 16:48:52 Shane McDonald, vous avez =E9crit=A0:<br>
<div class=3D"im">&gt;<br>&gt; On Tue, Apr 28, 2009 at 3:20 AM, Christoph H=
ellwig &lt;<a href=3D"mailto:hch@lst.de">hch@lst.de</a>&gt; wrote:<br>&gt; =
&gt; If the rootfs really is in ram only (and thus you discard any changes =
to<br>
&gt; &gt; it) you can just use an initramfs which is a lot simpler than any=
 of the<br>&gt; &gt; cramfs and squashfs hacks and supported by platform-in=
dependent code.<br>&gt;<br>&gt; The rootfs is ram only with a union mount o=
f a jffs2 filesystem to retain<br>
&gt; changes. =A0The target system is a resource-constrained router board, =
and we<br>&gt; were trying to keep everything as small as possible. =A0If I=
 remember<br>&gt; correctly, this code originally came over from an interna=
l 2.4 port on an<br>
&gt; even more resource-constrained platform; perhaps there are better opti=
ons<br>&gt; in today&#39;s world.<br><br></div>Initramfs is supposed to add=
ress that kind of issue, coupled to the use of<br>mini_fo/unionfs with a jf=
fs2 partition for instance.<br>
<br>If you want to compress initramfs even more you may want to have a look=
 at the<br>patch we maintain here:<br><a href=3D"https://dev.openwrt.org/br=
owser/trunk/target/linux/brcm47xx/patches-2.6.28/500-lzma_initramfs.patch" =
target=3D"_blank">https://dev.openwrt.org/browser/trunk/target/linux/brcm47=
xx/patches-2.6.28/500-lzma_initramfs.patch</a><br>

<div class=3D"im"></div></blockquote>
<div>=A0</div>
<div>=A0</div>
<div>Excellent -- it looks like I have a good path forward!=A0 Thanks for t=
he pointer.</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">&gt; I will look into a better solution to this problem. =
=A0In the meantime, I&#39;m<br>&gt; hesitant to remove the existing code --=
 I think I prefer to leave it<br>&gt; uncompilable until that solution is f=
ound.<br>
<br></div>It is likely to confuse people that may want to try get it compil=
ing again,<br>removing sounds like a safe bet to me.</blockquote>
<div>=A0</div>
<div>Based on your and Ralf&#39;s request, I&#39;ll prepare a patch tonight=
 to get this compiling again.</div>
<div>=A0</div>
<div>Shane</div></div>

--0016e64755a476cbfe04689f7fc5--
