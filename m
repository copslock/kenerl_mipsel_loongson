Received:  by oss.sgi.com id <S42229AbQFIRDX>;
	Fri, 9 Jun 2000 10:03:23 -0700
Received: from zebedee.workpc.tds.net ([204.246.4.99]:57604 "EHLO
        zebedee.workpc.tds.net") by oss.sgi.com with ESMTP
	id <S42199AbQFIRDD>; Fri, 9 Jun 2000 10:03:03 -0700
Received: (from usrkkw@localhost)
	by zebedee.workpc.tds.net (8.9.3/8.9.3) id MAA01046;
	Fri, 9 Jun 2000 12:01:46 GMT
	(envelope-from maildrop)
Date:   Fri, 9 Jun 2000 12:01:46 +0000
From:   Ken Wills <kenwills@tds.net>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Linux on Indy
Message-ID: <20000609120146.A1019@zebedee.workpc.tds.net>
References: <20000609174635.A25844@bert.physik.uni-konstanz.de> <NAENLMKGGBDKLPONCDDOKECBCMAA.mailinglist@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <NAENLMKGGBDKLPONCDDOKECBCMAA.mailinglist@ichilton.co.uk>; from mailinglist@ichilton.co.uk on Fri, Jun 09, 2000 at 05:05:05PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

* Ian Chilton <mailinglist@ichilton.co.uk> [000609 11:07]:
> eakkK!
> 
> Sorry to be a pain..but is there anyone that wouldn't mind spening a few
> mins just to list the commands that I would use to do this...
> 
> I have been using Windoze and Linux for years, but am *completely* new to
> SGI/Indy's and IRIX.
> I don't even have a clue how to partition use the 2nd hard disk I have put
> in....
> 

There are a couple of docs on http://www.linux.sgi.com that describe how to 
install Linux on an Indy. If you don't know the device names under irix,
user the system manager to install and partition your new disk - then you'll
see it's device name in the disk-manager app thingy - after that, a few minutes
with 'fx' and 'man fx' should be sufficient, or you can consult a copy of
Frisch's 'Essential System Administraton' (O'Reilly) for a step by step
on adding disks under Irix.

The linux installer is capable of partitioning your disk too, AFAIR, use
fdisk though, and not disk druid.

Hope that helps a little,

Ken
