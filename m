Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 18:42:35 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:16537 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S24084248AbYLCSmW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Dec 2008 18:42:22 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id AAA75C8012;
	Wed,  3 Dec 2008 20:42:16 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id lSWcqqkYlEhq; Wed,  3 Dec 2008 20:42:16 +0200 (EET)
Received: from webmail.movial.fi (webmail.movial.fi [62.236.91.25])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 8CEB4C8010;
	Wed,  3 Dec 2008 20:42:16 +0200 (EET)
Received: by webmail.movial.fi (Postfix, from userid 33)
	id 7F74123D113; Wed,  3 Dec 2008 20:42:16 +0200 (EET)
Received: from 88.114.226.209
        (SquirrelMail authenticated user dvorobye)
        by webmail.movial.fi with HTTP;
        Wed, 3 Dec 2008 20:42:16 +0200 (EET)
Message-ID: <35647.88.114.226.209.1228329736.squirrel@webmail.movial.fi>
In-Reply-To: <1228327306.5551.36.camel@localhost.localdomain>
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
    <46353.88.114.226.209.1228321494.squirrel@webmail.movial.fi>
    <1228324123.5551.25.camel@localhost.localdomain>
    <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
    <1228327306.5551.36.camel@localhost.localdomain>
Date:	Wed, 3 Dec 2008 20:42:16 +0200 (EET)
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in 
     sgiwd93.c
From:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>
To:	"James Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:	"Kay Sievers" <kay.sievers@vrfy.org>,
	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	"Greg KH" <greg@kroah.com>
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

> On Wed, 2008-12-03 at 18:52 +0100, Kay Sievers wrote:
>> On Wed, Dec 3, 2008 at 18:08, James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>> > On Wed, 2008-12-03 at 18:24 +0200, Vorobiev Dmitri wrote:
>> >> > This patch fixes the following compilation warning:
>> >> >
>> >> >   CC [M]  drivers/scsi/sgiwd93.o
>> >> > drivers/scsi/sgiwd93.c:314: warning: initialization from
>> incompatible
>> >> > pointer type
>> >>
>> >> Any news about this one? I think this patch should go via linux-scsi,
>> >> unless you would be insisting on pushing it via linux-mips, in which
>> case
>> >> I'll politely bug Ralf about it. :)
>> >
>> > Looks OK for the local change.
>> >
>> > Globally, having driver->remove and platform_driver->remove return int
>> > instead of void looks wrong.  Particularly when the only use cases are
>> > in drivers/base/ and they all ignore the return code.
>> >
>> > Greg and Kay ... shouldn't we simply redefine the return values for
>> the
>> > remove methods in these structures to return void (and thus match the
>> > use case)?
>>
>> Aren't there many many drivers across the tree, using the "int remove"
>> version?
>
> Yes ... since it's a function prototype.
>
> However, if drivers/base simply discards the return, it's a trap we
> shouldn't be setting.

Hmmm, it does look like the return value is discarded, please see
drivers/base/dd.c::__device_release_driver() for details.

Does this not deserve a good cleanup?

Dmitri

>
> James
>
>
>
>
