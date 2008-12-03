Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 21:34:05 +0000 (GMT)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:4026 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S24086602AbYLCVd5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 21:33:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 544419751;
	Wed,  3 Dec 2008 15:33:44 -0600 (CST)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3KreuqQkJ-1; Wed,  3 Dec 2008 15:33:42 -0600 (CST)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 7463C80A2;
	Wed,  3 Dec 2008 15:33:40 -0600 (CST)
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in
	sgiwd93.c
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Kay Sievers <kay.sievers@vrfy.org>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	Greg KH <greg@kroah.com>
In-Reply-To: <ac3eb2510812031328x38559660rcc13db195e01ea15@mail.gmail.com>
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
	 <ac3eb2510812031328x38559660rcc13db195e01ea15@mail.gmail.com>
Content-Type: text/plain
Date:	Wed, 03 Dec 2008 15:33:45 -0600
Message-Id: <1228340025.5551.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-12-03 at 22:28 +0100, Kay Sievers wrote:
> On Wed, Dec 3, 2008 at 22:02, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Wed, 2008-12-03 at 21:59 +0100, Kay Sievers wrote:
> >> On Wed, Dec 3, 2008 at 21:52, James Bottomley
> >> <James.Bottomley@hansenpartnership.com> wrote:
> >> > On Wed, 2008-12-03 at 21:29 +0100, Kay Sievers wrote:
> >> >> On Wed, Dec 3, 2008 at 20:00, James Bottomley
> >> >> <James.Bottomley@hansenpartnership.com> wrote:
> >> >> >> We are already in the middle of a ~400 files "struct device" bus_id
> >> >> >> conversion, and only very few maintainers respond to these patches. We
> >> >> >> also never got any reply to the SCSI bus_id patch we sent weeks ago.
> >> >> >> :)
> >> >> >
> >> >> > When did you send it?  Searching the scsi archives on bus_id produces no
> >> >> > results, what was the subject line?
> >> >>
> >> >> http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=driver-core/bus_id-scsi.patch;hb=HEAD
> >> >
> >> > Hmm, OK ... if you want a review, over the SCSI list is best.
> >> >
> >> > Things like this:
> >> >
> >> >
> >> >> --- a/drivers/scsi/scsi_ioctl.c
> >> >> 182 +++ b/drivers/scsi/scsi_ioctl.c
> >> >> 183 @@ -170,7 +170,8 @@ static int scsi_ioctl_get_pci(struct scs
> >> >> 184
> >> >> 185          if (!dev)
> >> >> 186                 return -ENXIO;
> >> >> 187
> >> >> -        return copy_to_user(arg, dev->bus_id, sizeof(dev->bus_id))? -EFAULT: 0;
> >> >> 188 +        return copy_to_user(arg,
> >> >> 189
> >> >> +                           dev_name(dev), strlen(dev_name(dev)))? -EFAULT: 0;
> >> >> 190  }
> >> >
> >> > Give cause for concern:  in the original, we know we scribble over 20
> >> > bytes of user space.  With the new one we scribble over an unknown
> >> > number (which could potentially be much greater than 20).  That's an
> >> > accident waiting to happen in userspace.
> >>
> >> Yeah, but the name will have no real limit. What should we do here?
> >> Just Truncate at 20, because we "know" it's not longer?
> >
> > Well, the problem is the stupid ioctl which gives nowhere to say how
> > many bytes the buffer is.  For safety's sake, yes, I think you have to
> > limit it to 20 bytes.  Otherwise, on the day we introduce long names
> > some random application using this ioctl will die with data corruption
> > and that will be extremely hard to debug.
> 
> Do you want to take over the patch to the scsi tree, and we will work
> from there. It's through Greg's tree in -next since a while.

Sure ... can you send a copy of it rather than me having to pull it out
of your git tree.

Thanks,

James
