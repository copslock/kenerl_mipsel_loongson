Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 17:57:05 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:9659 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24108197AbYLIR5D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Dec 2008 17:57:03 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB9Hv2tZ022750
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2008 17:57:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB9Hv2h8022748
	for linux-mips@linux-mips.org; Tue, 9 Dec 2008 17:57:02 GMT
Date:	Tue, 9 Dec 2008 17:57:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci
	resource files
Message-ID: <20081209175701.GA22661@linux-mips.org>
References: <20081205154339.GA14327@adriano.hkcable.com.hk> <20081206102030.GA9410@linux-mips.org> <20081206164706.GB14327@adriano.hkcable.com.hk> <20081209172245.GA2741@adriano.hkcable.com.hk> <20081209173907.GB2741@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081209173907.GB2741@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 10, 2008 at 01:39:08AM +0800, Zhang Le wrote:

> > I have build a new kernel with this patch.
> > Now I have the resource{0,1} file with permission 600.
> > However, X is not working yet, since there is an undefined reference in sis's
> > X driver.
> 
> It is working now! Just forget to load "vbe" module.
> Thanks!

Wonderful, thanks for testing!

Now, my patch doesn't try to handle all the caching modes.  Any mapping
will be uncached which is guaranteed to deliver the lowest possible
performance.  Registers should be mapped uncached but a framebuffer
will usually work best if mapped in uncached accelerated mode.  On
most MIPS implementations the effect of mapping something multiple times
in different caching modes is undefined so that needs to be avoided
which will require some bookkeeping etc.  Too much for 2.6.28 but this
simple solution seems harmless enough to be pushed for 2.6.28 and
-stable.

  Ralf
