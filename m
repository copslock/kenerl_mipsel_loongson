Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2009 07:26:36 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:23522 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21103106AbZCLH0T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Mar 2009 07:26:19 +0000
Received: (qmail 32032 invoked by uid 1000); 12 Mar 2009 08:26:18 +0100
Date:	Thu, 12 Mar 2009 08:26:18 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: __do_IRQ() going away
Message-ID: <20090312072618.GA31978@roarinelk.homelinux.net>
References: <20090311112806.GA24541@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090311112806.GA24541@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, Mar 11, 2009 at 12:28:06PM +0100, Ralf Baechle wrote:
> __do_IRQ() is deprecated since a long time and there are plans to remove
> it for 2.6.30.  The MIPS platforms seem to fall into three classes:

>  o Platforms that still seem to rely on __do_IRQ():
>      o All Alchemy platforms:
> 	db1000_defconfig, db1100_defconfig, db1200_defconfig, db1500_defconfig,
> 	db1550_defconfig, mtx1_defconfig, pb1100_defconfig, pb1500_defconfig
> 	and pb1550_defconfig

I believe that the defconfigs just need to be updated.  There are no
__do_IRQ invocations in the alchemy/ tree anymore, and generic hardirqs are
enabled by CONFIG_SOC_AU1X00.

Grüsse,
	Manuel Lauss
