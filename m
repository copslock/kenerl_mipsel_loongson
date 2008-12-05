Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 15:44:41 +0000 (GMT)
Received: from crux.i-cable.com ([203.83.115.104]:428 "HELO crux.i-cable.com")
	by ftp.linux-mips.org with SMTP id S24141079AbYLEPoa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2008 15:44:30 +0000
Received: (qmail 23247 invoked by uid 107); 5 Dec 2008 15:44:18 -0000
Received: from 203.83.114.121 by crux (envelope-from <robert.zhangle@gmail.com>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7716. spamassassin: 2.63.  
 Clear:RC:1(203.83.114.121):SA:0(-2.2/5.0):. 
 Processed in 6.217759 secs); 05 Dec 2008 15:44:18 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 5 Dec 2008 15:44:08 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id mB5Fhrqh006526
	for <linux-mips@linux-mips.org>; Fri, 5 Dec 2008 23:44:08 +0800 (HKT)
Date:	Fri, 5 Dec 2008 23:43:42 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: xorg-server-1.5.2 doesn't work because of missing sysfs pci
	resource files
Message-ID: <20081205154339.GA14327@adriano.hkcable.com.hk>
Mail-Followup-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Hi, all,

I have tried xorg-server-1.5.2 on loongson 2f recently.
But I found it doesn't work.
It's mainly because of this change:
http://www.x.org/wiki/PciReworkProposal

In short:
"Rather than duplicating the efforts of kernel developers, X.org needs to use the
interfaces provided by the kernel as much as possible."

I have read some code of libpciaccess, the new library utilizing kernel function
to access pci bus. It will try to mmap this file:
/sys/bus/pci/devices/0000:0x:xx.x/resource0
(replace x with any digit appropriate)
Note there is a 0 at the end of the file name. This file's permission is 600.

However, I found on my loongson system, there is only 
/sys/bus/pci/devices/0000:0x:xx.x/resource
Note there is no 0 at the end.

Then I tried to read kernel code. I found it seems that for mips linux to have
this file, HAVE_PCI_MMAP must be defined. However, it is currently not defined.

Since I am not familiar with PCI, yet.
So could someone please shed some light on this?
Why HAVE_PCI_MMAP is not defined?

Thanks in advance!

Zhang, Le
