Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jul 2009 18:34:59 +0200 (CEST)
Received: from mail-vw0-f183.google.com ([209.85.212.183]:40136 "EHLO
	mail-vw0-f183.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492143AbZGLQev (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Jul 2009 18:34:51 +0200
Received: by vwj13 with SMTP id 13so1656340vwj.22
        for <multiple recipients>; Sun, 12 Jul 2009 09:34:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8LCjEEDuiRR3SOHPWe7k+AZf4pMa8jXWcPSxMehx2tQ=;
        b=PPHcA7GJWfLMm7AugFb8U5q5VscucAv5FZlvV06rqygPMSjmMqWylLb9wuVUmLBE+x
         RcnN86zIBtdUolD/P2S+MlwAwr9ShxNPHtYf9x5OQrlPxoQZ1UargITqMyPzw/WThT+4
         BJYpgMxZxTvodr1rCJvj1neQW7gWhgccgoitk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=d/RESkxJgCx4vFiULTMtW4FWIs1Bv2t2wmWaqGSUwcNjcFcr8qcu+ZB3BBzPzka0OB
         jjEYH8m/K3SMSr32RfW1/RwZHqPY5F2vnSiGIUgXI7vPdfGuXJHr3eeTgrgkz1mqXNIc
         yqq5rDDbi5SY/cYYzYHsC9bLwztX0gG3AWdMk=
MIME-Version: 1.0
Received: by 10.220.72.78 with SMTP id l14mr5872083vcj.81.1247416485069; Sun, 
	12 Jul 2009 09:34:45 -0700 (PDT)
In-Reply-To: <b2b2f2320907110351o1473fc79xa3926b8af4ffc35@mail.gmail.com>
References: <200904271659.48357.florian@openwrt.org>
	 <200904291512.19297.florian@openwrt.org>
	 <b2b2f2320904290718pe9a28efy9a8af432887778cb@mail.gmail.com>
	 <200906280701.32649.florian@openwrt.org>
	 <b2b2f2320907110351o1473fc79xa3926b8af4ffc35@mail.gmail.com>
Date:	Sun, 12 Jul 2009 10:34:45 -0600
Message-ID: <b2b2f2320907120934x6d6e4059ma318fe6236e45b19@mail.gmail.com>
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e6471b0a7ac576046e84c86a
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e6471b0a7ac576046e84c86a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, Jul 11, 2009 at 4:51 AM, Shane McDonald <mcdonald.shane@gmail.com>wrote:

> Hi Florian:
>
>   My apologies for the delay in replying to your latest prompt -- I've been
> on vacation with little internet access.
>
>   Your patch looks correct to me, but as Ralf says, the existing code is a
> little suspect.  In my poking around, I've come across three different
> versions of this file: the in-tree version, the latest out-of-tree patch
> from PMC-Sierra, and an unreleased version from a colleague.  None appear to
> be quite correct.  I think I've got enough info, though, to come up with a
> good version.
>
>   I'll cook something up this weekend and get it posted.


OK, I've done my cooking, and the cleanup patch will follow in a separate
email.  It expects Florian's patch to have been applied.

Florian's patch is correct, so I'll add my:

Acked-by: Shane McDonald <mcdonald.shane@gmail.com>

Shane

--0016e6471b0a7ac576046e84c86a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Jul 11, 2009 at 4:51 AM, Shane McDonald =
<span dir=3D"ltr">&lt;<a href=3D"mailto:mcdonald.shane@gmail.com">mcdonald.=
shane@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
Hi Florian:<br><br>=A0 My apologies for the delay in replying to your lates=
t prompt -- I&#39;ve been on vacation with little internet access.<br><br>=
=A0 Your patch looks correct to me, but as Ralf says, the existing code is =
a little suspect.=A0 In my poking around, I&#39;ve come across three differ=
ent versions of this file: the in-tree version, the latest out-of-tree patc=
h from PMC-Sierra, and an unreleased version from a colleague.=A0 None appe=
ar to be quite correct.=A0 I think I&#39;ve got enough info, though, to com=
e up with a good version.<br>

<br>=A0 I&#39;ll cook something up this weekend and get it posted.</blockqu=
ote><div><br>OK, I&#39;ve done my cooking, and the cleanup patch will follo=
w in a separate email.=A0 It expects Florian&#39;s patch to have been appli=
ed.<br>
<br>Florian&#39;s patch is correct, so I&#39;ll add my:<br><br>Acked-by: Sh=
ane McDonald &lt;<a href=3D"mailto:mcdonald.shane@gmail.com">mcdonald.shane=
@gmail.com</a>&gt;<br><br>Shane <br></div></div><br>

--0016e6471b0a7ac576046e84c86a--
