Received:  by oss.sgi.com id <S42219AbQFJBfR>;
	Fri, 9 Jun 2000 18:35:17 -0700
Received: from serak.svc.tds.net ([204.246.1.5]:13456 "EHLO serak.svc.tds.net")
	by oss.sgi.com with ESMTP id <S42199AbQFJBez>;
	Fri, 9 Jun 2000 18:34:55 -0700
Received: from spanky.yaberk.int (root@mawi0pool1-a31.madison.tds.net [204.71.148.32])
	by serak.svc.tds.net (8.9.3/8.9.3) with ESMTP id UAA03981;
	Fri, 9 Jun 2000 20:33:31 -0500 (CDT)
Received: (from kenwills@localhost)
	by spanky.yaberk.int (8.9.3/8.9.3) id UAA00973;
	Fri, 9 Jun 2000 20:30:46 -0500 (CDT)
	(envelope-from kenwills)
Date:   Fri, 9 Jun 2000 20:30:44 -0500
From:   Ken Wills <kenwills@tds.net>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Linux on Indy
Message-ID: <20000609203044.A774@spanky.yaberk.int>
References: <20000609161436.A2098@zebedee.workpc.tds.net> <NAENLMKGGBDKLPONCDDOIEDGCMAA.mailinglist@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <NAENLMKGGBDKLPONCDDOIEDGCMAA.mailinglist@ichilton.co.uk>; from mailinglist@ichilton.co.uk on Fri, Jun 09, 2000 at 11:53:51PM +0100
X-Mailer: Mutt http://www.mutt.org/
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> OK...got the 2nd hard disk (/dev/dsk/dsk0d2s7) initialised and mounted
> (every time at boot) into /hd2 by using System Manager..

OK - Great you found your device names. Now you can (a) play with fx a bit
so you understand how that side of things works, and repartition your disk
in preperation for the installation, or (b) use the linux fdisk to set up
your partitions when the install begins.

> 
> Now, do I copy the hardhat tar.gz file to the Indy, and un-tar it into this
> directory??
> Am I correct?

No - you untar the hardhat tarfile to your nfsroot directory on the machine
that will act as your nfs server. Follow the instructions on setting up
bootpd etc. Then boot your indy to a prom and do:

boot bootp():vmlinux ... (rest of installation instructions.)

> 
> Then what?

If you've set up everything correctly, you'll tftp the kernel from your
server, mount your root fs over nfs, and the redhat installer will start.

> 
> Sorry to be a pain......i'm looking at the hardhat instructions now, and
> they are not making much sense  :(

You should start by setting up bootp/tftp/nfs on the machine that will
serve the installation image to the indy.

Ken
-- 

Ken Wills
kenwills@tds.net
