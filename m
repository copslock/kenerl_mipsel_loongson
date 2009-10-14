Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 01:16:25 +0200 (CEST)
Received: from mail-vw0-f192.google.com ([209.85.212.192]:59666 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493670AbZJNXQT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 01:16:19 +0200
Received: by vws30 with SMTP id 30so156409vws.21
        for <multiple recipients>; Wed, 14 Oct 2009 16:16:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zMBc1b2e0p4WMDAaO0QfOD455s216b49l3GZXxLPoBY=;
        b=GEMRH1pstMaVgR/iuglmrid0uQPIDNZQjPJ4mGMEJPY3R21gOClC9bgehT99pv24gn
         6Fai+0+FL/5T7yMeCG2QISHGLl0UVDmmcPfTcpjQDFGEraglNkQiEweoqZXjd+VSlGoF
         vp9IppKp9j4z8WX0C9uAEw5sba5YjZ0NHopvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pqlppYKe42N/7GSxEFN+/eL9Ty36rp6f0mdC6nQ8eiFwbwwEKwL1pFQM/oaUNgev3v
         B4+tWmiZAnLEBG+OJSTBI5apzqUfsfNVBd2mrT0WG0iy1dWFRhTnop9eM+mAofVYf/fk
         RWi6t9h3pZ0/Ckhg4tMYo6RpmuNdyyuF7fdu4=
MIME-Version: 1.0
Received: by 10.220.107.232 with SMTP id c40mr13510074vcp.92.1255562168772; 
	Wed, 14 Oct 2009 16:16:08 -0700 (PDT)
In-Reply-To: <1255546939-3302-3-git-send-email-dmitri.vorobiev@movial.com>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
	 <1255546939-3302-3-git-send-email-dmitri.vorobiev@movial.com>
Date:	Wed, 14 Oct 2009 17:16:08 -0600
Message-ID: <b2b2f2320910141616p7b53c898gc4bc6a75713d4a8e@mail.gmail.com>
Subject: Re: [PATCH 2/3] [MIPS] msp71xx: remove unused function
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00c09f8e5ba2107c300475ed5937
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--00c09f8e5ba2107c300475ed5937
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 14, 2009 at 1:02 PM, Dmitri Vorobiev <dmitri.vorobiev@movial.com
> wrote:

> Nobody calls the board-specific prom_getcmdline(), so let's remove it.
>
> Build-tested using msp71xx_defconfig.
>
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
>
>
NAK.  It is called by the MSP71xx's Ethernet driver, whose code has not yet
made it into the mainline (last submission
http://www.linux-mips.org/archives/linux-mips/2007-05/msg00210.html).
Believe it or not, getting that driver whipped into shape is something I'm
slowly (very slowly) working on.

Shane McDonald

--00c09f8e5ba2107c300475ed5937
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Oct 14, 2009 at 1:02 PM, Dmitri Vorobiev=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:dmitri.vorobiev@movial.com">dmitri=
.vorobiev@movial.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0p=
t 0.8ex; padding-left: 1ex;">
Nobody calls the board-specific prom_getcmdline(), so let&#39;s remove it.<=
br>
<br>
Build-tested using msp71xx_defconfig.<br>
<br>
Signed-off-by: Dmitri Vorobiev &lt;<a href=3D"mailto:dmitri.vorobiev@movial=
.com">dmitri.vorobiev@movial.com</a>&gt;<br>
<font color=3D"#888888"><br></font></blockquote><div><br>NAK.=A0 It is call=
ed by the MSP71xx&#39;s Ethernet driver, whose code has not yet made it int=
o the mainline (last submission <a href=3D"http://www.linux-mips.org/archiv=
es/linux-mips/2007-05/msg00210.html">http://www.linux-mips.org/archives/lin=
ux-mips/2007-05/msg00210.html</a>).=A0 Believe it or not, getting that driv=
er whipped into shape is something I&#39;m slowly (very slowly) working on.=
<br>
</div></div><br>Shane McDonald<br>

--00c09f8e5ba2107c300475ed5937--
