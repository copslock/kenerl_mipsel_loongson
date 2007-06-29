Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 03:26:41 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.191]:10975 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022796AbXF2C0g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Jun 2007 03:26:36 +0100
Received: by mu-out-0910.google.com with SMTP id w1so802164mue
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 19:26:25 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=T0NuEmgX7/xwnq+TKxoRICXUd+jHiqL/PUgF7pWOg7UqklXFTQYokExW7Me3ZTJgQQWuyVAgAD41w+Dx/ggRpQJD/YS5hqKVMXzeby/jzLBYJPp1ga/ElS5eGzjRVuVPX0N98eBm9lW656AZM7BpsnWQ1F2PMizeXlhSNg0DVx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=Uenn9m70nS6aMUa+C/72DY368NVO1el6GfKz6JTpBaWS93S2I0JfAG0ikb1GRA45Q2+mA5uPnuxSGYLR27bO00xLt/RWcvItHEzeqT0Ni59/4B1O0oNp7tkQfcHJQMwFSEDpWxksDwm03VBBhUcqo83OQTcGX5BaEsTEzGCKdyg=
Received: by 10.82.134.12 with SMTP id h12mr5186084bud.1183083985798;
        Thu, 28 Jun 2007 19:26:25 -0700 (PDT)
Received: by 10.82.122.10 with HTTP; Thu, 28 Jun 2007 19:26:25 -0700 (PDT)
Message-ID: <33086a290706281926w6238f684rbbee79bb108f1d10@mail.gmail.com>
Date:	Thu, 28 Jun 2007 21:26:25 -0500
From:	"Jason Talley" <jbtalley98@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: upgrading glibc for mipsel
In-Reply-To: <4684685E.4090805@avtrex.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_57374_23866250.1183083985777"
References: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com>
	 <20070627.013312.25479645.anemo@mba.ocn.ne.jp>
	 <20070627153932.GA6016@lst.de>
	 <20070628.112223.96686654.nemoto@toshiba-tops.co.jp>
	 <20070628083725.GA23394@lst.de>
	 <27801B4D04E7CA45825B0E0CE60FE10A0410F0D6@xmb-sjc-237.amer.cisco.com>
	 <46842B05.5050103@avtrex.com>
	 <27801B4D04E7CA45825B0E0CE60FE10A01F971CF@xmb-sjc-237.amer.cisco.com>
	 <4684685E.4090805@avtrex.com>
Return-Path: <jbtalley98@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbtalley98@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_57374_23866250.1183083985777
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I used crosstool to build gcc3.4.5 w/ glibc 2.3.6, linux-headers 2.6.12, and
linuxthreads 2.3.6

We've been using this for a couple of months and haven't run across any
major issues.
Good luck.

On 6/28/07, David Daney <ddaney@avtrex.com> wrote:
>
> Ratin Rahman (mratin) wrote:
> > In an effort to build gdbserver, I am trying to upgrade my glibc and
> > gcc cross compile tools. I am  having
> > problem while bulding glibc-2.3.3, mipsel compiler version 3.2.3 and
> > current glibc ver
> > is 2.2.5.
> >
>
> Stock glibc-2.3.3 will not work on mipsel-linux.  I posted the patch I
> use few years ago to this list.  You could try with that patch.  Or look
> at the cross-tool project.  Some people have had success using it to
> build toolchains.
>
> David Daney
>
>

------=_Part_57374_23866250.1183083985777
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I used crosstool to build gcc3.4.5 w/ glibc 2.3.6, linux-headers 2.6.12, and linuxthreads 2.3.6<br><br>We&#39;ve been using this for a couple of months and haven&#39;t run across any major issues.<br>Good luck.<br><br><div>
<span class="gmail_quote">On 6/28/07, <b class="gmail_sendername">David Daney</b> &lt;<a href="mailto:ddaney@avtrex.com">ddaney@avtrex.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ratin Rahman (mratin) wrote:<br>&gt; In an effort to build gdbserver, I am trying to upgrade my glibc and<br>&gt; gcc cross compile tools. I am&nbsp;&nbsp;having<br>&gt; problem while bulding glibc-2.3.3, mipsel compiler version 3.2.3
 and<br>&gt; current glibc ver<br>&gt; is 2.2.5.<br>&gt;<br><br>Stock glibc-2.3.3 will not work on mipsel-linux.&nbsp;&nbsp;I posted the patch I<br>use few years ago to this list.&nbsp;&nbsp;You could try with that patch.&nbsp;&nbsp;Or look<br>at the cross-tool project.&nbsp;&nbsp;Some people have had success using it to
<br>build toolchains.<br><br>David Daney<br><br></blockquote></div><br>

------=_Part_57374_23866250.1183083985777--
