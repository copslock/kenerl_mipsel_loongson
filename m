Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Sep 2003 15:22:13 +0100 (BST)
Received: from altrade.nijmegen.internl.net ([IPv6:::ffff:217.149.192.18]:62404
	"EHLO altrade.nijmegen.internl.net") by linux-mips.org with ESMTP
	id <S8225392AbTIFOVl>; Sat, 6 Sep 2003 15:21:41 +0100
Received: from whale.dutch.mountain by altrade.nijmegen.internl.net
	via 1Cust128.tnt37.rtm1.nld.da.uu.net [213.116.168.128] with ESMTP for <linux-mips@linux-mips.org>
	id h86ELdFC003549 (8.12.9/2.04); Sat, 6 Sep 2003 16:21:39 +0200 (MET DST)
Received: from (locally authorised broken client using invalid hostname!) localhost (really [127.0.0.1]) by whale.dutch.mountain
	via in.smtpd with esmtp (ident ravdberg using rfc1413)
	id <m19vbd1-000HFgC@whale.dutch.mountain> (Debian Smail3.2.0.114)
	Sat, 6 Sep 2003 13:53:19 +0200 (CEST) 
Date: Sat, 6 Sep 2003 13:53:19 +0200 (CEST)
From: Richard van den Berg <ravdberg@inter.NL.net>
X-Sender: ravdberg@whale.dutch.mountain
To: linux-mips@linux-mips.org
Subject: Re: hwclock error on DECstation 5000/133 with 2.4.22
In-Reply-To: <Pine.GSO.3.96.1030904161032.12210F-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.21.0309061336580.9097-100000@whale.dutch.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ravdberg@inter.NL.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ravdberg@inter.NL.net
Precedence: bulk
X-list: linux-mips

On Thu, 4 Sep 2003, Maciej W. Rozycki wrote:

> > Kernel 2.4.17 (Debian kernel-source package) didn't give following error: 
> > fortuna:~# hwclock
> > hwclock: ioctl() to /dev/rtc to turn on update interrupts failed unexpectedly, errno=25: Inappropriate ioctl for device.
> > fortuna:~# hwclock -v
> > hwclock 2.4c/util-linux-2.11n
> 
>  Please upgrade util-linux -- this has been fixed long time ago.

Thanks, hwclock from util-linux-2.11z works fine.

Regards,
Richard
