Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2011 16:27:55 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:43897 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492228Ab1HVO1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2011 16:27:51 +0200
Received: by gxk2 with SMTP id 2so4438845gxk.36
        for <linux-mips@linux-mips.org>; Mon, 22 Aug 2011 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=ScsRKJdSfon4t6uKsn5A+kAxPVBePSuxUjUyZ/MojDc=;
        b=ndZmJZymlzKBqK3MDmoe0v4EyTCL/7TiIIIUbU1Mu7VXQg8DbW8b6LLBna1O0pkuWE
         nhZCo5JlP7tE5btWDvo7EDyinPQLYR4i5PnUExSpQrgr3A3SzdTlSCfd9e7Y7NDple8b
         gVXkLA60+FSUKGNwGYhr/tkUVHlFD2ZbIP1aw=
Received: by 10.142.216.20 with SMTP id o20mr1615695wfg.446.1314023264942;
        Mon, 22 Aug 2011 07:27:44 -0700 (PDT)
Received: from [192.168.1.100] ([58.240.69.74])
        by mx.google.com with ESMTPS id a6sm794171wfg.3.2011.08.22.07.27.41
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 07:27:44 -0700 (PDT)
Subject: Re: [PATCH] drivers:uio:fix section mismatch in uio_pdrv_genirq.c
From:   Wanlong Gao <wanlong.gao@gmail.com>
Reply-To: wanlong.gao@gmail.com
To:     "Hans J. Koch" <hjk@hansjkoch.de>
Cc:     linux-kernel@vger.kernel.org, gregkh@suse.de,
        Wanlong Gao <gaowanlong@cn.fujitsu.com>,
        linux-mips@linux-mips.org
In-Reply-To: <20110822141959.GE14373@local>
References: <1313813528-30913-1-git-send-email-wanlong.gao@gmail.com>
         <20110822120314.GC14373@local> <1314017441.1825.2.camel@Allen>
         <20110822141959.GE14373@local>
Content-Type: text/plain; charset="UTF-8"
Organization: FNST
Date:   Mon, 22 Aug 2011 22:27:39 +0800
Message-ID: <1314023259.1825.4.camel@Allen>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wanlong.gao@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15887

On Mon, 2011-08-22 at 16:20 +0200, Hans J. Koch wrote:
> [Added linux-mips to Cc:]
> 
> On Mon, Aug 22, 2011 at 08:50:41PM +0800, Wanlong Gao wrote:
> > On Mon, 2011-08-22 at 14:03 +0200, Hans J. Koch wrote:
> > > On Sat, Aug 20, 2011 at 12:12:07PM +0800, Wanlong Gao wrote:
> > > > From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> > > > 
> > > > Remove the __devinitconst to fix the section mismatch.
> > > > 
> > > > WARNING: drivers/uio/built-in.o(.data+0x2e8): Section mismatch in
> > > > reference from the variable uio_pdrv_genirq to the variable
> > > 
> > > Hmm, I don't see that section mismatch here when I do a
> > > make CONFIG_DEBUG_SECTION_MISMATCH=y. How do you produce that?
> > 
> > I produced in arch of mips like
> > make O=../latest ARCH=mips CROSS_COMILE=mips-linux-
> 
> That seems to be a MIPS specific problem. It was tested OK on arm and x86.

Yeah, I see.

> 
> > 
> > > 
> > > > .devinit.rodata:uio_of_genirq_match
> > > > The variable uio_pdrv_genirq references
> > > > the variable __devinitconst uio_of_genirq_match
> > > > If the reference is valid then annotate the
> > > > variable with __init* or __refdata (see linux/init.h) or name the
> > > > variable:
> > > > *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one,
> > > > *_console
> > > 
> > > Is just removing the __devinitconst really the best solution?
> > > 
> > > Thanks,
> > > Hans
> > 
> > Do you have any better suggestions?
> 
> No, maybe the MIPS guys can shed some light on it.

It will be better.

Thanks
-Wanlong Gao
> 
> Thanks,
> Hans
> 
> > 
> > Thanks
> > -Wanlong Gao
> > 
> > > 
> > > > 
> > > > Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> > > > ---
> > > >  drivers/uio/uio_pdrv_genirq.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
> > > > index bae96d2..0b2ed71 100644
> > > > --- a/drivers/uio/uio_pdrv_genirq.c
> > > > +++ b/drivers/uio/uio_pdrv_genirq.c
> > > > @@ -253,7 +253,7 @@ static const struct dev_pm_ops uio_pdrv_genirq_dev_pm_ops = {
> > > >  };
> > > >  
> > > >  #ifdef CONFIG_OF
> > > > -static const struct of_device_id __devinitconst uio_of_genirq_match[] = {
> > > > +static const struct of_device_id uio_of_genirq_match[] = {
> > > >  	{ /* empty for now */ },
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
> > > > -- 
> > > > 1.7.4.1
> > > > 
> > > > 
> > 
> > 
> > 
