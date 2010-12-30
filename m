Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Dec 2010 22:56:29 +0100 (CET)
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:35143 "EHLO
        mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491140Ab0L3V40 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Dec 2010 22:56:26 +0100
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAM+NHE1R8Jhd/2dsb2JhbACkPXS/RQ2FPQQ
Received: from 93.152-240-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.240.152.93])
  by relay.skynet.be with ESMTP; 30 Dec 2010 22:56:18 +0100
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1PYQTq-00043p-9m; Thu, 30 Dec 2010 22:56:18 +0100
Date:   Thu, 30 Dec 2010 22:56:18 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 06/16] watchdog: add driver for the Atheros
        AR71XX/AR724X/AR913X SoCs
Message-ID: <20101230215618.GW3783@infomag.iguana.be>
References: <1293560437-7967-1-git-send-email-juhosg@openwrt.org> <1293560437-7967-7-git-send-email-juhosg@openwrt.org> <20101230102506.GA6521@infomag.iguana.be> <4D1CB8A7.6010409@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D1CB8A7.6010409@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Gabor,

> I have tested that, it works fine. I would have to resend the patch with your
> changes?

No need to sent it again :-)

> > PS: is there a reason why you don't add a module-parameter for wdt_timeout?
> 
> I have no specific reason, simply i did not need that so far. However I can add
> that in a separate patch, or I can integrate that into the current one if you
> prefer.

I prefer that you integrate it in the current one.

Thanks,
Wim.
