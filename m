Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2009 13:02:36 +0000 (GMT)
Received: from crux.i-cable.com ([203.83.115.104]:43231 "HELO crux.i-cable.com")
	by ftp.linux-mips.org with SMTP id S21299246AbZBTNCd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Feb 2009 13:02:33 +0000
Received: (qmail 23893 invoked by uid 107); 20 Feb 2009 13:02:19 -0000
Received: from 203.83.114.121 by crux (envelope-from <robert.zhangle@gmail.com>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/8786. spamassassin: 2.63.  
 Clear:RC:1(203.83.114.121):SA:0(-2.2/5.0):. 
 Processed in 5.415651 secs); 20 Feb 2009 13:02:19 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 20 Feb 2009 13:02:13 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n1KD22wp024057
	for <linux-mips@linux-mips.org>; Fri, 20 Feb 2009 21:02:13 +0800 (HKT)
Date:	Fri, 20 Feb 2009 21:01:57 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: [RFC] implement syscall pciconfig_iobase
Message-ID: <20090220130156.GA14095@adriano.hkcable.com.hk>
Mail-Followup-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

This is for xorg-server support.

Currently, xorg-server on loongson need a patch:
http://www.gentoo-cn.org/gitweb/?p=loongson;a=blob;f=x11-base/xorg-server/files/xorg-server-1.5.3-loongson.patch;h=9c48b3752b7f14b6603524f46ae832f312e7c6fe;hb=HEAD#l37
Please note that line 37, the last parameter to mmap, which is the ioBase_phys,
is hardcoded.

This patch no long applies to xorg-server git master.
So I took at look at the code trying to find out why. And then I found powerpc
has implemented this syscall: pciconfig_iobase

Please take a look at the following code:
http://cgit.freedesktop.org/xorg/xserver/tree/hw/xfree86/os-support/linux/lnx_video.c#n517

At the first glance, it is absolutely a good idea to implement this for mips,
too. However when I read pciconfig_iobase's manpage, I found this sentence:

       Most  of  the interaction with PCI devices is already handled by the
       kernel PCI layer, and thus these calls should not normally need to be
       accessed from userspace.

So I decided to bring this issue here, so that you guys could give me some
advice.

Thanks in advance!

Zhang, Le
