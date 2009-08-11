Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2009 15:23:47 +0200 (CEST)
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:60222 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492805AbZHKNXk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2009 15:23:40 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEALcHgUpR92pY/2dsb2JhbADSDgmEEAWCJw
Received: from 88.106-247-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.247.106.88])
  by relay.skynet.be with ESMTP; 11 Aug 2009 15:01:34 +0200
Received: from wim by infomag with local (Exim 4.69)
	(envelope-from <wim@infomag.iguana.be>)
	id 1Maqyr-00039X-UF; Tue, 11 Aug 2009 15:01:33 +0200
Date:	Tue, 11 Aug 2009 15:01:33 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] ar7_wdt: convert to become a platform driver
Message-ID: <20090811130133.GH4302@infomag.iguana.be>
References: <200907151210.20294.florian@openwrt.org> <20090718214958.GA24850@infomag.iguana.be> <200907211211.35085.florian@openwrt.org> <200908111452.28418.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908111452.28418.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Florian,

> > From: Florian Fainelli <florian@openwrt.org>
> > Subject: [PATCH 2/2 v2] ar7_wdt: convert to become a platform driver
> >
> > This patch converts the ar7_wdt driver to become
> > a platform driver. The AR7 SoC specific identification
> > and base register calculation is performed by the board
> > code, therefore we no longer need to have access to
> > ar7_chip_id. We also remove the reboot notifier code to
> > use the platform shutdown method as Wim suggested.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Any news on this patch ?

This one was ok for me. I think we agreed that Ralf would take it up in his tree.
I can also take it up in my next tree still.

Ralf, did you add the patch allready or will I do it?

Thanks in advance,
Kind regards,
Wim.
