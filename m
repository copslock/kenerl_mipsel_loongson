Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 19:30:45 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.158]:49540 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20190068AbYD1Sam (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Apr 2008 19:30:42 +0100
Received: by fg-out-1718.google.com with SMTP id d23so12092858fga.32
        for <linux-mips@linux-mips.org>; Mon, 28 Apr 2008 11:30:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        bh=a8ZHtzJ4Ml2PzknBj8V/GJE2UdUAMgUxVdYzQjLr+dA=;
        b=tv2W3bjRIUu9ajWz4nSpnWXJGwPTWspptNr4E2p64XSzPgXQH89SCxcgvABsXlLNDzV3GYcJpQmFpN9Imvu9w0HVpC2vFRvgERfNcmZqMYg0Jebzcrp7Dw4Y0siTktRScX+rXbHYi84TvZqOGAMeof5QwiG57l4LbDRL6O1BO5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=vKmQRv1D3RbxYM+eCcfT8BCrtxHVPWqkzB0mMp2XXIIavd45ETvRz1dzk4KbeDPUor3aqbX9iQLSuQLk75aEHS5ruVu5jc4w27OCcXD6lzv7vuRqUsAV0qLiO9VffiJPqeNfQf3g2sY1HaL9LISgt2P80/VDLJSNT4ipneIES4s=
Received: by 10.86.52.1 with SMTP id z1mr2318446fgz.9.1209407437349;
        Mon, 28 Apr 2008 11:30:37 -0700 (PDT)
Received: from ?192.168.123.7? ( [81.18.197.216])
        by mx.google.com with ESMTPS id e9sm25127320muf.0.2008.04.28.11.30.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 11:30:36 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Au1200: kill IDE driver function prototypes
Date:	Mon, 28 Apr 2008 20:46:53 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
References: <200804142228.51987.sshtylyov@ru.mvista.com> <4815DE95.9010107@ru.mvista.com>
In-Reply-To: <4815DE95.9010107@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200804282046.53474.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips


Hello,

On Monday 28 April 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> > Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:
> 
> > include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
> > `static' but never defined
> > include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
> >  `static' but never defined
> 
> > by wiping out the whole "function prototyping" section from the header file
> > <asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
> > already dead in the IDE driver; move the only useful prototype into the driver.
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > ---
> > I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...
> 
> > Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
> > remove that added prototype since it won't be needed anymore...
> 
>     Which you haven't done either in that patch or in 
> au1xxx-ide-use-init_dma-method.patch. So, face the consequences:
> 
> drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
> drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
> 'auide_ddma_init' was here
> drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
> drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
> 'auide_ddma_init' was here
> drivers/ide/mips/au1xxx-ide.c:51: warning: 'auide_ddma_init' used but never
> defined

Sorry for that, I remember taking a look at au1xxx-ide-fix-mwdma-support.patch
and it was OK (now I see that it was au1xxx-ide-use-init_dma-method.patch that
needed an update).  I'll fix it in today's update.

Thanks,
Bart
