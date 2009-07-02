Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 18:13:48 +0200 (CEST)
Received: from mail-bw0-f217.google.com ([209.85.218.217]:51224 "EHLO
	mail-bw0-f217.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492225AbZGBQNl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 18:13:41 +0200
Received: by bwz17 with SMTP id 17so1824661bwz.0
        for <multiple recipients>; Thu, 02 Jul 2009 09:07:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=SQQSLs1YHylWx/9p9OUL9B6gOEsKTCyLShW3MgzTt7c=;
        b=QCKt36oKy+QZzOHtn2uhPlBtiq7hwDv0jnAeyQuhVLBCU0yKWtK9QwB9KzQFXW2R4D
         ZpXrOdAwcsqOZMM7+O5TRKoS7y6xZBdN59LaNtwUM7ICKyAL6y7U4OC0nMavC1TuVkiF
         cJki9klY44HJf13RPViQ3og7Gtq9D/0FRcbLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=u3HAPR+Uuju6/ppvn+fLwGzVIeTq7uVGhJIrCJf5DW/UidR3+MCsyCR5eYBdtMqkKd
         liO6MTfRj9SwuGkIxkM746YLDyErCHZ9cTlsMB0GO++4yDMhPgsYAuWpK0FrYkITFRRY
         kpFT8b93Yc7ti5zh9mTzmPFtXAMIceTZOu0Tc=
Received: by 10.103.246.1 with SMTP id y1mr105359mur.120.1246550870331;
        Thu, 02 Jul 2009 09:07:50 -0700 (PDT)
Received: from localhost.localdomain (chello089077034197.chello.pl [89.77.34.197])
        by mx.google.com with ESMTPS id 14sm12348829muo.3.2009.07.02.09.07.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 09:07:48 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	wuzhangjin@gmail.com
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date:	Thu, 2 Jul 2009 18:13:56 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.30-next-20090617-09943-g5d77a4c; KDE/4.2.4; i686; ; )
Cc:	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <200907011829.16850.bzolnier@gmail.com> <1246499203.9660.52.camel@falcon>
In-Reply-To: <1246499203.9660.52.camel@falcon>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200907021813.57322.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 02 July 2009 03:46:43 Wu Zhangjin wrote:
> On Wed, 2009-07-01 at 18:29 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 01 July 2009 18:21:25 Bartlomiej Zolnierkiewicz wrote:
> > > On Wednesday 01 July 2009 16:47:41 Wu Zhangjin wrote:
> > > > On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> > > > > On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux@gmail.com> wrote:
> > > > > 
> > > > > > I just tried, and it "seems" to work. Will try a few more cycles.
> > > > > 
> > > > > STD/STR survived quite a few cycles now. Patch seems to be doing the
> > > > > right thing.
> > > > > 
> > > > > On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> > > > > Basset<etienne.basset@numericable.fr> wrote:
> > > > > 
> > > > > > To have STR/resume work with current git, I have to :
> > > > > 
> > > > > > 1) apply Bart's patch
> > > > > 
> > > > > This is not yet in Linus's tree. And much needed to really fix the problem.
> > > > > 
> > > > > > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> > > > > 
> > > > 
> > > > Yes, This commit must be reverted, otherwise, STD/Hibernation will not
> > > > work either. I have tested it on two different loongson-based machines:
> > > > fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)
> > > 
> > > Since it seems like Dave is taking his sweet time with doing the revert
> > > I stared at the code a bit more and I think that I finally found the bug
> > > (thanks to your debugging work for giving me the right hint!).
> > > 
> > > The patch needs to take into the account a new code introduced by the recent
> > > block layer changes (commit 8f6205cd572fece673da0255d74843680f67f879):
> > > 
> > > @@ -555,8 +560,11 @@ repeat:
> > >                 startstop = start_request(drive, rq);
> > >                 spin_lock_irq(&hwif->lock);
> > >  
> > > -               if (startstop == ide_stopped)
> > > +               if (startstop == ide_stopped) {
> > > +                       rq = hwif->rq;
> > > +                       hwif->rq = NULL;
> > >                         goto repeat;
> > > +               }
> > >         } else
> > >                 goto plug_device;
> > >  out:
> > > 
> > > and not zero hwif->rq if the device is blocked. 
> > > 
> > > Could you try the attached patch and see if it fixes the issue?
> > 
> > Here is the more complete version, also taking into the account changes
> > in ide_intr() and ide_timer_expiry():
> > 
> 
> Sorry, I can not apply this patch directly, which original version did
> you use? I used the one in the master branch of linux-mips development
> git repository.
> 
> commit 5a4f13fad1ab5bd08dea78fc55321e429d83cddf
> Merge: ec9c45d e18ed14
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Jun 29 20:07:43 2009 -0700
> 
>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-2.6
>     
>     * git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-2.6:
>       ide: memory overrun in ide_get_identity_ioctl() on big endian
> machines using ioctl HDIO_OBSOLETE_IDENTITY
>       ide: fix resume for CONFIG_BLK_DEV_IDEACPI=y
>       ide-cd: handle fragmented packet commands gracefully
>       ide: always kill the whole request on error
>       ide: fix ide_kill_rq() for special ide-{floppy,tape} driver
> requests
> 
> it this too old? should i merge another git repository?

Weird, I used linux-next but Linus' tree should also be fine
(as it matches linux-next w.r.t. ide currently).

Anyway since the patch was confirmed to fix the problem by
Jeff and Etienne here is the final version for Dave.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: make resume work again

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

 drivers/ide/ide-io.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

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
