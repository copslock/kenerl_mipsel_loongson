Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 15:18:26 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:37612 "EHLO
	mail-ew0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025438AbZD2OSS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 15:18:18 +0100
Received: by ewy22 with SMTP id 22so1292066ewy.0
        for <multiple recipients>; Wed, 29 Apr 2009 07:18:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=4fWGn8xZqXhse1COeKCcp1fw65io+mImTLPnYjPJJfQ=;
        b=ZxSPqXnTLwC4cNQpZ7Njw6UXDON/mWpM/uwAfhypHh71V5jXqp4jTwDkrKFJdUlkd5
         IE7vVVlx9rWpUlzu0N4j634a5ESuRP8X87Yvc4P4Owwu+pW5QauLC+yJUfa7aqBv1rs5
         zewkM7OBT5YVq8KqSzAV8TN0HkCHIzOunW4j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YLomPYO6Q5zjUIfhLlOkGBjJ0GW0fQOneVAaEsL7zIUOaQj195NEDjXzFJ/Nuga/su
         JYLNTBaOwmI7qdugjJ4W6UjbOjrJCChP6zvd3yz1mwPjPH10+dd/IJWla35nlzjYmob+
         KKlmku5EM6Yh2fbrBqREiCExUoJHa59qJwlSI=
MIME-Version: 1.0
Received: by 10.220.98.65 with SMTP id p1mr687272vcn.103.1241014691275; Wed, 
	29 Apr 2009 07:18:11 -0700 (PDT)
In-Reply-To: <200904291512.19297.florian@openwrt.org>
References: <200904271659.48357.florian@openwrt.org>
	 <20090429115859.GA1487@linux-mips.org>
	 <200904291512.19297.florian@openwrt.org>
Date:	Wed, 29 Apr 2009 08:18:11 -0600
Message-ID: <b2b2f2320904290718pe9a28efy9a8af432887778cb@mail.gmail.com>
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e6471092d5a4ff0468b23f84
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e6471092d5a4ff0468b23f84
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:

On Wed, Apr 29, 2009 at 7:12 AM, Florian Fainelli <florian@openwrt.org>wrot=
e:

> Hi Ralf, Shane,
>
> Le Wednesday 29 April 2009 13:58:59 Ralf Baechle, vous avez =E9crit :
> > The whole irq chip thing in this file is looking suspect as it treats
> > acknowledging and mask an interrupt as the same thing.  Sure that is th=
e
> > right thing?
> That is a quick and dirty fix which compiles, I assumed that the function
> meant to be called is mask_msp_slp_irq, Shane probably knows more about h=
ow
> this should be fixed.


It's been quite a while since I messed around with the 4200.  I'll do some
digging and ask some questions of guys who probably know better.

Shane

--0016e6471092d5a4ff0468b23f84
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:<br><br>
<div class=3D"gmail_quote">On Wed, Apr 29, 2009 at 7:12 AM, Florian Fainell=
i <span dir=3D"ltr">&lt;<a href=3D"mailto:florian@openwrt.org">florian@open=
wrt.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Ralf, Shane,<br><br>Le Wednes=
day 29 April 2009 13:58:59 Ralf Baechle, vous avez =E9crit=A0:<br>
<div class=3D"im">&gt; The whole irq chip thing in this file is looking sus=
pect as it treats<br>&gt; acknowledging and mask an interrupt as the same t=
hing. =A0Sure that is the<br>&gt; right thing?<br></div>That is a quick and=
 dirty fix which compiles, I assumed that the function<br>
meant to be called is mask_msp_slp_irq, Shane probably knows more about how=
<br>this should be fixed.</blockquote>
<div>=A0</div>
<div>It&#39;s been quite a while since I messed around with=A0the 4200.=A0 =
I&#39;ll do some digging and ask some questions of guys who probably know b=
etter.</div>
<div>=A0</div>
<div>Shane</div></div>

--0016e6471092d5a4ff0468b23f84--
