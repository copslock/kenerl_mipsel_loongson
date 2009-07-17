Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2009 16:43:33 +0200 (CEST)
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:65290 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492377AbZGQOn0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Jul 2009 16:43:26 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAOMpYEpR92xv/2dsb2JhbADRAgmEBAU
Received: from 111.108-247-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.247.108.111])
  by relay.skynet.be with ESMTP; 17 Jul 2009 16:43:20 +0200
Received: from wim by infomag with local (Exim 4.69)
	(envelope-from <wim@infomag.iguana.be>)
	id 1MRoee-0003JC-Mg; Fri, 17 Jul 2009 16:43:20 +0200
Date:	Fri, 17 Jul 2009 16:43:20 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] ar7: make board code register ar7_wdt as a
	platform device
Message-ID: <20090717144320.GA23797@infomag.iguana.be>
References: <200907151209.35566.florian@openwrt.org> <20090717133009.GA7396@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090717133009.GA7396@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi All,

> > This patch makes the board code register the ar7_wdt
> > driver as a platform device. We move the dynamic
> > resource calculation here since the driver should not be
> > aware of the AR7 SoC version it is running on.
> > 
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> 
> Thanks, queued for 2.6.32.  Haven't heared from Wim yet ...

Review planned this weekend.

Kind regards,
Wim.
