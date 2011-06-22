Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2011 10:58:20 +0200 (CEST)
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:1388 "EHLO
        mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491072Ab1FVI6Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jun 2011 10:58:16 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAF2tAU5tgwPS/2dsb2JhbABUpw14iHMCwB8Ohh8EmWeIEQ
Received: from 210.3-131-109.adsl-dyn.isp.belgacom.be (HELO infomag) ([109.131.3.210])
  by relay.skynet.be with ESMTP; 22 Jun 2011 10:58:10 +0200
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1QZJGD-0001Of-SL; Wed, 22 Jun 2011 10:58:09 +0200
Date:   Wed, 22 Jun 2011 10:58:09 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 1/5 v3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead
        of printk()
Message-ID: <20110622085809.GS23305@infomag.iguana.be>
References: <201106151915.09729.florian@openwrt.org> <201106221024.20485.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106221024.20485.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17940

Hi Florian,

> On Wednesday 15 June 2011 19:15:09 Florian Fainelli wrote:
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > No changes in v1, v2 and v3
> 
> Wim, these are mostly fixes for the driver, do you prefer they get merged with the MIPS tree?

No, I had them in linux-2.6-watchdog-next since this weekend allready and was planning to sent the fixes upstream.
But I think I fotgot to e-mail about it. :-(

Kind regards,
Wim.
