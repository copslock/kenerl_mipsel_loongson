Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2003 22:10:13 +0100 (BST)
Received: from altrade.nijmegen.internl.net ([IPv6:::ffff:217.149.192.18]:62949
	"EHLO altrade.nijmegen.internl.net") by linux-mips.org with ESMTP
	id <S8225193AbTIBVJl>; Tue, 2 Sep 2003 22:09:41 +0100
Received: from whale.dutch.mountain by altrade.nijmegen.internl.net
	via 1Cust209.tnt41.rtm1.nld.da.uu.net [213.117.0.209] with ESMTP for <linux-mips@linux-mips.org>
	id h82L9dFC027626 (8.12.9/2.04); Tue, 2 Sep 2003 23:09:39 +0200 (MET DST)
Received: from (locally authorised broken client using invalid hostname!) localhost (really [127.0.0.1]) by whale.dutch.mountain
	via in.smtpd with esmtp (ident ravdberg using rfc1413)
	id <m19uIGa-000HHJC@whale.dutch.mountain> (Debian Smail3.2.0.114)
	Tue, 2 Sep 2003 23:00:44 +0200 (CEST) 
Date: Tue, 2 Sep 2003 23:00:44 +0200 (CEST)
From: Richard van den Berg <ravdberg@inter.NL.net>
X-Sender: ravdberg@whale.dutch.mountain
To: linux-mips@linux-mips.org
Subject: hwclock error on DECstation 5000/133 with 2.4.22
Message-ID: <Pine.LNX.4.21.0309022258540.17245-100000@whale.dutch.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ravdberg@inter.NL.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ravdberg@inter.NL.net
Precedence: bulk
X-list: linux-mips

Hello,

Kernel 2.4.17 (Debian kernel-source package) didn't give following error: 
fortuna:~# hwclock
hwclock: ioctl() to /dev/rtc to turn on update interrupts failed unexpectedly, errno=25: Inappropriate ioctl for device.
fortuna:~# hwclock -v
hwclock 2.4c/util-linux-2.11n
fortuna:~# uname -a
Linux fortuna 2.4.22 #1 Thu Aug 28 06:51:00 CEST 2003 mips unknown

2.4.22 checked out august 27th, system time gets set, don't know if above
message has other effects. With this kernel recognizes the LK401 keyboard,
2.4.17 gave id 186.

Regards,
Richard
