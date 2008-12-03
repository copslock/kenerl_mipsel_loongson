Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 18:51:28 +0000 (GMT)
Received: from rv-out-0708.google.com ([209.85.198.241]:49849 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S24084347AbYLCSvU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 18:51:20 +0000
Received: by rv-out-0708.google.com with SMTP id c5so3655579rvf.24
        for <linux-mips@linux-mips.org>; Wed, 03 Dec 2008 10:51:15 -0800 (PST)
Received: by 10.141.177.2 with SMTP id e2mr6439643rvp.269.1228330275512;
        Wed, 03 Dec 2008 10:51:15 -0800 (PST)
Received: by 10.140.191.6 with HTTP; Wed, 3 Dec 2008 10:51:15 -0800 (PST)
Message-ID: <ac3eb2510812031051k9d9312bma119bfae35afc230@mail.gmail.com>
Date:	Wed, 3 Dec 2008 19:51:15 +0100
From:	"Kay Sievers" <kay.sievers@vrfy.org>
To:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in sgiwd93.c
Cc:	"James Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	"Greg KH" <greg@kroah.com>
In-Reply-To: <35647.88.114.226.209.1228329736.squirrel@webmail.movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <46353.88.114.226.209.1228321494.squirrel@webmail.movial.fi>
	 <1228324123.5551.25.camel@localhost.localdomain>
	 <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
	 <1228327306.5551.36.camel@localhost.localdomain>
	 <35647.88.114.226.209.1228329736.squirrel@webmail.movial.fi>
Return-Path: <kay.sievers@vrfy.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kay.sievers@vrfy.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 3, 2008 at 19:42, Vorobiev Dmitri <dmitri.vorobiev@movial.fi> wrote:
>> On Wed, 2008-12-03 at 18:52 +0100, Kay Sievers wrote:
>>> On Wed, Dec 3, 2008 at 18:08, James Bottomley
>>> <James.Bottomley@hansenpartnership.com> wrote:
>>> > On Wed, 2008-12-03 at 18:24 +0200, Vorobiev Dmitri wrote:
>>> >> > This patch fixes the following compilation warning:
>>> >> >
>>> >> >   CC [M]  drivers/scsi/sgiwd93.o
>>> >> > drivers/scsi/sgiwd93.c:314: warning: initialization from
>>> incompatible
>>> >> > pointer type
>>> >>
>>> >> Any news about this one? I think this patch should go via linux-scsi,
>>> >> unless you would be insisting on pushing it via linux-mips, in which
>>> case
>>> >> I'll politely bug Ralf about it. :)
>>> >
>>> > Looks OK for the local change.
>>> >
>>> > Globally, having driver->remove and platform_driver->remove return int
>>> > instead of void looks wrong.  Particularly when the only use cases are
>>> > in drivers/base/ and they all ignore the return code.
>>> >
>>> > Greg and Kay ... shouldn't we simply redefine the return values for
>>> the
>>> > remove methods in these structures to return void (and thus match the
>>> > use case)?
>>>
>>> Aren't there many many drivers across the tree, using the "int remove"
>>> version?
>>
>> Yes ... since it's a function prototype.
>>
>> However, if drivers/base simply discards the return, it's a trap we
>> shouldn't be setting.
>
> Hmmm, it does look like the return value is discarded, please see
> drivers/base/dd.c::__device_release_driver() for details.
>
> Does this not deserve a good cleanup?

Sure, it might be. If you want to patch hundreds of files, send
patches to maintainers, patch drivers you can not even compile, we
could do that.

We are already in the middle of a ~400 files "struct device" bus_id
conversion, and only very few maintainers respond to these patches. We
also never got any reply to the SCSI bus_id patch we sent weeks ago.
:)

Even when it's "a good cleanup", with maintainers not responding, and
supporting it, it's a real pain to change things like this. But, if
you want to go ahead and do that, let us know.

Kay
