Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 14:21:26 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:51220 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021610AbZESNVU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 14:21:20 +0100
Received: by vs166246.vserver.de with esmtpa (Exim 4.63)
	id 1M6PFu-0000LV-Vv; Tue, 19 May 2009 13:21:19 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] bc47xx : fix ssb irq setup
Date:	Tue, 19 May 2009 15:19:58 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	Daniel Mueller <daniel@danm.de>
References: <4A11DBD4.7070706@free.fr>
In-Reply-To: <4A11DBD4.7070706@free.fr>
X-Move-Along: Nothing to see here. No, really... Nothing.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905191519.59193.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Tuesday 19 May 2009 00:06:12 matthieu castet wrote:
> Hi,
> 
> the current ssb irq setup (in ssb_mipscore_init) have some problem :
> it configure some device on some irq without checking that the irq is 
> not taken by an other device.
> 
> For example in my case PCI host is on irq 0 and IPSEC on irq 3.
> The current code :
> - store in dev->irq that IPSEC irq is 3+2
> - do a set_irq 0->3 on PCI host
> 
> But now IPSEC irq is not routed anymore to the mips code and dev->irq is 
> wrong. This cause problem described in [1].
> 
> This patch try to solve the problem by making set_irq configure the 
> device we want to take the irq on the shared irq0.
> The previous example become :
> - store in dev->irq that IPSEC irq is 3+2
> - do a set_irq 0->3 on PCI host :
>    - irq 3 is already taken by IPSEC. do a set_irq 3->0 on IPSEC
> 
> 
> I also added some code to print the irq configuration before and after 
> irq setup to allow easier debugging. And I add extra checking in 
> ssb_mips_irq to report device without irq or device with not routed irq.
> 
> 
> [1] http://www.danm.de/files/src/bcm5365p/REPORTED_DEVICES
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 

If this works on all devices, I'm OK with this. Please submit to linville@tuxdriver.com
You can add my ack.

-- 
Greetings, Michael.
