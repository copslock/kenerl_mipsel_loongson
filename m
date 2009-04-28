Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 18:12:39 +0100 (BST)
Received: from qw-out-1920.google.com ([74.125.92.146]:57874 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025581AbZD1RMc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 18:12:32 +0100
Received: by qw-out-1920.google.com with SMTP id 9so570717qwj.54
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2009 10:12:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aDiENktRGw9wbxpJ48blwLu4sRvHWwidqhnkCJ5UQvY=;
        b=OaoQDBF146dzMsFOMjPiyWgZp0NEqhS415XCAOUBbVrwTnIsqmtqLEJPc0amnjQFeK
         qM9WAQAJfZnIOrwPfpC+PFF5Cod9vJLxKJ/TA6ctvvkReNs17mzp87iDF1lqIMFlHj0s
         OmHdK1aoYeBUNAmfqFAE9vERz/NMbPIYql67Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZbcyO4YUSxDpQ/DX579QCmUQDnH9a7OQTn0cVXaBLda1rUKAYo1Ilp3Y7oAXVPbuEf
         ygNkwRUP0nGxa9BI0KXlHxlMWf5iTPUvNawSA4zoRs6urpd8jgYuqrq/7OkMk8bErf28
         LaV/a+mY7izusav1p510xpijOidOFTjrtNdS0=
MIME-Version: 1.0
Received: by 10.220.95.75 with SMTP id c11mr13833388vcn.1.1240938750168; Tue, 
	28 Apr 2009 10:12:30 -0700 (PDT)
In-Reply-To: <200904281501.37811.florian@openwrt.org>
References: <ecbbfeda0904280458s4bb2de2q6c629ed79a472adc@mail.gmail.com>
	 <200904281501.37811.florian@openwrt.org>
Date:	Tue, 28 Apr 2009 12:12:30 -0500
Message-ID: <ecbbfeda0904281012h33f3a572nbd11547d5964c19d@mail.gmail.com>
Subject: Re: Linux on Linksys PSUS4?
From:	Andrew Wiley <debio264@gmail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e6470b0864579e0468a091d1
Return-Path: <debio264@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: debio264@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e6470b0864579e0468a091d1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2009 at 8:01 AM, Florian Fainelli <florian@openwrt.org>wrot=
e:

> Le Tuesday 28 April 2009 13:58:38 Andrew Wiley, vous avez =E9crit :
> > I stumbled onto this website while doing some research on a Linksys
> > printserver I retired a while back (the firmware kept crashing, but I
> don't
> > think it was a hardware problem), and I'm wondering if it would be
> possible
> > to install Linux on it. It has an ADM5120P, and the hardware seems to b=
e
> > supported, but how would I go about installing anything? Is there a
> serial
> > port header that I need to use? Would using it equate to soldering a
> serial
> > port to it?
>
> Soldering a seria port is not an option if you want to do something serio=
us
> with it.


Then how would it normally be done? I'm hoping to do this more for the
experience than for the final product, if only because there's a chance tha=
t
the reboot problem is hardware related, and the whole box is fairly useless
right now.


>
>
> > Is it even feasible to have a linux system running on 1MB of flash and =
4
> MB
> > of RAM?
>
> That's too small you would need at least 2MB Flash and 8MB RAM.


Could 2MB hold a full kernel? If I can compile in the right USB drivers, I
can put the rootfs on a flash drive in the USB port (this is a printserver,
so it has one), right?


Andrew Wiley

--0016e6470b0864579e0468a091d1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Apr 28, 2009 at 8:01 AM, Florian Fainell=
i <span dir=3D"ltr">&lt;<a href=3D"mailto:florian@openwrt.org">florian@open=
wrt.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
Le Tuesday 28 April 2009 13:58:38 Andrew Wiley, vous avez =E9crit=A0:<br>
<div class=3D"im">&gt; I stumbled onto this website while doing some resear=
ch on a Linksys<br>
&gt; printserver I retired a while back (the firmware kept crashing, but I =
don&#39;t<br>
&gt; think it was a hardware problem), and I&#39;m wondering if it would be=
 possible<br>
&gt; to install Linux on it. It has an ADM5120P, and the hardware seems to =
be<br>
&gt; supported, but how would I go about installing anything? Is there a se=
rial<br>
&gt; port header that I need to use? Would using it equate to soldering a s=
erial<br>
&gt; port to it?<br>
<br>
</div>Soldering a seria port is not an option if you want to do something s=
erious<br>
with it.</blockquote><div><br>Then how would it normally be done? I&#39;m h=
oping to do this more for the experience than for the final product, if onl=
y because there&#39;s a chance that the reboot problem is hardware related,=
 and the whole box is fairly useless right now.<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class=3D"im"><br>
&gt; Is it even feasible to have a linux system running on 1MB of flash and=
 4 MB<br>
&gt; of RAM?<br>
<br>
</div>That&#39;s too small you would need at least 2MB Flash and 8MB RAM.</=
blockquote><div><br>Could 2MB hold a full kernel? If I can compile in the r=
ight USB drivers, I can put the rootfs on a flash drive in the USB port (th=
is is a printserver, so it has one), right?<br>
<br><br>Andrew Wiley <br></div></div><br>

--0016e6470b0864579e0468a091d1--
