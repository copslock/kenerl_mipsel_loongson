Received:  by oss.sgi.com id <S42226AbQFJDWr>;
	Fri, 9 Jun 2000 20:22:47 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:47476 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42199AbQFJDWU>;
	Fri, 9 Jun 2000 20:22:20 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id UAA29657
	for <linux-mips@oss.sgi.com>; Fri, 9 Jun 2000 20:17:24 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id XAA02713; Fri, 9 Jun 2000 23:13:28 -0300
Date:   Fri, 9 Jun 2000 23:13:28 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
cc:     linux-mips@oss.sgi.com
Subject: RE: Linux on Indy
In-Reply-To: <NAENLMKGGBDKLPONCDDOGECPCMAA.mailinglist@ichilton.co.uk>
Message-ID: <Pine.SGI.4.10.10006092309040.2700-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Fri, 9 Jun 2000, Ian Chilton wrote:

> When I go into Disk Manager, I only see SystemDisk(0,1) 4.04GB, which is my
> normal IRIX disk......does this mean my 2nd disk isn't working?
> 
> The 2nd disk I put in was a 1GB, straight out of my Linux box, still with an
> EXT2 partition on....does this matter?
> 

Yes, it does.  IRIX won't like the Linux partition table one bit.  The
simplest thing to do would be to stick it in the linux box and do this:

dd if=/dev/zero of=/dev/sd# bs=512 count=10

Where /dev/sd# is the SCSI device, IE /dev/sdb, /dev/sdc, etc...

Don't use a name with a numeric suffix or you'll just zap the partition,
not the partition table itself.

However, IRIX should have seen the drive regardless, but would have told
you it could not create a file system on it or some such thing, so there's
still the possibility something is not in place right here.
