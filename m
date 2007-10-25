Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 15:16:50 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.227]:20784 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022628AbXJYOQl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 15:16:41 +0100
Received: by wr-out-0506.google.com with SMTP id 69so422143wri
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 07:15:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=QNHZMY080ohFQ8TUqgFgJ8LM6J1KNhQH9CcnjKFYHfc=;
        b=VLHBDGr6UkJ28qOqD8fwTiOwesUuWbVRsuolreKzquAv+sLlnezmMjIC9+jscOb4yfnq7KszLveHNXfzO95X/VtXpI0XnB0h4XPpiOZAUozDfi4xN0YfSCPa50081vT2jlJ84fn8sqU6zYmvnyAGhT5tkOqG7ulswxrVBUdejGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=IZVhQQbkdPIrU2TMVkryRSK4fYGMtekoWH92lU1Y++tN7T0BiNc6Yp52LF03vWyeJafnPBDIpCmIJfBpeSczVymdLeVobRobT9o+NaOBGzxPzZUThYzTunKUXVu9nSgz5GWr+FDWgWT4dsDHfag7tP8Grr+jVqNHkinG/ysfc3E=
Received: by 10.90.105.19 with SMTP id d19mr1554987agc.1193321733978;
        Thu, 25 Oct 2007 07:15:33 -0700 (PDT)
Received: by 10.90.119.14 with HTTP; Thu, 25 Oct 2007 07:15:33 -0700 (PDT)
Message-ID: <b2b2f2320710250715w6d44f826v57bd7360c2b7dca8@mail.gmail.com>
Date:	Thu, 25 Oct 2007 08:15:33 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	kaka <share.kt@gmail.com>
Subject: Re: Updated:Error opening framebuffer device/Unknown symbol
Cc:	directfb-users@directfb.org, directfb-dev@directfb.org., 
	linux-mips@linux-mips.org, uclinux-dev@uclinux.org, 
	linux-fbdev-users@lists.sourceforge.net
In-Reply-To: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1302_16135255.1193321733934"
References: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_1302_16135255.1193321733934
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Do not be surprised at the lack of response.  You have provided very little
information on your problem, and have not done your homework.

I would strongly suggest purchasing a copy of Linux Kernel Development, 2nd
edition, by Robert Love.  It's an excellent book for giving an introduction
to many aspects of the kernel.  In particular, pages 16 and 17 provide
answers to your questions, which many of the other readers of these lists
have already answered.  A quick read through that book will save you time
when you're confronted with these types of problems.

Shane


