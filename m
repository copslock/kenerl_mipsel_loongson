Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 20:52:25 +0000 (GMT)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:34985 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S24086283AbYLCUwQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 20:52:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id CCA5B9751;
	Wed,  3 Dec 2008 14:52:05 -0600 (CST)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SqPFeLSV5vXi; Wed,  3 Dec 2008 14:52:04 -0600 (CST)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 4BF4D80A2;
	Wed,  3 Dec 2008 14:52:04 -0600 (CST)
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in
	sgiwd93.c
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Kay Sievers <kay.sievers@vrfy.org>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	Greg KH <greg@kroah.com>
In-Reply-To: <ac3eb2510812031229l51912169o3e96346ed51c48f0@mail.gmail.com>
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <46353.88.114.226.209.1228321494.squirrel@webmail.movial.fi>
	 <1228324123.5551.25.camel@localhost.localdomain>
	 <ac3eb2510812030952k5b57a9c7qb68e3684de170d75@mail.gmail.com>
	 <1228327306.5551.36.camel@localhost.localdomain>
	 <35647.88.114.226.209.1228329736.squirrel@webmail.movial.fi>
	 <ac3eb2510812031051k9d9312bma119bfae35afc230@mail.gmail.com>
	 <1228330800.5551.58.camel@localhost.localdomain>
	 <ac3eb2510812031229l51912169o3e96346ed51c48f0@mail.gmail.com>
Content-Type: text/plain
Date:	Wed, 03 Dec 2008 14:52:09 -0600
Message-Id: <1228337529.5551.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-12-03 at 21:29 +0100, Kay Sievers wrote:
> On Wed, Dec 3, 2008 at 20:00, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >> We are already in the middle of a ~400 files "struct device" bus_id
> >> conversion, and only very few maintainers respond to these patches. We
> >> also never got any reply to the SCSI bus_id patch we sent weeks ago.
> >> :)
> >
> > When did you send it?  Searching the scsi archives on bus_id produces no
> > results, what was the subject line?
> 
> http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=driver-core/bus_id-scsi.patch;hb=HEAD

Hmm, OK ... if you want a review, over the SCSI list is best.

Things like this:


> --- a/drivers/scsi/scsi_ioctl.c
> 182 +++ b/drivers/scsi/scsi_ioctl.c
> 183 @@ -170,7 +170,8 @@ static int scsi_ioctl_get_pci(struct scs
> 184  
> 185          if (!dev)
> 186                 return -ENXIO;
> 187
> -        return copy_to_user(arg, dev->bus_id, sizeof(dev->bus_id))? -EFAULT: 0;
> 188 +        return copy_to_user(arg,
> 189
> +                           dev_name(dev), strlen(dev_name(dev)))? -EFAULT: 0;
> 190  }

Give cause for concern:  in the original, we know we scribble over 20
bytes of user space.  With the new one we scribble over an unknown
number (which could potentially be much greater than 20).  That's an
accident waiting to happen in userspace.

James
