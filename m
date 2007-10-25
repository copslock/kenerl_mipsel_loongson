Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 09:56:06 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:39082 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022326AbXJYIz6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 09:55:58 +0100
Received: by ug-out-1314.google.com with SMTP id u2so535917uge
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 01:55:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=Ymexo036V9AUl5zldAcTAphzfN+mJ1eSgQ4czraen/M=;
        b=egY2A6DMk47A7trPnwGg6qcmihHGCVdW5jvc6TukFOPnJop0KZ3cYWQrB5vM1smgnraoji74Up8J3tLSGukMVfskXjtxkfYXV465akcm2ObDXmzWpBZk2ZSn4NysQjTAWOft+otqGjEPh/FVtHsOs4FwyfwjUPI3QRIBw6tBlxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=THdLd7dgOyuzEMCZb4EK4Xbk8SEMP+bKkYTQkQoLjwAHyQWiD5JXJpmyisD43yYOS285yg/VLmQan1KN2NHg7NRejce1nBlf2EzWy2AstVAPDyZnKNaMg+Ewm3cwAqtgruOCdlVp0AOL7/q/BXMAQ6rQ53IqcrhXA3duZMgxSQ4=
Received: by 10.66.238.16 with SMTP id l16mr44628ugh.1193302540335;
        Thu, 25 Oct 2007 01:55:40 -0700 (PDT)
Received: by 10.67.15.14 with HTTP; Thu, 25 Oct 2007 01:55:40 -0700 (PDT)
Message-ID: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
Date:	Thu, 25 Oct 2007 14:25:40 +0530
From:	kaka <share.kt@gmail.com>
To:	directfb-users@directfb.org, directfb-dev@directfb.org., 
	linux-mips@linux-mips.org, uclinux-dev@uclinux.org, 
	linux-fbdev-users@lists.sourceforge.net
Subject: Updated:Error opening framebuffer device/Unknown symbol
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11159_3084375.1193302540326"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_11159_3084375.1193302540326
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

Thanks for the overhelming responses.
I was able to remove the problem of Unknown symbols by linking the proper
libraries. Now the problem got reduced to the following messages.

# insmod brcmstfb.ko
brcmstfb: Unknown symbol printf
brcmstfb: Unknown symbol malloc
brcmstfb: Unknown symbol free
insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No such
file or directory
#

for the above problem i had tried to link "libgcc.a " but those symbols are
also undefined in it also.
RECAP:
While running  the cross compiled directFB example on MIPS chip,*
We tried to install the framebuffer driver(command given above) after
creating the node fb0.
APPROACH:
Actually the code of frambuffer driver consists of usual kernel framebuffer
code and properitiary graphics lib code.
The properitiary graphics lib code is using malloc,print and free from <
stdlib.h> and that is why those symbols are coming undefined.

Could anybody help in this regard?
Thanks in advance.

kaka



---------- Forwarded message ----------
From: kaka <share.kt@gmail.com>
Date: Oct 12, 2007 6:33 PM
Subject: Error opening framebuffer device/Unknown symbol
register_framebuffer
To: directfb-users@directfb.org, directfb-dev@directfb.org .



> *Hi All,*
>
> *While running  the cross compiled directFB example on MIPS chip,*
>
> *
>
>
> We tried to install the framebuffer driver(command given at the bottom) and we have already created the node fb0.*
>
> *We are getting the following error, *
>
> *Can anybody help in this regard ?*
>
> *Thanks in Advance.*
>
> # ../../cross_directfb/simple_mips
>
>      =======================|  DirectFB 1.0.0  |=======================
>           (c) 2001-2007  The DirectFB Organization (directfb.org)
>           (c) 2000-2004  Convergence (integrated media) GmbH
>         ------------------------------------------------------------
>
> (*) DirectFB/Core: Single Application Core. (2007-10-05 14:17)
> (!) Direct/Util: opening '/dev/fb0' failed
>     --> No such device or address
> (!) DirectFB/FBDev: Error opening framebuffer device!
> (!) DirectFB/FBDev: Use 'fbdev' option or set FRAMEBUFFER environment variable.
> (!) DirectFB/Core: Could not initialize 'system' core!
>     --> Initialization error!simple.c <96>:
>         (#) DirectFBError [DirectFBCreate (&dfb)]: Initialization error!
> #
>
> *While running the following command in MIPS chip, we are getting the following error.*
>
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol unregister_framebuffer
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol fb_find_mode
> brcmstfb: Unknown symbol fb_dealloc_cmap
> brcmstfb: Unknown symbol fb_alloc_cmap
> brcmstfb: Unknown symbol framebuffer_release
> brcmstfb: Unknown symbol free
> insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No such file or directory
> #
> #
>
>
>
>


-- 
Thanks & Regards,
kaka

-- 
Thanks & Regards,
kaka

------=_Part_11159_3084375.1193302540326
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

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
#</pre><pre>&nbsp;</pre></div></blockquote></div><br><br clear="all"><br>-- <br>Thanks &amp; Regards,<br><span>kaka </span><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_11159_3084375.1193302540326--
