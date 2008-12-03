Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 21:28:55 +0000 (GMT)
Received: from qb-out-1314.google.com ([72.14.204.170]:22520 "EHLO
	qb-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S24086568AbYLCV2t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 21:28:49 +0000
Received: by qb-out-1314.google.com with SMTP id q14so4095030qbq.32
        for <linux-mips@linux-mips.org>; Wed, 03 Dec 2008 13:28:47 -0800 (PST)
Received: by 10.210.59.3 with SMTP id h3mr15843149eba.150.1228339726162;
        Wed, 03 Dec 2008 13:28:46 -0800 (PST)
Received: by 10.210.47.20 with HTTP; Wed, 3 Dec 2008 13:28:46 -0800 (PST)
Message-ID: <ac3eb2510812031328x38559660rcc13db195e01ea15@mail.gmail.com>
Date:	Wed, 3 Dec 2008 22:28:46 +0100
From:	"Kay Sievers" <kay.sievers@vrfy.org>
To:	"James Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in sgiwd93.c
Cc:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	"Greg KH" <greg@kroah.com>
In-Reply-To: <1228338142.5551.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
	 <1228327306.5551.36.camel@localhost.localdomain>
	 <35647.88.114.226.209.1228329736.squirrel@webmail.movial.fi>
	 <ac3eb2510812031051k9d9312bma119bfae35afc230@mail.gmail.com>
	 <1228330800.5551.58.camel@localhost.localdomain>
	 <ac3eb2510812031229l51912169o3e96346ed51c48f0@mail.gmail.com>
	 <1228337529.5551.72.camel@localhost.localdomain>
	 <ac3eb2510812031259v1a4ebe25tc841daaa2fe5a722@mail.gmail.com>
	 <1228338142.5551.77.camel@localhost.localdomain>
Return-Path: <kay.sievers@vrfy.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kay.sievers@vrfy.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 3, 2008 at 22:02, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2008-12-03 at 21:59 +0100, Kay Sievers wrote:
>> On Wed, Dec 3, 2008 at 21:52, James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>> > On Wed, 2008-12-03 at 21:29 +0100, Kay Sievers wrote:
>> >> On Wed, Dec 3, 2008 at 20:00, James Bottomley
>> >> <James.Bottomley@hansenpartnership.com> wrote:
>> >> >> We are already in the middle of a ~400 files "struct device" bus_id
>> >> >> conversion, and only very few maintainers respond to these patches. We
>> >> >> also never got any reply to the SCSI bus_id patch we sent weeks ago.
>> >> >> :)
>> >> >
>> >> > When did you send it?  Searching the scsi archives on bus_id produces no
>> >> > results, what was the subject line?
>> >>
>> >> http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=driver-core/bus_id-scsi.patch;hb=HEAD
>> >
>> > Hmm, OK ... if you want a review, over the SCSI list is best.
>> >
>> > Things like this:
>> >
>> >
>> >> --- a/drivers/scsi/scsi_ioctl.c
>> >> 182 +++ b/drivers/scsi/scsi_ioctl.c
>> >> 183 @@ -170,7 +170,8 @@ static int scsi_ioctl_get_pci(struct scs
>> >> 184
>> >> 185          if (!dev)
>> >> 186                 return -ENXIO;
>> >> 187
>> >> -        return copy_to_user(arg, dev->bus_id, sizeof(dev->bus_id))? -EFAULT: 0;
>> >> 188 +        return copy_to_user(arg,
>> >> 189
>> >> +                           dev_name(dev), strlen(dev_name(dev)))? -EFAULT: 0;
>> >> 190  }
>> >
>> > Give cause for concern:  in the original, we know we scribble over 20
>> > bytes of user space.  With the new one we scribble over an unknown
>> > number (which could potentially be much greater than 20).  That's an
>> > accident waiting to happen in userspace.
>>
>> Yeah, but the name will have no real limit. What should we do here?
>> Just Truncate at 20, because we "know" it's not longer?
>
> Well, the problem is the stupid ioctl which gives nowhere to say how
> many bytes the buffer is.  For safety's sake, yes, I think you have to
> limit it to 20 bytes.  Otherwise, on the day we introduce long names
> some random application using this ioctl will die with data corruption
> and that will be extremely hard to debug.

Do you want to take over the patch to the scsi tree, and we will work
from there. It's through Greg's tree in -next since a while.

Kay
