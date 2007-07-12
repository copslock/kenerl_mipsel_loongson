Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 03:14:50 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.177]:6229 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022110AbXGLCOs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 03:14:48 +0100
Received: by wa-out-1112.google.com with SMTP id m16so3808waf
        for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 19:14:36 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=kEN/QYDcrM/18WCxmGUhMRWWkNliEhqTxY+oW+MhVEYMyIpusVj/gf8aGrd2r9HcaSJAFn3JaFpH6mNY9tFb0hlWbdtIRZtbATAc3JbU+P7Hq20HdIKcxL3MPqemYOIJFfU5jbP7MKWzNnp9ePUBO0sgFS18NjewHJiNT1yiPQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=hr3WmL5hXUOt1Ff6MIvLr7lxwi6atMaNIH5EhIjm0pAlq3C19Uxe8/RrTpcx7m+STfK4f4aYGyjfhoiJstpvNJhI66H3WekwVZV9j24i/ftU0yq+1449DkGNALt/t4SuDjWtdwfUcptMYTUfH9CFRgMKde4AG4BFh6RouMWl4Jk=
Received: by 10.114.181.1 with SMTP id d1mr128435waf.1184206476520;
        Wed, 11 Jul 2007 19:14:36 -0700 (PDT)
Received: by 10.114.110.6 with HTTP; Wed, 11 Jul 2007 19:14:36 -0700 (PDT)
Message-ID: <b2b2f2320707111914t5ac80d24ie374999e35db4c8f@mail.gmail.com>
Date:	Wed, 11 Jul 2007 20:14:36 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	"Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: latest list of apparently "dead" CONFIG variables under arch/mips
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.64.0707111901110.28156@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12982_20581381.1184206476493"
References: <Pine.LNX.4.64.0707111437480.12345@localhost.localdomain>
	 <b2b2f2320707111546p5b7e1c6dv60a8d600a28634e7@mail.gmail.com>
	 <Pine.LNX.4.64.0707111901110.28156@localhost.localdomain>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_12982_20581381.1184206476493
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert:

  Maybe I should have gone into more detail in my initial response.

  There's a patch posted to the i2c mailing list that adds CONFIG_PMCTWILED
into drivers/i2c/chips/Kconfig.  It probably hasn't been accepted yet, so
that's why it's not showing up in any Kconfig on l-m.o.  The patch shows up
here: http://lists.lm-sensors.org/pipermail/i2c/2007-March/001003.html.

  I don't know why they have defined CONFIG_SQUASHFS in their defconfig,
although I believe their distribution includes squashfs patches.  Their
patch to define the defconfig seems to include it--the reason why is
probably a question for the original patch:
http://www.linux-mips.org/archives/linux-mips/2007-06/msg00197.html.

  And I knew you weren't claiming those CONFIG_s were junk :-); I'm sorry
that it came off sounding that way!

Shane

On 7/11/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
>
> On Wed, 11 Jul 2007, Shane McDonald wrote:
>
> > The following are not "just pure junk", as PMC-Sierra is working on
> > providing acceptable code that supports their MSP71xx processors.
> > Patches to remove these are not required!
> >
> > On 7/11/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
> > >
> > > ========== PMCTWILED ==========
> > > arch/mips/configs/msp71xx_defconfig:941:CONFIG_PMCTWILED=y
> > > arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:35:#ifdef CONFIG_PMCTWILED
> > > arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:85:#ifdef CONFIG_PMCTWILED
> > > arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:97:#ifdef CONFIG_PMCTWILED
> > > arch/mips/pmc-sierra/msp71xx/msp_setup.c:249:#ifdef CONFIG_PMCTWILED
> > > ========== SQUASHFS ==========
> > > arch/mips/configs/msp71xx_defconfig:1307:CONFIG_SQUASHFS=y
> > > arch/mips/pmc-sierra/msp71xx/msp_prom.c:46:#ifdef CONFIG_SQUASHFS
> > > arch/mips/pmc-sierra/msp71xx/msp_prom.c:552:#ifdef CONFIG_SQUASHFS
> > > arch/mips/pmc-sierra/msp71xx/msp_prom.c:554:            /* Get
> SQUASHFS
> > > size */
>
> i never *claimed* that they were junk, i was *asking* what was junk
> since, typically, there's little value in testing preprocessor
> variables if they aren't defined in a Kconfig file somewhere.  and if
> something is not defined in a Kconfig file, it's generally a bad
> choice to name it with a "CONFIG_" prefix.
>
> in addition, i'm not sure what's going on with that SQUASHFS test,
> since squashfs is not part of the kernel source tree, so what you're
> testing for there is a mystery.
>
> rday
> --
> ========================================================================
> Robert P. J. Day
> Linux Consulting, Training and Annoying Kernel Pedantry
> Waterloo, Ontario, CANADA
>
> http://fsdev.net/wiki/index.php?title=Main_Page
> ========================================================================
>

