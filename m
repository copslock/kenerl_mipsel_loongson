Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id MAA21014
	for <pstadt@stud.fh-heilbronn.de>; Fri, 27 Aug 1999 12:10:26 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA08185; Fri, 27 Aug 1999 03:03:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA64264
	for linux-list;
	Fri, 27 Aug 1999 02:54:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA86361
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 27 Aug 1999 02:54:33 -0700 (PDT)
	mail_from (oeser@darmstadt.gmd.de)
Received: from sonne.darmstadt.gmd.de (sonne.darmstadt.gmd.de [141.12.62.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA07103
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Aug 1999 02:54:09 -0700 (PDT)
	mail_from (oeser@darmstadt.gmd.de)
Received: from darmstadt.gmd.de (VaX@pc-dime [141.12.60.3])
	by sonne.darmstadt.gmd.de (8.8.8/8.8.5) with ESMTP id LAA00970
	for <linux@cthulhu.engr.sgi.com>; Fri, 27 Aug 1999 11:54:05 +0200 (MET DST)
Message-ID: <37C6618F.8FFA2D80@darmstadt.gmd.de>
Date: Fri, 27 Aug 1999 11:59:43 +0200
From: Jens Oeser <oeser@darmstadt.gmd.de>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Re: Booting linux does not work fine.
References: <37C4F2A9.543E0E98@darmstadt.gmd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Hi!

I got it working now, with vmlinux-r4400 ... other kernels are booting
but kflushd messes up my screen. The kflush always want to tell me when
he flushes something ... i really would have the sound kernel, but i
cannot use it because of kflushd trouble, anyone expierences with that?
I modified syslog.conf, but it doesn't work. Seems to be direct from the
kernel. I try i selfcompiled kernel today, maybe this helps me.
Another problem, If i try to add a swap partition, it only get's a size
of 20mb with fx, if i resize, the partition is not longer recognized as
swap, and the hardhat install program does not let me make it to a swap.
Is there i way to get it managed, without using linux tools for that?

regards.
Jens Oeser.









Jens Oeser wrote:
> 
> Hi!
> 
> I tried to install linux to my sgi indy yesterday, kernel starts up
> normally and hangs after "Freeing unused kernel memory 44k freed". Then
> i only can reboot the machine. I really don't find the thing causing
> that, maybe someone can give me an advise to get linux to work fine.
> Hardware:
> ip22 175mhz
> 64/128mb ram (Depends which machine)
> 2gb hdd (2nd machine 2x1GB).
> hinv says that i have a indy 24bit ... does this card is supported? I
> think so, because kernel messages are printed on the screen, so entire
> linux should do so.
> So how can i get linux working?
> 
> regards.
> Jens Oeser
