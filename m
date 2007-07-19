Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 23:27:24 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:18140 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022645AbXGSW1W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 23:27:22 +0100
Received: by wa-out-1112.google.com with SMTP id m16so777971waf
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 15:27:00 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=O0C3yQBkzspbxbpaW9729tZjS+uaSE1TtPyNEiQroVjZigOaEHWYZy02btpZ4RKdimvkLR5FIPXS18Ic3Uf/UqDHy1jNw11IIbcweMbdGstNQQZQ/UCIFmKwF1AcTAQ2dSaAcdMwRGrXqUSGEGsu00VuVg2EUSy3db9isPHvCko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=iDY7gGscW1uUm1AspOKh2tJMIJtEG2TqqEbqResPV8tJC2ydkgVvH5fXsLEcDG3/w4Arq84x4aJPsB+jAlFSeERtz+OMCGHlv2pos+to7FFVTZislPGNlCL2M9T757UkN8QgWoYdCRqJnNVCNzrhlYCX1eYkj//hp1o5JVRA4A8=
Received: by 10.114.37.1 with SMTP id k1mr2122498wak.1184884019901;
        Thu, 19 Jul 2007 15:26:59 -0700 (PDT)
Received: by 10.114.110.6 with HTTP; Thu, 19 Jul 2007 15:26:59 -0700 (PDT)
Message-ID: <b2b2f2320707191526y4b505e66q51fb2e4bf1dc991f@mail.gmail.com>
Date:	Thu, 19 Jul 2007 16:26:59 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	"Andrew Sharp" <andy.sharp@onstor.com>
Subject: Re: O2 RM7000 Issues
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
In-Reply-To: <20070719115822.027a8891@ripper.onstor.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_117275_8138886.1184884019867"
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net>
	 <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu>
	 <20070704152729.GA2925@linux-mips.org>
	 <20070704192208.GA7873@linux-mips.org> <469B5C2E.5080905@niisi.msk.ru>
	 <20070716123343.GA13439@linux-mips.org>
	 <20070716103823.3fe9aef4@ripper.onstor.net>
	 <469CCBB4.60005@gentoo.org>
	 <20070719115822.027a8891@ripper.onstor.net>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_117275_8138886.1184884019867
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have been having similar problems to Andrew and Kumba on my setup -- a
PMC-Sierra Xiao Hu thin client computer (RM7035C based) running Debian etch
with a PMC 2.6.18 kernel.  Running large complicated shell scripts, such as
inetutils' configure script, consistently dies on (usually) an illegal
instruction, but always in a different place.  I've just added my machine to
the ICACHE_REFILLS_WORKAROUND_WAR, and that seems to have fixed it.

I also tried adding in Ralf's rm7k_wait_irqoff() patch, but it didn't
improve things, although it didn't appear to break anything, either.  Is
there some behaviour I should be looking for to notice if WAIT is / isn't
working on my platform?

Shane

On 7/19/07, Andrew Sharp <andy.sharp@onstor.com> wrote:
>
> On Tue, 17 Jul 2007 10:01:24 -0400 Kumba <kumba@gentoo.org> wrote:
>
> > Andrew Sharp wrote:
> > >
> > > I hungrily await said patch, as I believe this is a problem on
> > > RM9000 processors as well.  I'm seeing "random" SIGILLs on user
> > > processes, particularly large complicated shell scripts like
> > > configure on an RM9k platform.
> >
> > This was more or less exactly what I was seeing on an O2 RM7000 setup
> > until the fix for errata #28 was put in (which should already be
> > enabled for RM9000 systems).
> >
> > Check include/asm-mips/war.h and make sure your machine is included
> > in the list that define ICACHE_REFILLS_WORKAROUND_WAR.  If not, add
> > it and test; and fire off a patch.  Should fix that issue (especially
> > if bash is the only userland process dying while complex g++ compiles
> > behave fine)
>
> Thanks, I had added this about a month ago, but the l-users were
> reporting that the problem persisted.  Now that I've had a chance to
> examine it myself, it appears they were confused.  There's a first time
> for everything.
>
> I will be sending some patches to be sure, once I get all the bugs
> worked out.  This architecture, a bifurcated RM9000x2 together with a
> marvell south bridge, is a searing pain I have to deal with daily.
>
> Cheers,
>
> a
>
>

------=_Part_117275_8138886.1184884019867
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have been having similar problems to Andrew and Kumba on my setup -- a PMC-Sierra Xiao Hu thin client computer (RM7035C based) running Debian etch with a PMC 2.6.18 kernel.&nbsp; Running large complicated shell scripts, such as inetutils&#39; configure script, consistently dies on (usually) an illegal instruction, but always in a different place.&nbsp; I&#39;ve just added my machine to the ICACHE_REFILLS_WORKAROUND_WAR, and that seems to have fixed it.
<br><br>I also tried adding in Ralf&#39;s rm7k_wait_irqoff() patch, but it didn&#39;t improve things, although it didn&#39;t appear to break anything, either.&nbsp; Is there some behaviour I should be looking for to notice if WAIT is / isn&#39;t working on my platform?
<br><br>Shane<br><br><div><span class="gmail_quote">On 7/19/07, <b class="gmail_sendername">Andrew Sharp</b> &lt;<a href="mailto:andy.sharp@onstor.com">andy.sharp@onstor.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 17 Jul 2007 10:01:24 -0400 Kumba &lt;<a href="mailto:kumba@gentoo.org">kumba@gentoo.org</a>&gt; wrote:<br><br>&gt; Andrew Sharp wrote:<br>&gt; &gt;<br>&gt; &gt; I hungrily await said patch, as I believe this is a problem on
<br>&gt; &gt; RM9000 processors as well.&nbsp;&nbsp;I&#39;m seeing &quot;random&quot; SIGILLs on user<br>&gt; &gt; processes, particularly large complicated shell scripts like<br>&gt; &gt; configure on an RM9k platform.<br>&gt;<br>
&gt; This was more or less exactly what I was seeing on an O2 RM7000 setup<br>&gt; until the fix for errata #28 was put in (which should already be<br>&gt; enabled for RM9000 systems).<br>&gt;<br>&gt; Check include/asm-mips/war.h and make sure your machine is included
<br>&gt; in the list that define ICACHE_REFILLS_WORKAROUND_WAR.&nbsp;&nbsp;If not, add<br>&gt; it and test; and fire off a patch.&nbsp;&nbsp;Should fix that issue (especially<br>&gt; if bash is the only userland process dying while complex g++ compiles
<br>&gt; behave fine)<br><br>Thanks, I had added this about a month ago, but the l-users were<br>reporting that the problem persisted.&nbsp;&nbsp;Now that I&#39;ve had a chance to<br>examine it myself, it appears they were confused.&nbsp;&nbsp;There&#39;s a first time
<br>for everything.<br><br>I will be sending some patches to be sure, once I get all the bugs<br>worked out.&nbsp;&nbsp;This architecture, a bifurcated RM9000x2 together with a<br>marvell south bridge, is a searing pain I have to deal with daily.
<br><br>Cheers,<br><br>a<br><br></blockquote></div><br>

------=_Part_117275_8138886.1184884019867--
