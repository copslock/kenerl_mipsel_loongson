Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 17:53:04 +0000 (GMT)
Received: from wf-out-1314.google.com ([209.85.200.171]:48214 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S24083089AbYLCRw7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 17:52:59 +0000
Received: by wf-out-1314.google.com with SMTP id 27so4657797wfd.21
        for <linux-mips@linux-mips.org>; Wed, 03 Dec 2008 09:52:54 -0800 (PST)
Received: by 10.140.127.20 with SMTP id z20mr6432842rvc.100.1228326774730;
        Wed, 03 Dec 2008 09:52:54 -0800 (PST)
Received: by 10.140.191.6 with HTTP; Wed, 3 Dec 2008 09:52:54 -0800 (PST)
Message-ID: <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
Date:	Wed, 3 Dec 2008 18:52:54 +0100
From:	"Kay Sievers" <kay.sievers@vrfy.org>
To:	"James Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in sgiwd93.c
Cc:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	"Greg KH" <greg@kroah.com>
In-Reply-To: <1228324123.5551.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <46353.88.114.226.209.1228321494.squirrel@webmail.movial.fi>
	 <1228324123.5551.25.camel@localhost.localdomain>
Return-Path: <kay.sievers@vrfy.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kay.sievers@vrfy.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 3, 2008 at 18:08, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2008-12-03 at 18:24 +0200, Vorobiev Dmitri wrote:
>> > This patch fixes the following compilation warning:
>> >
>> >   CC [M]  drivers/scsi/sgiwd93.o
>> > drivers/scsi/sgiwd93.c:314: warning: initialization from incompatible
>> > pointer type
>>
>> Any news about this one? I think this patch should go via linux-scsi,
>> unless you would be insisting on pushing it via linux-mips, in which case
>> I'll politely bug Ralf about it. :)
>
> Looks OK for the local change.
>
> Globally, having driver->remove and platform_driver->remove return int
> instead of void looks wrong.  Particularly when the only use cases are
> in drivers/base/ and they all ignore the return code.
>
> Greg and Kay ... shouldn't we simply redefine the return values for the
> remove methods in these structures to return void (and thus match the
> use case)?

Aren't there many many drivers across the tree, using the "int remove" version?

Thanks,
Kay
