Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 19:05:24 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:26798 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S3950149AbWATTFC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 19:05:02 +0000
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k0KJ8mNY002605;
	Fri, 20 Jan 2006 14:08:48 -0500
Received: from [192.168.1.2] (blacksburg-bsr1-69-170-32-128.chvlva.adelphia.net [69.170.32.128])
	by vivi.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id EYX97794 (AUTH spbecker);
	Fri, 20 Jan 2006 14:08:43 -0500 (EST)
Message-ID: <43D13539.9040406@gentoo.org>
Date:	Fri, 20 Jan 2006 14:08:41 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060118)
MIME-Version: 1.0
To:	Marc Karasek <marckarasek@ivivity.com>
CC:	Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>	 <43CC39A0.8080704@gentoo.org>	 <1137515220.11738.2.camel@localhost.localdomain>	 <43CD9568.1000707@gentoo.org>	 <1137704865.22994.7.camel@localhost.localdomain>	 <43D06305.8070908@gentoo.org> <1137783751.22994.31.camel@localhost.localdomain>
In-Reply-To: <1137783751.22994.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Marc Karasek wrote:
> I am not entirely sold on this initramfs.  
> 
> I have a question:
> 
>>From what I have read so far, it seems that this is meant as a stepping
> stone to booting/mounting the real system.  Has anyone used this where
> the initramfs is the filesystem and the endpoint in the boot process?  

Sure.  Our Gentoo netboot installer images do this.

-Steve
