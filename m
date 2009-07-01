Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 18:31:44 +0200 (CEST)
Received: from mail-fx0-f212.google.com ([209.85.220.212]:47965 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492131AbZGAQbh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 18:31:37 +0200
Received: by fxm8 with SMTP id 8so476113fxm.0
        for <multiple recipients>; Wed, 01 Jul 2009 09:26:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=z1b4hoO9D9Jta4B3k3/fokeTJTR0PBC1Wb+B3cALty0=;
        b=JjjrfQ0l83Uj4kWucPCXlwLSvfiQ6TdXqqvMZU0CiLjbk8vdme5fIhHF6XSlvv6Vxg
         2drSGwqgenBdAp1KLHxfbIN/Ms0hbpJ0/l3B2E+guTplLlpBOQqvR6lVpktdj4EMGRAX
         ttN4eHjNxQghV4VbDaC3BCRc/mxakasE2lDJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=oqAYUgujPnqIWfMpBxOqQ7+Uh+/XU0cMgJyktvrP43e/AkshqKlojCV/hpqbtJj6m8
         590oOr9sDKfBuQQ4lKzk4uAuoenvzEwypAiCRZc6DJ79QlqgGrn35ITw5DaYoFO3qsre
         fElb8ByFi5tGhbmxStTxngumTjf2fmFX9oyQ0=
Received: by 10.103.175.8 with SMTP id c8mr5691891mup.117.1246465564114;
        Wed, 01 Jul 2009 09:26:04 -0700 (PDT)
Received: from localhost.localdomain (chello089077034197.chello.pl [89.77.34.197])
        by mx.google.com with ESMTPS id u9sm6795536muf.37.2009.07.01.09.26.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 09:26:03 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	wuzhangjin@gmail.com
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date:	Wed, 1 Jul 2009 18:29:15 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.31-rc1-next-20090701-03251-gbe98b01-dirty; KDE/4.2.4; i686; ; )
Cc:	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <1246459661.9660.40.camel@falcon> <200907011821.26091.bzolnier@gmail.com>
In-Reply-To: <200907011821.26091.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200907011829.16850.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Wednesday 01 July 2009 18:21:25 Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 01 July 2009 16:47:41 Wu Zhangjin wrote:
> > On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> > > On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux@gmail.com> wrote:
> > > 
> > > > I just tried, and it "seems" to work. Will try a few more cycles.
> > > 
> > > STD/STR survived quite a few cycles now. Patch seems to be doing the
> > > right thing.
> > > 
> > > On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> > > Basset<etienne.basset@numericable.fr> wrote:
> > > 
> > > > To have STR/resume work with current git, I have to :
> > > 
> > > > 1) apply Bart's patch
> > > 
> > > This is not yet in Linus's tree. And much needed to really fix the problem.
> > > 
> > > > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> > > 
> > 
> > Yes, This commit must be reverted, otherwise, STD/Hibernation will not
> > work either. I have tested it on two different loongson-based machines:
> > fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)
> 
> Since it seems like Dave is taking his sweet time with doing the revert
> I stared at the code a bit more and I think that I finally found the bug
> (thanks to your debugging work for giving me the right hint!).
> 
> The patch needs to take into the account a new code introduced by the recent
> block layer changes (commit 8f6205cd572fece673da0255d74843680f67f879):
> 
> @@ -555,8 +560,11 @@ repeat:
>                 startstop = start_request(drive, rq);
>                 spin_lock_irq(&hwif->lock);
>  
> -               if (startstop == ide_stopped)
> +               if (startstop == ide_stopped) {
> +                       rq = hwif->rq;
> +                       hwif->rq = NULL;
>                         goto repeat;
> +               }
>         } else
>                 goto plug_device;
>  out:
> 
> and not zero hwif->rq if the device is blocked. 
> 
> Could you try the attached patch and see if it fixes the issue?

Here is the more complete version, also taking into the account changes
in ide_intr() and ide_timer_expiry():

---
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
