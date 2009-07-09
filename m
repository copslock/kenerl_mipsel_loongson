Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2009 13:05:44 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.177]:50968 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493101AbZGILFg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2009 13:05:36 +0200
Received: by wa-out-1112.google.com with SMTP id n4so11823wag.0
        for <multiple recipients>; Thu, 09 Jul 2009 04:05:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Mb65i8yMfG8iQNJ125D/zw8+ELr3faFg+zmCEj9Mss8=;
        b=qLt7p17LZpTqE0zgy2oz0noHv03TW+/d474aOeipYKaTMwA9o768AvVWhVGLGuPE5E
         vHwwx811V28bhNNJfog2OJ7eh5LsaLg3EGUpUd3cEU1uj3jP/Pe85HTQqVEh3AvkwwqF
         NV8gn0hN3/EFYudWC8qPpG09oXPGJ+ADWRR+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uAyafFfFwPi2Y4ILFZ+FSTR+XCdEDuzOE5p3X2ThIoV6eLDHEOTLy6pZW2015lA+zH
         +dn5YqgCSXfbeDIf+tybHhtN910VX4iHgFwVfOgesiJpUDaLJGPoDdgnj4bTliOUjcdx
         b9E6mFq6cn77GFzLzWrUE7tWk/jfYPdjN5Iqg=
MIME-Version: 1.0
Received: by 10.114.95.19 with SMTP id s19mr311081wab.10.1247137530560; Thu, 
	09 Jul 2009 04:05:30 -0700 (PDT)
In-Reply-To: <20090708182906.GB31285@cuplxvomd02.corp.sa.net>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com>
	 <20090708103756.GB22308@linux-mips.org>
	 <4f9abdc70907080547l501128bg7c920e206e0068c3@mail.gmail.com>
	 <20090708182906.GB31285@cuplxvomd02.corp.sa.net>
Date:	Thu, 9 Jul 2009 16:35:30 +0530
Message-ID: <4f9abdc70907090405l4cd75251jbee5fbe123690e90@mail.gmail.com>
Subject: Re: Linux port failing on MIPS32 24Kc
From:	joe seb <joe.seb8@gmail.com>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00163646cb047ec73f046e43d533
Return-Path: <joe.seb8@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe.seb8@gmail.com
Precedence: bulk
X-list: linux-mips

--00163646cb047ec73f046e43d533
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi David, Ralf,

This is a new FPGA based platform which has MIPS 24k core and we are trying
to bring up linux on this. MIPS cpu is running at 50MHz.

Other than ram, we have UART available and its a 8250 compatible UART which
is connected to one of the HW interrupt line. The MIPS timer interrupt is
connected to HW4 interrupt line.  So in our platform file, we provide the
irq dispatch function for these two irq lines. There is no driver which uses
the DMA.

We did another experiment where we replaced init application with a memory
test code which malloc and run incremental pattern test on the allocated
memory and we see sometimes this test is failing. The failure is happening
for a cache line, when we dump ddr corresponding to that cache line, we see
that, that particular cache line is not flushed to ddr and all the other
cache lines are fine. So, not sure any issue with flushing the write-back.
We checked the linux code and did not see any place dcache is flushed for a
particular line, its always for a page(blast_dcache functions). Is our
finding correct?

Regards,
Joe

On Wed, Jul 8, 2009 at 11:59 PM, David VomLehn <dvomlehn@cisco.com> wrote:

> On Wed, Jul 08, 2009 at 06:17:42PM +0530, joe seb wrote:
> > Hi,
> >
> > We made the following changes and tried,
> >
> > -> applied the patch given by you.
> > -> changed the PHYS_OFFSET to 0x10000000 to match our memory offset.
> > -> cache write back mode enabled
> >
> > Still we face the same problem. It crashes at different points when it
> > enters the user space. I have attached one of the logs.
> >
> > But in cache write through mode it works.
>
> Another thought: if it works with write through, but not write back, you
> may have a device driver that isn't flushing/invalidating cache
> appropriately
> before doing DMA. This is much more important on MIPS than many other
> processors.
>
> Is this a new platform or one that has been working for a while?
>
> David VomLehn
>

--00163646cb047ec73f046e43d533
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi David, Ralf,</div>
<div>=A0</div>
<div>This is a new FPGA based platform which has MIPS 24k core and we are t=
rying to bring up linux on this. MIPS cpu is running at 50MHz. </div>
<div>=A0</div>
<div>Other than ram, we have UART available and its a 8250 compatible UART =
which is connected to one of the HW interrupt line. The MIPS timer interrup=
t is connected to HW4 interrupt line.=A0 So in our platform file, we provid=
e the irq dispatch=A0function for=A0these two irq lines. There is no driver=
 which uses the DMA. </div>

<div>=A0</div>
<div>We did=A0another experiment where we replaced init application with a =
memory test code which malloc and run incremental pattern test on the alloc=
ated memory and we see sometimes this test is failing. The failure is happe=
ning for a cache line, when we dump ddr corresponding to that cache line, w=
e see that, that particular=A0cache line is not flushed to ddr and all the =
other cache lines are fine. So, not sure any issue with flushing the write-=
back. We checked the linux code and did not see any place dcache is flushed=
 for a particular line, its always for a page(blast_dcache functions). Is o=
ur finding correct? </div>

<div>=A0</div>
<div>Regards,</div>
<div>Joe<br><br></div>
<div class=3D"gmail_quote">On Wed, Jul 8, 2009 at 11:59 PM, David VomLehn <=
span dir=3D"ltr">&lt;<a href=3D"mailto:dvomlehn@cisco.com">dvomlehn@cisco.c=
om</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Wed, Jul 08, 2009 at 06:17:42PM +0530, joe seb wrote:<=
br>&gt; Hi,<br>&gt;<br>&gt; We made the following changes and tried,<br>&gt=
;<br>&gt; -&gt; applied the patch given by you.<br>&gt; -&gt; changed the P=
HYS_OFFSET to 0x10000000 to match our memory offset.<br>
&gt; -&gt; cache write back mode enabled<br>&gt;<br>&gt; Still we face the =
same problem. It crashes at different points when it<br>&gt; enters the use=
r space. I have attached one of the logs.<br>&gt;<br>&gt; But in cache writ=
e through mode it works.<br>
<br></div>Another thought: if it works with write through, but not write ba=
ck, you<br>may have a device driver that isn&#39;t flushing/invalidating ca=
che appropriately<br>before doing DMA. This is much more important on MIPS =
than many other<br>
processors.<br><br>Is this a new platform or one that has been working for =
a while?<br><font color=3D"#888888"><br>David VomLehn<br></font></blockquot=
e></div><br>

--00163646cb047ec73f046e43d533--
