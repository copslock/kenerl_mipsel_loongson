Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 05:58:13 +0200 (CEST)
Received: from mail-vw0-f192.google.com ([209.85.212.192]:55747 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492008AbZJOD6F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 05:58:05 +0200
Received: by vws30 with SMTP id 30so264738vws.21
        for <multiple recipients>; Wed, 14 Oct 2009 20:57:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Mn/C5SrL53Yu6jxvns8Og8oGHtiYEo2niQ/fivb8clA=;
        b=G6QnZLteTNY4SEkN9AD/vpP2sai8nY/M2coFPLhaVNZ3e4X2DGy91nDDut2cYCBsdK
         ijZITj8EkvfxF94tDh8KuOQmn3yRSaX070gI147nTa79Re2frd/8iNrJYeHdOD6SalVr
         AVbXtTQK93ZldvHpJJOwqYxt5YjuL2hWlY6uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=V5tzvSm/lNjqEW8d0d5MLTOx1+M3uiRdup9Ool2cL7tszySefusySNUud1woPraKuA
         ae/bbO3iLOY4OwGTIA4Q1BxW5Ixq3jIFCqYYHU2u56DKpJK+6TCQbXrBhGidhyFzJDFN
         EAzoVAH2J2QD2bbgzg+I3G3DSdhNW60SgY0cA=
MIME-Version: 1.0
Received: by 10.220.89.158 with SMTP id e30mr14030740vcm.93.1255579076992; 
	Wed, 14 Oct 2009 20:57:56 -0700 (PDT)
In-Reply-To: <20091014232518.GA621@linux-mips.org>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
	 <1255546939-3302-3-git-send-email-dmitri.vorobiev@movial.com>
	 <b2b2f2320910141616p7b53c898gc4bc6a75713d4a8e@mail.gmail.com>
	 <20091014232518.GA621@linux-mips.org>
Date:	Wed, 14 Oct 2009 21:57:56 -0600
Message-ID: <b2b2f2320910142057m1bdbef80wba22014bc26eebf3@mail.gmail.com>
Subject: Re: [PATCH 2/3] [MIPS] msp71xx: remove unused function
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e6480644df20530475f14894
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e6480644df20530475f14894
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 14, 2009 at 5:25 PM, Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Oct 14, 2009 at 05:16:08PM -0600, Shane McDonald wrote:
>
> > > Nobody calls the board-specific prom_getcmdline(), so let's remove it.
> > >
> > > Build-tested using msp71xx_defconfig.
> > >
> > > Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
> > >
> > >
> > NAK.  It is called by the MSP71xx's Ethernet driver, whose code has not
> yet
> > made it into the mainline (last submission
> > http://www.linux-mips.org/archives/linux-mips/2007-05/msg00210.html).
> > Believe it or not, getting that driver whipped into shape is something
> I'm
> > slowly (very slowly) working on.
>
> At a glance, it's not outrageously bad so I suggest you submit it to be
> merged into drivers/staging it least it will no longer suffer the bitrot
> that out of tree drivers suffer from.
>
>  Ralf
>

Good idea!  I'll need to clean it up enough so that it compiles and runs
with HEAD, then I'll submit it to drivers/staging.

Shane

--0016e6480644df20530475f14894
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Oct 14, 2009 at 5:25 PM, Ralf Baechle <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.=
org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Wed, Oct 14, 2009 at 05:16:08PM -0600, Shane McDonald =
wrote:<br>
<br>
&gt; &gt; Nobody calls the board-specific prom_getcmdline(), so let&#39;s r=
emove it.<br>
&gt; &gt;<br>
&gt; &gt; Build-tested using msp71xx_defconfig.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Dmitri Vorobiev &lt;<a href=3D"mailto:dmitri.vorob=
iev@movial.com">dmitri.vorobiev@movial.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; NAK. =A0It is called by the MSP71xx&#39;s Ethernet driver, whose code =
has not yet<br>
&gt; made it into the mainline (last submission<br>
&gt; <a href=3D"http://www.linux-mips.org/archives/linux-mips/2007-05/msg00=
210.html" target=3D"_blank">http://www.linux-mips.org/archives/linux-mips/2=
007-05/msg00210.html</a>).<br>
&gt; Believe it or not, getting that driver whipped into shape is something=
 I&#39;m<br>
&gt; slowly (very slowly) working on.<br>
<br>
</div>At a glance, it&#39;s not outrageously bad so I suggest you submit it=
 to be<br>
merged into drivers/staging it least it will no longer suffer the bitrot<br=
>
that out of tree drivers suffer from.<br>
<font color=3D"#888888"><br>
 =A0Ralf<br></font></blockquote><div><br></div><div>Good idea! =A0I&#39;ll =
need to clean it up enough so that it compiles and runs with HEAD, then I&#=
39;ll submit it to drivers/staging.</div><div><br></div><div>Shane</div></d=
iv>
<br>

--0016e6480644df20530475f14894--
