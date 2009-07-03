Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2009 15:08:55 +0200 (CEST)
Received: from mail-fx0-f212.google.com ([209.85.220.212]:64170 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492285AbZGCNIr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Jul 2009 15:08:47 +0200
Received: by fxm8 with SMTP id 8so1844880fxm.0
        for <multiple recipients>; Fri, 03 Jul 2009 06:02:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WNbbOQM+BLVCVyxRpD+1/8ZlOmiUKRQZNoAao2WzXSg=;
        b=dAXV7zolHGUNejeV8uO25tlIob4PJSKis7xaDLFEtIlidmhfWHSU/ctdBd+TYU3z7W
         T7+Es9J2xnUSDNf0UZ8dYW2btGo9t6moyIAxFxoy9Yrix0z1OLjB4vLK5xosXhPjSx2Y
         pJSa4X52bD7gHcwfT1ijh4ion8pULZF5Ti7Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vKUAWfwZXMQ7xJBewnDRxvfPE7Hh8Tf5UvxOhnNjOaRNqwTvwo/W7wceC3VKiICbNA
         a2Q0U9GC8AZzDdT1gDH6FkKC/93l0p4JS+4tn9jqkMgowXgr5EVVWsWHTNez7I4FO4B3
         bn7yotTA6ELpX4jPAM+b6Zt9gU2Z/63QR9o+c=
Received: by 10.103.225.11 with SMTP id c11mr776732mur.98.1246626160997;
        Fri, 03 Jul 2009 06:02:40 -0700 (PDT)
Received: from localhost.localdomain (chello089077034197.chello.pl [89.77.34.197])
        by mx.google.com with ESMTPS id 12sm17514995muq.23.2009.07.03.06.02.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 06:02:39 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	wuzhangjin@gmail.com
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date:	Fri, 3 Jul 2009 15:08:45 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.31-rc1-next-20090703-03460-gb01c1b8; KDE/4.2.4; i686; ; )
Cc:	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <200907021813.57322.bzolnier@gmail.com> <1246593505.27828.187.camel@falcon>
In-Reply-To: <1246593505.27828.187.camel@falcon>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907031508.47891.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Friday 03 July 2009 05:58:25 Wu Zhangjin wrote:
> On Thu, 2009-07-02 at 18:13 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 02 July 2009 03:46:43 Wu Zhangjin wrote:
> > > On Wed, 2009-07-01 at 18:29 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > On Wednesday 01 July 2009 18:21:25 Bartlomiej Zolnierkiewicz wrote:
> > > > > On Wednesday 01 July 2009 16:47:41 Wu Zhangjin wrote:
> > > > > > On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> > > > > > > On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux@gmail.com> wrote:
> > > > > > > 
> > > > > > > > I just tried, and it "seems" to work. Will try a few more cycles.
> > > > > > > 
> > > > > > > STD/STR survived quite a few cycles now. Patch seems to be doing the
> > > > > > > right thing.
> > > > > > > 
> > > > > > > On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> > > > > > > Basset<etienne.basset@numericable.fr> wrote:
> > > > > > > 
> > > > > > > > To have STR/resume work with current git, I have to :
> > > > > > > 
> > > > > > > > 1) apply Bart's patch
> > > > > > > 
> > > > > > > This is not yet in Linus's tree. And much needed to really fix the problem.
> > > > > > > 
> > > > > > > > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> > > > > > > 
> > > > > > 
> > > > > > Yes, This commit must be reverted, otherwise, STD/Hibernation will not
> > > > > > work either. I have tested it on two different loongson-based machines:
> > > > > > fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)
> > > > > 
> > > > > Since it seems like Dave is taking his sweet time with doing the revert
> > > > > I stared at the code a bit more and I think that I finally found the bug
> > > > > (thanks to your debugging work for giving me the right hint!).
> > > > > 
> > > > > The patch needs to take into the account a new code introduced by the recent
> > > > > block layer changes (commit 8f6205cd572fece673da0255d74843680f67f879):
> > > > > 
> > > > > @@ -555,8 +560,11 @@ repeat:
> > > > >                 startstop = start_request(drive, rq);
> > > > >                 spin_lock_irq(&hwif->lock);
> > > > >  
> > > > > -               if (startstop == ide_stopped)
> > > > > +               if (startstop == ide_stopped) {
> > > > > +                       rq = hwif->rq;
> > > > > +                       hwif->rq = NULL;
> > > > >                         goto repeat;
> > > > > +               }
> > > > >         } else
> > > > >                 goto plug_device;
> > > > >  out:
> > > > > 
> > > > > and not zero hwif->rq if the device is blocked. 
> > > > > 
> > > > > Could you try the attached patch and see if it fixes the issue?
> > > > 
> > > > Here is the more complete version, also taking into the account changes
> > > > in ide_intr() and ide_timer_expiry():
> > > > 
> > > 
> > > Sorry, I can not apply this patch directly, which original version did
> > > you use? I used the one in the master branch of linux-mips development
> > > git repository.
> > > 
> > > commit 5a4f13fad1ab5bd08dea78fc55321e429d83cddf
> > > Merge: ec9c45d e18ed14
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Mon Jun 29 20:07:43 2009 -0700
> > > 
> > >     Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-2.6
> > >     
> > >     * git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-2.6:
> > >       ide: memory overrun in ide_get_identity_ioctl() on big endian
> > > machines using ioctl HDIO_OBSOLETE_IDENTITY
> > >       ide: fix resume for CONFIG_BLK_DEV_IDEACPI=y
> > >       ide-cd: handle fragmented packet commands gracefully
> > >       ide: always kill the whole request on error
> > >       ide: fix ide_kill_rq() for special ide-{floppy,tape} driver
> > > requests
> > > 
> > > it this too old? should i merge another git repository?
> > 
> > Weird, I used linux-next but Linus' tree should also be fine
> > (as it matches linux-next w.r.t. ide currently).
> 
> I just cloned the linux-next git repo, and tested your patch with
> STD/Hibernation, unfortunately, it also not work :-(
> 
> here is the Call Trace:
> 
> blk_delete_timer+0x0/0x20
> blk_requeue_request+0x24/0xd0
> ide_requeue_and_plug+0x38/0xb0
> ide_intr+0x120/0x300             --->  ide_intr....
> handle_IRQ_event+0x94/0x230
> handle_level_irq+0x7c/0x120
> mach_irq_dispatch+0xc8/0x158
> ret_from_irq+0x0/0x4
> cpu_idle+0x30/0x60
> start_kernel+0x330/0x34c
> 
> If _NOT_ apply your patch and comment this part, it works:

OK, I see another gotcha added by recent changes, we need to explicitly
initialize rq_in_flight variables now.  Revised patch below..

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: make resume work again (for real)

It turns out that commit a1317f714af7aed60ddc182d0122477cbe36ee9b
("ide: improve handling of Power Management requests") needs to take
into the account a new code added by the recent block layer changes
in commit 8f6205cd572fece673da0255d74843680f67f879 ("ide: dequeue
in-flight request") and prevent clearing of hwif->rq if the device
is blocked.

Thanks to Etienne, Wu and Jeff for help in fixing the issue.

Reported-and-tested-by: Jeff Chua <jeff.chua.linux@gmail.com>
Reported-and-tested-by: Etienne Basset <etienne.basset@numericable.fr>
Reported-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Added patch description, no other changes.

 drivers/ide/ide-io.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -532,7 +532,8 @@ repeat:
 
 		if (startstop == ide_stopped) {
 			rq = hwif->rq;
-			hwif->rq = NULL;
+			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0)
+				hwif->rq = NULL;
 			goto repeat;
 		}
 	} else
