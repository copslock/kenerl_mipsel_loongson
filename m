Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 21:07:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39911 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133645AbWFWUH0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2006 21:07:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5NK7PWi004161;
	Fri, 23 Jun 2006 21:07:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5NK7Mkc004150;
	Fri, 23 Jun 2006 21:07:22 +0100
Date:	Fri, 23 Jun 2006 21:07:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Mack <daniel@caiaq.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] au1200 USB - EHCI and OHCI fixes
Message-ID: <20060623200722.GA4021@linux-mips.org>
References: <5798565C-F3E1-4EB5-8886-51D65BEFEF02@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5798565C-F3E1-4EB5-8886-51D65BEFEF02@caiaq.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 23, 2006 at 06:52:09PM +0200, Daniel Mack wrote:

> I received an DBAU1200 eval kit from AMD a few days ago and tried to
> enable the USB2 port, but the current linux-2.6 GIT did not even
> compile with CONFIG_SOC_1200, CONFIG_SOC_AU1X00, CONFIG_USB_EHCI and
> CONFIG_USB_OHCI set.
> Furthermore, in ehci-hcd.c, platform_driver_register() was called with
> an improper argument of type 'struct device_driver *' which of course
> ended up in a kernel oops. How could that ever have worked on your
> machines?
> 
> Anyway, here's a trivial patch that makes the USB subsystem working
> on my board for both OHCI and EHCI.
> It also removes the /* FIXME use "struct platform_driver" */.

Patch is looking good but has been linewrapped, can you resend?

  Ralf
