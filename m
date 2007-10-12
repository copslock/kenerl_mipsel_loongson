Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 19:12:21 +0100 (BST)
Received: from adicia.telenet-ops.be ([195.130.132.56]:30854 "EHLO
	adicia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20031097AbXJLSMM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 19:12:12 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id D43482300E3
	for <linux-mips@linux-mips.org>; Fri, 12 Oct 2007 20:12:01 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 6B5D02300AB
	for <linux-mips@linux-mips.org>; Fri, 12 Oct 2007 20:12:01 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9CIC1PX015960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-mips@linux-mips.org>; Fri, 12 Oct 2007 20:12:01 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9CIC13q015957
	for <linux-mips@linux-mips.org>; Fri, 12 Oct 2007 20:12:01 +0200
X-Return-Path: <share.kt@gmail.com>
X-Received: from anakin (fetchmail@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9CFDo2U013883
	for <geert@localhost>; Fri, 12 Oct 2007 17:13:55 +0200
X-X-Delivered-To: Geert.Uytterhoeven@telenet.be
X-Received: from pop.telenet.be [195.130.132.42]
	by anakin with POP3 (fetchmail-6.3.8)
	for <geert@localhost> (single-drop);
	Fri, 12 Oct 2007 17:13:55 +0200 (CEST)
X-Received: (qmail 23555 invoked from network); 12 Oct 2007 15:12:40 -0000
X-Received: from hoboi2bl5.telenet-ops.be ([195.130.137.88])
	(envelope-sender <share.kt@gmail.com>)
	by kreusa.telenet-ops.be (qmail-ldap-1.03) with SMTP
	for <Geert.Uytterhoeven@telenet.be>; 12 Oct 2007 15:12:40 -0000
X-Received: from asok.telenet-ops.be (asok.telenet-ops.be [195.130.137.83])
	by hoboi2bl5.telenet-ops.be (8.13.1/8.13.1) with ESMTP id
	l9CFCcO6027024
	for <Geert.Uytterhoeven@telenet.be>; Fri, 12 Oct 2007 17:12:39 +0200
X-Received: from localhost (localhost.localdomain [127.0.0.1])
	by asok.telenet-ops.be (Postfix) with SMTP id BAA8FE392A
	for <Geert.Uytterhoeven@telenet.be>;
	Fri, 12 Oct 2007 17:12:39 +0200 (CEST)
X-Received: from pan.telenet-ops.be (pan.telenet-ops.be [195.130.132.38])
	by asok.telenet-ops.be (Postfix) with ESMTP id ADE1BE3967
	for <Geert.Uytterhoeven@telenet.be>;
	Fri, 12 Oct 2007 17:12:39 +0200 (CEST)
X-Received: from nerdnet.nl (ns1.nerdnet.nl [217.170.15.1])
	by pan.telenet-ops.be (Postfix) with ESMTP id DE61ACB9E3
	for <Geert.Uytterhoeven@telenet.be>;
	Fri, 12 Oct 2007 17:12:36 +0200 (CEST)
X-Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by nerdnet.nl (8.13.8/8.13.8/Debian-2) with ESMTP id l9CEuSd8019812
	for <geert@linux-m68k.org>; Fri, 12 Oct 2007 16:56:28 +0200
X-Received: by py-out-1112.google.com with SMTP id p76so1705564pyb
	for <geert@linux-m68k.org>; Fri, 12 Oct 2007 07:56:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
	bh=44MSdf5+IVIPme0ie5pzQ+LRhRFgsVs1MD5J1q8s4Vs=;
	b=U2UZ9oiXvMfqoTnWe6Iz1QHmo4SHBBq3YIBd46/f8Rf0L5PnEaKgsun4Jx97ktOz3M4lXHqoWX21Nm19n03SLCIsrn2QX3mxsdt4VD8RC+gNKzgWYAIod1A2CMwHei7nYOJm6uuh31DJ1WNizdjI/wgAYf5N+lqfN7vM02fppPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=beta;
	h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
	b=Uxl2Hq8qZ+QZ00WnAdn+EkhEg2sud6JHyPWuNB4zJVR2dPzcjIbsz1OXBtjgUvslOqqOwihU94/qIGdvQBJZyTo/gkm9l70TxJldZfXhnwfkekUbc4Ebad5ubwJ3cUcMudnTQLZR/WibIDt9A+CHGvWH+hNdXd5b7QASPXyHKow=
X-Received: by 10.35.51.19 with SMTP id d19mr3713514pyk.1192200986460;
	Fri, 12 Oct 2007 07:56:26 -0700 (PDT)
X-Received: by 10.35.39.19 with HTTP; Fri, 12 Oct 2007 07:56:26 -0700 (PDT)
Message-ID: <eea8a9c90710120756j7fb633fdjfc9704c447133a05@mail.gmail.com>
Date:	Fri, 12 Oct 2007 20:26:26 +0530
From:	kaka <share.kt@gmail.com>
To:	"Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: Unknown symbol register_framebuffer
In-Reply-To: <Pine.LNX.4.64.0710121513560.7335@anakin>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_64234_7670235.1192200986451"
References: <eea8a9c90710120551x66311e20pfd639edb9daf68fc@mail.gmail.com>
	<Pine.LNX.4.64.0710121513560.7335@anakin>
X-Virus-Scanned: ClamAV version 0.90,
	clamav-milter version devel-120207 on nerdcentral
X-Virus-Status:	Clean
X-SpamCatcher-Score: 40 [XX]
X-Spambayes-Classification: ham; 0.00
ReSent-Date: Fri, 12 Oct 2007 20:11:54 +0200 (CEST)
Resent-From: Geert Uytterhoeven <geert@linux-m68k.org>
Resent-To: Linux/MIPS Development <linux-mips@linux-mips.org>
ReSent-Subject:	Re: Unknown symbol register_framebuffer
ReSent-Message-ID: <Pine.LNX.4.64.0710122011540.15951@anakin>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

------=_Part_64234_7670235.1192200986451
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Geert,

Thanks for the reply.
Actually we are the writer of the device driver file.
We don't have any supplier.
Although we have all the library and .so files.
But it is not able to find the above mentioned symbols in the kernel table.
COuld you plz let us know how to link the kernel symbol so that the KLM
brcmstfb.ko can find the symbols?

Thanks & Regards,
kaka


On 10/12/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Fri, 12 Oct 2007, kaka wrote:
> > > WHile installing framebuffer driver for BCM chip in MIPS
> platform(cross
> > > compiled in intel 86).
> > > I am getting the following error.
> > >
> >
> > Since it is cross compiled and running on MIPS platform, the linux
> doesn't
> > support modinfo command to find the dependencies.
>
> Really? I just tried `modinfo' of an ia32 box on a cross-compiled module
> for a ppc64 box, and it worked fine.
>
> > > # insmod brcmstfb.ko
> > > brcmstfb: Unknown symbol unregister_framebuffer
> > > brcmstfb: Unknown symbol printf
> > > brcmstfb: Unknown symbol __make_dp
> > > brcmstfb: Unknown symbol malloc
> > > brcmstfb: Unknown symbol framebuffer_alloc
> > > brcmstfb: Unknown symbol fb_find_mode
> > > brcmstfb: Unknown symbol fb_dealloc_cmap
> > > brcmstfb: Unknown symbol brcm_dir_entry
> > > brcmstfb: Unknown symbol register_framebuffer
> > > brcmstfb: Unknown symbol fb_alloc_cmap
> > > brcmstfb: Unknown symbol framebuffer_release
> > > brcmstfb: Unknown symbol free
>
> As mentioned before, please talk to the supplier of your module about
> these
> references to `printf', `malloc', and `free'.
>
> Gr{oetje,eeting}s,
>
>                                                Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                                            -- Linus
> Torvalds
>



-- 
Thanks & Regards,
kaka

------=_Part_64234_7670235.1192200986451
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Geert,</div>
<div>&nbsp;</div>
<div>Thanks for the reply.</div>
<div>Actually we are the writer of the device driver file.</div>
<div>We don&#39;t have any supplier.</div>
<div>Although we have all the library and .so files.</div>
<div>But it is not able to find the above mentioned symbols in the kernel table.</div>
<div>COuld you plz let us know how to link the kernel symbol so that the KLM brcmstfb.ko can find the symbols?</div>
<div>&nbsp;</div>
<div>Thanks &amp; Regards,<br>kaka <br><br>&nbsp;</div>
<div><span class="gmail_quote">On 10/12/07, <b class="gmail_sendername">Geert Uytterhoeven</b> &lt;<a href="mailto:geert@linux-m68k.org">geert@linux-m68k.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Fri, 12 Oct 2007, kaka wrote:<br>&gt; &gt; WHile installing framebuffer driver for BCM chip in MIPS platform(cross
<br>&gt; &gt; compiled in intel 86).<br>&gt; &gt; I am getting the following error.<br>&gt; &gt;<br>&gt;<br>&gt; Since it is cross compiled and running on MIPS platform, the linux doesn&#39;t<br>&gt; support modinfo command to find the dependencies.
<br><br>Really? I just tried `modinfo&#39; of an ia32 box on a cross-compiled module<br>for a ppc64 box, and it worked fine.<br><br>&gt; &gt; # insmod brcmstfb.ko<br>&gt; &gt; brcmstfb: Unknown symbol unregister_framebuffer
<br>&gt; &gt; brcmstfb: Unknown symbol printf<br>&gt; &gt; brcmstfb: Unknown symbol __make_dp<br>&gt; &gt; brcmstfb: Unknown symbol malloc<br>&gt; &gt; brcmstfb: Unknown symbol framebuffer_alloc<br>&gt; &gt; brcmstfb: Unknown symbol fb_find_mode
<br>&gt; &gt; brcmstfb: Unknown symbol fb_dealloc_cmap<br>&gt; &gt; brcmstfb: Unknown symbol brcm_dir_entry<br>&gt; &gt; brcmstfb: Unknown symbol register_framebuffer<br>&gt; &gt; brcmstfb: Unknown symbol fb_alloc_cmap<br>
&gt; &gt; brcmstfb: Unknown symbol framebuffer_release<br>&gt; &gt; brcmstfb: Unknown symbol free<br><br>As mentioned before, please talk to the supplier of your module about these<br>references to `printf&#39;, `malloc&#39;, and `free&#39;.
<br><br>Gr{oetje,eeting}s,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Geert<br><br>--<br>Geert Uytterhoeven -- There&#39;s lots of Linux beyond ia32 -- <a href="mailto:geert@linux-m68k.org">geert@linux-m68k.org
</a><br><br>In personal conversations with technical people, I call myself a hacker. But<br>when I&#39;m talking to journalists I just say &quot;programmer&quot; or something like that.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- Linus Torvalds
<br></blockquote></div><br><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_64234_7670235.1192200986451--
