Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 03:52:43 +0200 (CEST)
Received: from wf-out-1314.google.com ([209.85.200.170]:55221 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491973AbZGBBwg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 03:52:36 +0200
Received: by wf-out-1314.google.com with SMTP id 28so488735wfa.21
        for <multiple recipients>; Wed, 01 Jul 2009 18:46:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=7xsEOcp72isWMSwh6/V5XqI/FtXPTWnPl5IgjfJYIWo=;
        b=GT4cnpGGDNe1U/DgrZNBWb601fTxiPOEiLlofmsMiyCXEYI1x/bu9Je2HlWMm/hLuV
         L5kNeVuiMVKwG0uoyC26oqQ0Lco3Rhmy0fZ7PAIJc8fJ9+DS7Z5WBGD5tBt/FQKfrRLj
         uvaPt+oMrF2FvJRWzW50Gdv4uuNJY9v1u5pW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=kIaT/0C+6AQV96irABsQ9Sd/c//0NXNTXCxRyJsAi7FykGCoiIX0lJ96yfIg88588H
         xpeBaM9ZJUw1favt8ojXcYE7EfpQCmQh3HLSJUAZ+FbeRIcvULtHdweuTEhuQItC/3XL
         oBY9C98wxWF43V30ydArQcDVXke2wAxO8vV2Q=
Received: by 10.142.222.19 with SMTP id u19mr1282919wfg.6.1246499216905;
        Wed, 01 Jul 2009 18:46:56 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 30sm5615554wfd.3.2009.07.01.18.46.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 18:46:55 -0700 (PDT)
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
In-Reply-To: <200907011829.16850.bzolnier@gmail.com>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera>
	 <1246459661.9660.40.camel@falcon> <200907011821.26091.bzolnier@gmail.com>
	 <200907011829.16850.bzolnier@gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 02 Jul 2009 09:46:43 +0800
Message-Id: <1246499203.9660.52.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-07-01 at 18:29 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 01 July 2009 18:21:25 Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 01 July 2009 16:47:41 Wu Zhangjin wrote:
> > > On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> > > > On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux@gmail.com> wrote:
> > > > 
> > > > > I just tried, and it "seems" to work. Will try a few more cycles.
> > > > 
> > > > STD/STR survived quite a few cycles now. Patch seems to be doing the
> > > > right thing.
> > > > 
> > > > On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> > > > Basset<etienne.basset@numericable.fr> wrote:
> > > > 
> > > > > To have STR/resume work with current git, I have to :
> > > > 
> > > > > 1) apply Bart's patch
> > > > 
> > > > This is not yet in Linus's tree. And much needed to really fix the problem.
> > > > 
> > > > > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> > > > 
> > > 
> > > Yes, This commit must be reverted, otherwise, STD/Hibernation will not
> > > work either. I have tested it on two different loongson-based machines:
> > > fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)
> > 
> > Since it seems like Dave is taking his sweet time with doing the revert
> > I stared at the code a bit more and I think that I finally found the bug
> > (thanks to your debugging work for giving me the right hint!).
> > 
> > The patch needs to take into the account a new code introduced by the recent
> > block layer changes (commit 8f6205cd572fece673da0255d74843680f67f879):
> > 
> > @@ -555,8 +560,11 @@ repeat:
> >                 startstop = start_request(drive, rq);
> >                 spin_lock_irq(&hwif->lock);
> >  
> > -               if (startstop == ide_stopped)
> > +               if (startstop == ide_stopped) {
> > +                       rq = hwif->rq;
> > +                       hwif->rq = NULL;
> >                         goto repeat;
> > +               }
> >         } else
> >                 goto plug_device;
> >  out:
> > 
> > and not zero hwif->rq if the device is blocked. 
> > 
> > Could you try the attached patch and see if it fixes the issue?
> 
> Here is the more complete version, also taking into the account changes
> in ide_intr() and ide_timer_expiry():
> 

Sorry, I can not apply this patch directly, which original version did
you use? I used the one in the master branch of linux-mips development
git repository.

commit 5a4f13fad1ab5bd08dea78fc55321e429d83cddf
Merge: ec9c45d e18ed14
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Jun 29 20:07:43 2009 -0700

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-2.6
    
    * git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-2.6:
      ide: memory overrun in ide_get_identity_ioctl() on big endian
machines using ioctl HDIO_OBSOLETE_IDENTITY
      ide: fix resume for CONFIG_BLK_DEV_IDEACPI=y
      ide-cd: handle fragmented packet commands gracefully
      ide: always kill the whole request on error
      ide: fix ide_kill_rq() for special ide-{floppy,tape} driver
requests

it this too old? should i merge another git repository?

I have tried to apply it manually, but unfortunately, also not work. any
other patch needed?

Thanks!
Wu Zhangjin
> ---
>  drivers/ide/ide-io.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> Index: b/drivers/ide/ide-io.c
> ===================================================================
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -532,7 +532,8 @@ repeat:
>  
>  		if (startstop == ide_stopped) {
>  			rq = hwif->rq;
> -			hwif->rq = NULL;
> +			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0)
> +				hwif->rq = NULL;
>  			goto repeat;
>  		}
>  	} else
> @@ -679,8 +680,10 @@ void ide_timer_expiry (unsigned long dat
>  		spin_lock_irq(&hwif->lock);
>  		enable_irq(hwif->irq);
>  		if (startstop == ide_stopped && hwif->polling == 0) {
> -			rq_in_flight = hwif->rq;
> -			hwif->rq = NULL;
> +			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
> +				rq_in_flight = hwif->rq;
> +				hwif->rq = NULL;
> +			}
>  			ide_unlock_port(hwif);
>  			plug_device = 1;
>  		}
> @@ -856,8 +859,10 @@ irqreturn_t ide_intr (int irq, void *dev
>  	 */
>  	if (startstop == ide_stopped && hwif->polling == 0) {
>  		BUG_ON(hwif->handler);
> -		rq_in_flight = hwif->rq;
> -		hwif->rq = NULL;
> +		if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
> +			rq_in_flight = hwif->rq;
> +			hwif->rq = NULL;
> +		}
>  		ide_unlock_port(hwif);
>  		plug_device = 1;
>  	}