On 10/25/07, kaka <share.kt@gmail.com> wrote:
>
> Hi All,
>
> Thanks for the overhelming responses.
> I was able to remove the problem of Unknown symbols by linking the proper
> libraries. Now the problem got reduced to the following messages.
>
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol free
> insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No such
> file or directory
> #
>
> for the above problem i had tried to link "libgcc.a " but those symbols
> are also undefined in it also.
> RECAP:
> While running  the cross compiled directFB example on MIPS chip,*
> We tried to install the framebuffer driver(command given above) after
> creating the node fb0.
> APPROACH:
> Actually the code of frambuffer driver consists of usual kernel
> framebuffer code and properitiary graphics lib code.
> The properitiary graphics lib code is using malloc,print and free from <
> stdlib.h> and that is why those symbols are coming undefined.
>
> Could anybody help in this regard?
> Thanks in advance.
>
> kaka
>
>
>
> ---------- Forwarded message ----------
> From: kaka < share.kt@gmail.com>
> Date: Oct 12, 2007 6:33 PM
> Subject: Error opening framebuffer device/Unknown symbol
> register_framebuffer
> To: directfb-users@directfb.org, directfb-dev@directfb.org .
>
>
>
> > *Hi All,*
> >
> > *While running  the cross compiled directFB example on MIPS chip,*
> >
> > *
> >
> >
> >
> > We tried to install the framebuffer driver(command given at the bottom) and we have already created the node fb0.*
> >
> > *We are getting the following error, *
> >
> >
> > *Can anybody help in this regard ?*
> >
> > *Thanks in Advance.*
> >
> > # ../../cross_directfb/simple_mips
> >
> >      =======================|  DirectFB 1.0.0  |=======================
> >           (c) 2001-2007  The DirectFB Organization (directfb.org)
> >           (c) 2000-2004  Convergence (integrated media) GmbH
> >         ------------------------------------------------------------
> >
> > (*) DirectFB/Core: Single Application Core. (2007-10-05 14:17)
> > (!) Direct/Util: opening '/dev/fb0' failed
> >     --> No such device or address
> > (!) DirectFB/FBDev: Error opening framebuffer device!
> > (!) DirectFB/FBDev: Use 'fbdev' option or set FRAMEBUFFER environment variable.
> > (!) DirectFB/Core: Could not initialize 'system' core!
> >     --> Initialization error!simple.c <96>:
> >         (#) DirectFBError [DirectFBCreate (&dfb)]: Initialization error!
> > #
> >
> > *While running the following command in MIPS chip, we are getting the following error.*
> >
> > # insmod brcmstfb.ko
> > brcmstfb: Unknown symbol unregister_framebuffer
> > brcmstfb: Unknown symbol printf
> > brcmstfb: Unknown symbol malloc
> > brcmstfb: Unknown symbol fb_find_mode
> > brcmstfb: Unknown symbol fb_dealloc_cmap
> > brcmstfb: Unknown symbol fb_alloc_cmap
> > brcmstfb: Unknown symbol framebuffer_release
> > brcmstfb: Unknown symbol free
> > insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No such file or directory
> > #
> > #
> >
> >
> >
> >
>
>
> --
> Thanks & Regards,
> kaka
>
> --
> Thanks & Regards,
> kaka

------=_Part_1302_16135255.1193321733934
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Do not be surprised at the lack of response.&nbsp; You have provided very little information on your problem, and have not done your homework.</div>
<div>&nbsp;</div>
<div>I would strongly suggest purchasing a copy of Linux Kernel Development, 2nd edition, by Robert Love.&nbsp; It&#39;s an excellent book for giving an introduction to many aspects of the kernel.&nbsp; In particular, pages 16 and 17 provide answers to your questions, which many of the other readers of these lists have already answered.&nbsp; A quick read through that book will save you time when you&#39;re confronted with these types of problems.
</div>
<div>&nbsp;</div>
<div>Shane<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 10/25/07, <b class="gmail_sendername">kaka</b> &lt;<a href="mailto:share.kt@gmail.com">share.kt@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Hi All,</div>
<div>&nbsp;</div>
<div>Thanks for the overhelming responses. </div>
<div>I was able to remove the problem of Unknown symbols by linking the proper libraries. Now the problem got reduced to the following messages.</div>
<div>&nbsp;</div>
<div># insmod brcmstfb.ko<br>brcmstfb: Unknown symbol printf<br>brcmstfb: Unknown symbol malloc<br>brcmstfb: Unknown symbol free<br>insmod: cannot insert `brcmstfb.ko&#39;: Unknown symbol in module (2): No such file or directory 
<br>#<br>&nbsp;</div>
<div>for the above problem i&nbsp;had tried to link&nbsp;&quot;libgcc.a &quot; but those symbols are also undefined in it also.</div>
<div>RECAP:</div>
<div><font color="#550055">While running &nbsp;the cross compiled directFB example on MIPS chip,*<br>We tried to install the framebuffer driver(command given above)&nbsp;after creating&nbsp;the node fb0.<br></font>APPROACH:</div>
<div>Actually the code of frambuffer driver consists of usual kernel framebuffer code and&nbsp;properitiary graphics lib code. </div>
<div>The properitiary graphics lib code is using malloc,print and free from &lt;stdlib.h&gt; and that is why those symbols are coming undefined.</div>
<div>&nbsp;</div>
<div>Could anybody help in this regard?</div>
<div>Thanks in advance.</div>
<div>&nbsp;</div>
<div>kaka<br>&nbsp;</div>
<div><br><br>---------- Forwarded message ----------<br><span class="gmail_quote">From: <b class="gmail_sendername">kaka</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:share.kt@gmail.com" target="_blank">
 share.kt@gmail.com</a>&gt;<br>Date: Oct 12, 2007 6:33 PM <br>Subject: Error opening framebuffer device/Unknown symbol register_framebuffer<br>To: <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:directfb-users@directfb.org" target="_blank">
directfb-users@directfb.org</a>, <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:directfb-dev@directfb.org" target="_blank">directfb-dev@directfb.org </a>.<br><br>&nbsp;</span></div>
<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div><pre><strong><font color="#000099">Hi All,</font></strong></pre><pre><strong><font color="#000099">While running  the cross compiled directFB example on MIPS chip,</font></strong></pre><pre><strong><font color="#000099">




We tried to install the framebuffer driver(command given at the bottom) and we have already created the node fb0.</font></strong></pre><pre><strong><font color="#000099">We are getting the following error, </font></strong>




</pre><pre><strong><font color="#000099">Can anybody help in this regard ?</font></strong></pre><pre><strong><font color="#000099">Thanks in Advance.</font></strong></pre><pre># ../../cross_directfb/simple_mips
                                                                                                                             
     =======================|  DirectFB 1.0.0  |=======================
          (c) 2001-2007  The DirectFB Organization (<a onclick="return top.js.OpenExtLink(window,event,this)" href="http://directfb.org/" target="_blank">directfb.org</a>)
          (c) 2000-2004  Convergence (integrated media) GmbH
        ------------------------------------------------------------
                                                                                                                             
(*) DirectFB/Core: Single Application Core. (2007-10-05 14:17)
(!) Direct/Util: opening &#39;/dev/fb0&#39; failed
    --&gt; No such device or address
(!) DirectFB/FBDev: Error opening framebuffer device!
(!) DirectFB/FBDev: Use &#39;fbdev&#39; option or set FRAMEBUFFER environment variable.
(!) DirectFB/Core: Could not initialize &#39;system&#39; core!
    --&gt; Initialization error!
simple.c &lt;96&gt;:
        (#) DirectFBError [DirectFBCreate (&amp;dfb)]: Initialization error!
#
</pre><pre><strong><font color="#000099">While running the following command in MIPS chip, we are getting the following error.</font></strong></pre><pre># insmod brcmstfb.ko
brcmstfb: Unknown symbol unregister_framebuffer
brcmstfb: Unknown symbol printf
brcmstfb: Unknown symbol malloc
brcmstfb: Unknown symbol fb_find_mode
brcmstfb: Unknown symbol fb_dealloc_cmap
brcmstfb: Unknown symbol fb_alloc_cmap
brcmstfb: Unknown symbol framebuffer_release
brcmstfb: Unknown symbol free
insmod: cannot insert `brcmstfb.ko&#39;: Unknown symbol in module (2): No such file or directory
#
#</pre><pre>&nbsp;</pre></div></blockquote></div><br><br clear="all"><br>-- <br>Thanks &amp; Regards,<br><span>kaka </span><br clear="all"><br>-- <br>Thanks &amp; Regards,<br><span class="sg">kaka </span></blockquote></div><br>

------=_Part_1302_16135255.1193321733934--
