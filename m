Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 17:08:53 +0000 (GMT)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:17325 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S24081604AbYLCRIv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 17:08:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 5E4369751;
	Wed,  3 Dec 2008 11:08:42 -0600 (CST)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NKi1pHpBJy01; Wed,  3 Dec 2008 11:08:40 -0600 (CST)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id D1D4480A2;
	Wed,  3 Dec 2008 11:08:39 -0600 (CST)
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in 
	sgiwd93.c
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <46353.88.114.226.209.1228321494.squirrel@webmail.movial.fi>
References:  <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <46353.88.114.226.209.1228321494.squirrel@webmail.movial.fi>
Content-Type: text/plain
Date:	Wed, 03 Dec 2008 11:08:43 -0600
Message-Id: <1228324123.5551.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-12-03 at 18:24 +0200, Vorobiev Dmitri wrote:
> > This patch fixes the following compilation warning:
> >
> >   CC [M]  drivers/scsi/sgiwd93.o
> > drivers/scsi/sgiwd93.c:314: warning: initialization from incompatible
> > pointer type
> >
> 
> Hello James,
> 
> Any news about this one? I think this patch should go via linux-scsi,
> unless you would be insisting on pushing it via linux-mips, in which case
> I'll politely bug Ralf about it. :)

Looks OK for the local change.

Globally, having driver->remove and platform_driver->remove return int
instead of void looks wrong.  Particularly when the only use cases are
in drivers/base/ and they all ignore the return code.

Greg and Kay ... shouldn't we simply redefine the return values for the
remove methods in these structures to return void (and thus match the
use case)?

James
