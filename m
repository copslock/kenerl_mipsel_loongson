Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 06:15:03 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:44815 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20038999AbXBBGO6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 06:14:58 +0000
Received: (qmail 23692 invoked by uid 1000); 2 Feb 2007 07:13:57 +0100
Date:	Fri, 2 Feb 2007 07:13:56 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: 2.6.20-rc: au1x irqs broken
Message-ID: <20070202061356.GA23661@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

mips-git commit 1603b5aca14f15b34848fb5594d0c7b6333b99144 broke
au1x irqs. The kernel boots; however it is not able to
mount nfsroot. Reverting the arch/mips/au1000/common/irq.c
bits of the above commit fixes it.

Thanks,

-- 
 ml.
