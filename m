Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 18:21:24 +0200 (CEST)
Received: from mail-fx0-f212.google.com ([209.85.220.212]:63358 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492114AbZGAQVR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 18:21:17 +0200
Received: by fxm8 with SMTP id 8so468091fxm.0
        for <multiple recipients>; Wed, 01 Jul 2009 09:15:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=zOjJh9hoWunbw/dAGMndm70LzBljmpJ3fEwAl42viro=;
        b=u6myhBT+uwkGkgRYDq/KXSeAW5oFTxbC4Bh1is4hxJejH9aCkmxXhd2NN0mxhGnLe2
         RChxkR1ntXIQoOCht9Icc9at9QIZXZgIwCFsivxYZyO4q7AipSBHptXXt50Ln98QZUtP
         def+/2uFAf8FA2WcmcbQFHDilBu5dAuHmfAvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=WfU+9CAOiqfE1XChqJbYYcJfa1irnofHwO4ZyN5bvy69YQzIS7KnJGqVr6SsPX8kIS
         TPRgUdYvgywLWQso+ceh4bUh8dp7U+NcSe30Btc5S3hpyhJYapGgkOhADTRItA0hcrK1
         Z/IINGx7sQLIS3DAEorpGY0skZYEa9Gn+IxAg=
Received: by 10.103.173.5 with SMTP id a5mr5682861mup.15.1246464942573;
        Wed, 01 Jul 2009 09:15:42 -0700 (PDT)
Received: from localhost.localdomain (chello089077034197.chello.pl [89.77.34.197])
        by mx.google.com with ESMTPS id j2sm6654997mue.12.2009.07.01.09.15.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 09:15:41 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	wuzhangjin@gmail.com
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date:	Wed, 1 Jul 2009 18:21:25 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.31-rc1-next-20090701-03251-gbe98b01-dirty; KDE/4.2.4; i686; ; )
Cc:	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <b6a2187b0907010731k510150b5u1c7fce8cbed7c33b@mail.gmail.com> <1246459661.9660.40.camel@falcon>
In-Reply-To: <1246459661.9660.40.camel@falcon>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200907011821.26091.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Wednesday 01 July 2009 16:47:41 Wu Zhangjin wrote:
> On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> > On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux@gmail.com> wrote:
> > 
> > > I just tried, and it "seems" to work. Will try a few more cycles.
> > 
> > STD/STR survived quite a few cycles now. Patch seems to be doing the
> > right thing.
> > 
> > On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> > Basset<etienne.basset@numericable.fr> wrote:
> > 
> > > To have STR/resume work with current git, I have to :
> > 
> > > 1) apply Bart's patch
> > 
> > This is not yet in Linus's tree. And much needed to really fix the problem.
> > 
> > > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> > 
> 
> Yes, This commit must be reverted, otherwise, STD/Hibernation will not
> work either. I have tested it on two different loongson-based machines:
> fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)

Since it seems like Dave is taking his sweet time with doing the revert
I stared at the code a bit more and I think that I finally found the bug
(thanks to your debugging work for giving me the right hint!).

The patch needs to take into the account a new code introduced by the recent
block layer changes (commit 8f6205cd572fece673da0255d74843680f67f879):

@@ -555,8 +560,11 @@ repeat:
                startstop = start_request(drive, rq);
                spin_lock_irq(&hwif->lock);
 
-               if (startstop == ide_stopped)
+               if (startstop == ide_stopped) {
+                       rq = hwif->rq;
+                       hwif->rq = NULL;
                        goto repeat;
+               }
        } else
                goto plug_device;
 out:

and not zero hwif->rq if the device is blocked. 

Could you try the attached patch and see if it fixes the issue?

[ Dave: while I appreciate fast handling of my patches I had strongly
  suggested giving this particular one some extra testing (because there
  were a lot of changes in between the time that it has been tested
  against other kernel subsystems).  Yet, it seems that its linux-next
  exposure was minimal at best..  :( ]

---
 drivers/ide/ide-io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
