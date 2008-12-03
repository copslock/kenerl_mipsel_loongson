Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 18:01:55 +0000 (GMT)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:20181 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S24083376AbYLCSBx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 18:01:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 541179751;
	Wed,  3 Dec 2008 12:01:43 -0600 (CST)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vHAYKAFPbiM2; Wed,  3 Dec 2008 12:01:42 -0600 (CST)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 072D38048;
	Wed,  3 Dec 2008 12:01:41 -0600 (CST)
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in
	sgiwd93.c
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Kay Sievers <kay.sievers@vrfy.org>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	Greg KH <greg@kroah.com>
In-Reply-To: <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <46353.88.114.226.209.1228321494.squirrel@webmail.movial.fi>
	 <1228324123.5551.25.camel@localhost.localdomain>
	 <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
Content-Type: text/plain
Date:	Wed, 03 Dec 2008 12:01:46 -0600
Message-Id: <1228327306.5551.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-12-03 at 18:52 +0100, Kay Sievers wrote:
> On Wed, Dec 3, 2008 at 18:08, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Wed, 2008-12-03 at 18:24 +0200, Vorobiev Dmitri wrote:
> >> > This patch fixes the following compilation warning:
> >> >
> >> >   CC [M]  drivers/scsi/sgiwd93.o
> >> > drivers/scsi/sgiwd93.c:314: warning: initialization from incompatible
> >> > pointer type
> >>
> >> Any news about this one? I think this patch should go via linux-scsi,
> >> unless you would be insisting on pushing it via linux-mips, in which case
> >> I'll politely bug Ralf about it. :)
> >
> > Looks OK for the local change.
> >
> > Globally, having driver->remove and platform_driver->remove return int
> > instead of void looks wrong.  Particularly when the only use cases are
> > in drivers/base/ and they all ignore the return code.
> >
> > Greg and Kay ... shouldn't we simply redefine the return values for the
> > remove methods in these structures to return void (and thus match the
> > use case)?
> 
> Aren't there many many drivers across the tree, using the "int remove" version?

Yes ... since it's a function prototype.

However, if drivers/base simply discards the return, it's a trap we
shouldn't be setting.

James