------=_Part_12982_20581381.1184206476493
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert:<br><br>&nbsp; Maybe I should have gone into more detail in my initial response.<br><br>&nbsp; There&#39;s a patch posted to the i2c mailing list that adds CONFIG_PMCTWILED into drivers/i2c/chips/Kconfig.&nbsp; It probably hasn&#39;t been accepted yet, so that&#39;s why it&#39;s not showing up in any Kconfig on 
l-m.o.&nbsp; The patch shows up here: <a href="http://lists.lm-sensors.org/pipermail/i2c/2007-March/001003.html">http://lists.lm-sensors.org/pipermail/i2c/2007-March/001003.html</a>.<br><br>&nbsp; I don&#39;t know why they have defined CONFIG_SQUASHFS in their defconfig, although I believe their distribution includes squashfs patches.&nbsp; Their patch to define the defconfig seems to include it--the reason why is probably a question for the original patch: 
<a href="http://www.linux-mips.org/archives/linux-mips/2007-06/msg00197.html">http://www.linux-mips.org/archives/linux-mips/2007-06/msg00197.html</a>.<br><br>&nbsp; And I knew you weren&#39;t claiming those CONFIG_s were junk :-); I&#39;m sorry that it came off sounding that way!
<br><br>Shane<br><br><div><span class="gmail_quote">On 7/11/07, <b class="gmail_sendername">Robert P. J. Day</b> &lt;<a href="mailto:rpjday@mindspring.com">rpjday@mindspring.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, 11 Jul 2007, Shane McDonald wrote:<br><br>&gt; The following are not &quot;just pure junk&quot;, as PMC-Sierra is working on<br>&gt; providing acceptable code that supports their MSP71xx processors.<br>&gt; Patches to remove these are not required!
<br>&gt;<br>&gt; On 7/11/07, Robert P. J. Day &lt;<a href="mailto:rpjday@mindspring.com">rpjday@mindspring.com</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; ========== PMCTWILED ==========<br>&gt; &gt; arch/mips/configs/msp71xx_defconfig:941:CONFIG_PMCTWILED=y
<br>&gt; &gt; arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:35:#ifdef CONFIG_PMCTWILED<br>&gt; &gt; arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:85:#ifdef CONFIG_PMCTWILED<br>&gt; &gt; arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:97:#ifdef CONFIG_PMCTWILED
<br>&gt; &gt; arch/mips/pmc-sierra/msp71xx/msp_setup.c:249:#ifdef CONFIG_PMCTWILED<br>&gt; &gt; ========== SQUASHFS ==========<br>&gt; &gt; arch/mips/configs/msp71xx_defconfig:1307:CONFIG_SQUASHFS=y<br>&gt; &gt; arch/mips/pmc-sierra/msp71xx/msp_prom.c:46:#ifdef CONFIG_SQUASHFS
<br>&gt; &gt; arch/mips/pmc-sierra/msp71xx/msp_prom.c:552:#ifdef CONFIG_SQUASHFS<br>&gt; &gt; arch/mips/pmc-sierra/msp71xx/msp_prom.c:554:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Get SQUASHFS<br>&gt; &gt; size */<br><br>i never *claimed* that they were junk, i was *asking* what was junk
<br>since, typically, there&#39;s little value in testing preprocessor<br>variables if they aren&#39;t defined in a Kconfig file somewhere.&nbsp;&nbsp;and if<br>something is not defined in a Kconfig file, it&#39;s generally a bad<br>
choice to name it with a &quot;CONFIG_&quot; prefix.<br><br>in addition, i&#39;m not sure what&#39;s going on with that SQUASHFS test,<br>since squashfs is not part of the kernel source tree, so what you&#39;re<br>testing for there is a mystery.
<br><br>rday<br>--<br>========================================================================<br>Robert P. J. Day<br>Linux Consulting, Training and Annoying Kernel Pedantry<br>Waterloo, Ontario, CANADA<br><br><a href="http://fsdev.net/wiki/index.php?title=Main_Page">
http://fsdev.net/wiki/index.php?title=Main_Page</a><br>========================================================================<br></blockquote></div><br>

------=_Part_12982_20581381.1184206476493--
