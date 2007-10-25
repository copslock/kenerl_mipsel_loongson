Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 13:31:14 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.185]:48228 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022542AbXJYMbE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 13:31:04 +0100
Received: by mu-out-0910.google.com with SMTP id w1so625889mue
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 05:30:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=5n+oBs2td1me0siA9a1moKJanN3GUyFcG0dvstJXgyE=;
        b=pD8zZ/lSJT1Narbz/NlYWyay5L3gLbuB4vXr/xBOlN2Hhu4NozMQO0srRKmD9dwb3a69KTcHT1wDAAWAYFWInOXb+1emtjfSIDBsexKMJKc3p71ZSP1rj5gP4FnBbIjauvhQGY2rmYgcccBDSohC6LdRq527VXF1w2+zX2R84xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GWuSuNSoKQyy2jKKbDo/5EMOv+xfmSykbuicDdeMV2cLPR/xjD+UeE0/aYZZvIckBi0h4akR2pCsRoPZ4Xe9IIeD9M3kWV0LSskYXGVSSukKR/PnN6sSkyYhHBWsKJ2jmGEhFksJCzWid9c3R2zmEWltUVF0q+Zg8Xtq8asKVtk=
Received: by 10.82.156.12 with SMTP id d12mr3887066bue.1193315454282;
        Thu, 25 Oct 2007 05:30:54 -0700 (PDT)
Received: from smiley.scopus.net ( [62.90.123.5])
        by mx.google.com with ESMTPS id z33sm2508813ikz.2007.10.25.05.30.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Oct 2007 05:30:49 -0700 (PDT)
Message-ID: <4720DF9B.5080804@gmail.com>
Date:	Thu, 25 Oct 2007 14:25:31 -0400
From:	gxk <gxkahn@gmail.com>
Reply-To:  gxkahn@gmail.com
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
MIME-Version: 1.0
To:	kaka <share.kt@gmail.com>
CC:	directfb-users@directfb.org, linux-mips@linux-mips.org,
	uclinux-dev@uclinux.org, linux-fbdev-users@lists.sourceforge.net
Subject: Re: [directfb-users] Updated:Error opening framebuffer device/Unknown
 symbol
References: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
In-Reply-To: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <gxkahn@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gxkahn@gmail.com
Precedence: bulk
X-list: linux-mips

Do not use functions from libc, like printf, malloc and free.
Find there equivalent for kernel space modules.

kaka wrote:
> Hi All,
>  
> Thanks for the overhelming responses.
> I was able to remove the problem of Unknown symbols by linking the 
> proper libraries. Now the problem got reduced to the following messages.
>  
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol free
> insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No 
> such file or directory
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
> The properitiary graphics lib code is using malloc,print and free from 
> <stdlib.h> and that is why those symbols are coming undefined.
>  
> Could anybody help in this regard?
> Thanks in advance.
>  
> kaka
>  
> 
> 
> ---------- Forwarded message ----------
> From: *kaka* < share.kt@gmail.com <mailto:share.kt@gmail.com>>
> Date: Oct 12, 2007 6:33 PM
> Subject: Error opening framebuffer device/Unknown symbol 
> register_framebuffer
> To: directfb-users@directfb.org <mailto:directfb-users@directfb.org>, 
> directfb-dev@directfb.org <mailto:directfb-dev@directfb.org>.
> 
>  
> 
>     *Hi All,*
> 
>     *While running  the cross compiled directFB example on MIPS chip,*
> 
>     *
> 
> 
> 
>     We tried to install the framebuffer driver(command given at the bottom) and we have already created the node fb0.*
> 
>     *We are getting the following error, *
> 
> 
> 
>     *Can anybody help in this regard ?*
> 
>     *Thanks in Advance.*
> 
>     # ../../cross_directfb/simple_mips
>                                                                                                                                  
>          =======================|  DirectFB 1.0.0  |=======================
>               (c) 2001-2007  The DirectFB Organization (directfb.org <http://directfb.org/>)
>               (c) 2000-2004  Convergence (integrated media) GmbH
>             ------------------------------------------------------------
>                                                                                                                                  
>     (*) DirectFB/Core: Single Application Core. (2007-10-05 14:17)
>     (!) Direct/Util: opening '/dev/fb0' failed
>         --> No such device or address
>     (!) DirectFB/FBDev: Error opening framebuffer device!
>     (!) DirectFB/FBDev: Use 'fbdev' option or set FRAMEBUFFER environment variable.
>     (!) DirectFB/Core: Could not initialize 'system' core!
>         --> Initialization error!
>     simple.c <96>:
>             (#) DirectFBError [DirectFBCreate (&dfb)]: Initialization error!
>     #
> 
>     *While running the following command in MIPS chip, we are getting the following error.*
> 
>     # insmod brcmstfb.ko
>     brcmstfb: Unknown symbol unregister_framebuffer
>     brcmstfb: Unknown symbol printf
>     brcmstfb: Unknown symbol malloc
>     brcmstfb: Unknown symbol fb_find_mode
>     brcmstfb: Unknown symbol fb_dealloc_cmap
>     brcmstfb: Unknown symbol fb_alloc_cmap
>     brcmstfb: Unknown symbol framebuffer_release
>     brcmstfb: Unknown symbol free
>     insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No such file or directory
>     #
>     #
> 
>      
> 
> 
> 
> 
> -- 
> Thanks & Regards,
> kaka
> 
> -- 
> Thanks & Regards,
> kaka
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> directfb-users mailing list
> directfb-users@directfb.org
> http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users

-- 
     Three things are certain:
     Death, taxes, and lost data.
     Guess which has occurred.
