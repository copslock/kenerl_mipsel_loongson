Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 22:20:32 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.156]:55674 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20026543AbYDOVT6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Apr 2008 22:19:58 +0100
Received: by fg-out-1718.google.com with SMTP id d23so2714702fga.32
        for <linux-mips@linux-mips.org>; Tue, 15 Apr 2008 14:19:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=zw6dj2TmuXUgilX8wxf0WBCVWhoVaTax2a68QOmrr0Y=;
        b=Mxhk9xFsPFB0LLDs2seXfxaM964CIJoC3hkS11o4fynL9xVnnVE2SRuPIsOiswBo61zVwLw0YJu6PaAYmLv9gCTT9fbwLxzTINqZwwkWMMTQVoL710+4jYSl6mEc2zU23rrLS2mPBKedIYMAyF+1c7wFjJPsvgZxAdk6mCDzvpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YajF0rRctlsUgONlIwxyakwJWHOwcUkfz5y+QmHIzRqC3UxQPNYPtSx4Yh6YiDl8kyckbB3hpOmyYpFL7JNHxtOK6Y3G8aZgZNqU5GK/C0VX5NhB6pdOH0dg41QUNcoCvrtTBK2t4F/OY0ABweoooKyFNnjNr++Pt5mYCxx+Edc=
Received: by 10.86.94.11 with SMTP id r11mr6147638fgb.1.1208294392689;
        Tue, 15 Apr 2008 14:19:52 -0700 (PDT)
Received: from ?192.168.123.7? ( [81.18.197.216])
        by mx.google.com with ESMTPS id s10sm11503456mue.15.2008.04.15.14.19.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 14:19:48 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Au1200: kill IDE driver function prototypes
Date:	Tue, 15 Apr 2008 22:54:34 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org
References: <200804142228.51987.sshtylyov@ru.mvista.com>
In-Reply-To: <200804142228.51987.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804152254.34197.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Monday 14 April 2008, Sergei Shtylyov wrote:
> Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:
> 
> include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
> `static' but never defined
> include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
>  `static' but never defined
> 
> by wiping out the whole "function prototyping" section from the header file
> <asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
> already dead in the IDE driver; move the only useful prototype into the driver.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...
> 
> Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
> remove that added prototype since it won't be needed anymore...

I would prefer to merge this patch thru IDE tree because of the above and
the fact that it only touches "IDE" files - I hope Ralf is fine with it.

>  drivers/ide/mips/au1xxx-ide.c             |    2 ++
>  include/asm-mips/mach-au1x00/au1xxx_ide.h |   18 ------------------
>  2 files changed, 2 insertions(+), 18 deletions(-)
