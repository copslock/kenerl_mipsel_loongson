Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 19:28:13 +0100 (BST)
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:32745
	"EHLO vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20021633AbXHFS2L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Aug 2007 19:28:11 +0100
Received: from t000e.t.pppool.de ([89.55.0.14] helo=pbook.local)
	by vs166246.vserver.de with esmtpa (Exim 4.50)
	id 1II7GG-00042T-6E; Mon, 06 Aug 2007 20:25:00 +0200
From:	Michael Buesch <mb@bu3sch.de>
To:	Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH -mm 3/4] MIPS: Add BCM947XX to Kconfig
Date:	Mon, 6 Aug 2007 20:24:53 +0200
User-Agent: KMail/1.9.6
Cc:	Aurelien Jarno <aurelien@aurel32.net>,
	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
References: <20070806150931.GH24308@hall.aurel32.net> <200708062009.14971.mb@bu3sch.de> <46B764D3.2030402@openwrt.org>
In-Reply-To: <46B764D3.2030402@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708062024.53952.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Monday 06 August 2007, Felix Fietkau wrote:
> Michael Buesch wrote:
> 
> > Shouldn't we leave the PCICORE an option instead of force selecting
> > it here?
> > My WRT54G doesn't have a (usable) PCI core. So it would work
> > without the driver for it.
> > Especially on the small WAP54G disabling PCIcore support could
> > be useful to reduce the kernel size.
> Yeah, leave it as an option, but I think a 'default y if BCM947XX' on
> the PCICORE option would be reasonable, since many 47xx devices do have pci.

Yeah, probably a good idea.