@@ -616,7 +617,7 @@ void ide_timer_expiry (unsigned long dat
 	unsigned long	flags;
 	int		wait = -1;
 	int		plug_device = 0;
-	struct request	*uninitialized_var(rq_in_flight);
+	struct request	*rq_in_flight = NULL;
 
 	spin_lock_irqsave(&hwif->lock, flags);
 
@@ -679,8 +680,10 @@ void ide_timer_expiry (unsigned long dat
 		spin_lock_irq(&hwif->lock);
 		enable_irq(hwif->irq);
 		if (startstop == ide_stopped && hwif->polling == 0) {
-			rq_in_flight = hwif->rq;
-			hwif->rq = NULL;
+			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
+				rq_in_flight = hwif->rq;
+				hwif->rq = NULL;
+			}
 			ide_unlock_port(hwif);
 			plug_device = 1;
 		}
@@ -775,7 +778,7 @@ irqreturn_t ide_intr (int irq, void *dev
 	ide_startstop_t startstop;
 	irqreturn_t irq_ret = IRQ_NONE;
 	int plug_device = 0;
-	struct request *uninitialized_var(rq_in_flight);
+	struct request *rq_in_flight = NULL;
 
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
 		if (hwif != host->cur_port)
@@ -856,8 +859,10 @@ irqreturn_t ide_intr (int irq, void *dev
 	 */
 	if (startstop == ide_stopped && hwif->polling == 0) {
 		BUG_ON(hwif->handler);
-		rq_in_flight = hwif->rq;
-		hwif->rq = NULL;
+		if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
+			rq_in_flight = hwif->rq;
+			hwif->rq = NULL;
+		}
 		ide_unlock_port(hwif);
 		plug_device = 1;
 	}
