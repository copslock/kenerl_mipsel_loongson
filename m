Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 14:32:57 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.238]:57313 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039218AbWI2Ncy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 14:32:54 +0100
Received: by wr-out-0506.google.com with SMTP id i20so280182wra
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 06:32:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=uYkFcsWwhiVfp07EX5GOGnqsNDddh26fg8mqwXZIfbYA0wAewpcurrx70v45OBIZ6zRkIU+/vBwNUbDK89XQ8xpPwPPFa5kviKtvggoUf7kk/I9oBnFNI2j0IVgNXoglOatpkcmdsf6Z7KIB82ZS5jCwFShfcGA1Ae8hxHuUMkI=
Received: by 10.90.83.14 with SMTP id g14mr1419313agb;
        Fri, 29 Sep 2006 06:32:52 -0700 (PDT)
Received: by 10.90.31.10 with HTTP; Fri, 29 Sep 2006 06:32:52 -0700 (PDT)
Message-ID: <5ee285ba0609290632m6c5e3f35nbae45307a3398b86@mail.gmail.com>
Date:	Fri, 29 Sep 2006 21:32:52 +0800
From:	"David Lee" <receive4me@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: HELP: opcode not supported on this processor
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060929110849.GD3868@networkno.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8308_19815225.1159536772904"
References: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
	 <20060929110849.GD3868@networkno.de>
Return-Path: <receive4me@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: receive4me@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_8308_19815225.1159536772904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I could not figure it out in more than 2 hours. I don't even know what
compliantion options used for kernel. I need more instructions and help.

Thanks.
David

On 9/29/06, Thiemo Seufer <ths@networkno.de> wrote:
>
> David Lee wrote:
> > Hi,
> >
> > I am trying to port some code over to MIPSEL from i386. However, I got
> the
> > following error:
> >
> > gcc -I/usr/include -O6 -DMODULE -D__KERNEL__ -DEXPORT_SYMTAB
> > -I/usr/src/linux/drivers/net -Wal
> > l -I. -Wstrict-prototypes -fomit-frame-pointer
> > -I/usr/src/linux/drivers/net/wan -I /usr/src/li
> > nux/include -I/usr/src/linux/include/net -DMODVERSIONS -include
> > /usr/src/linux-2.4/include/lin
> > ux/modversions.h  zip.c
>
> You need to use the exactly same compilation options as used for the
> kernel. This will fix the problem you see, plus many others you haven't
> seen yet.
>
>
> Thiemo
>

------=_Part_8308_19815225.1159536772904
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I could not figure it out in more than 2 hours. I don't even know what compliantion options used for kernel.&nbsp;I need more instructions and help.<br>&nbsp;</div>
<div>Thanks.</div>
<div>David<br>&nbsp;</div>
<div><span class="gmail_quote">On 9/29/06, <b class="gmail_sendername">Thiemo Seufer</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:ths@networkno.de" target="_blank">ths@networkno.de</a>&gt; wrote:
</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">David Lee wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I am trying to port some code over to MIPSEL from i386. However, I got the 
<br>&gt; following error:<br>&gt;<br>&gt; gcc -I/usr/include -O6 -DMODULE -D__KERNEL__ -DEXPORT_SYMTAB<br>&gt; -I/usr/src/linux/drivers/net -Wal<br>&gt; l -I. -Wstrict-prototypes -fomit-frame-pointer<br>&gt; -I/usr/src/linux/drivers/net/wan -I /usr/src/li 
<br>&gt; nux/include -I/usr/src/linux/include/net -DMODVERSIONS -include<br>&gt; /usr/src/linux-2.4/include/lin<br>&gt; ux/modversions.h&nbsp;&nbsp;zip.c<br><br>You need to use the exactly same compilation options as used for the<br>
kernel. This will fix the problem you see, plus many others you haven't<br>seen yet.<br><br><br>Thiemo<br></blockquote></div><br>

------=_Part_8308_19815225.1159536772904--
