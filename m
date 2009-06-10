Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 20:07:06 +0100 (WEST)
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:29385 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024070AbZFJTGJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2009 20:06:09 +0100
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAegL0pR9cDZ/2dsb2JhbADRJQiEBQU
Received: from 217.192-245-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.245.192.217])
  by relay.skynet.be with ESMTP; 10 Jun 2009 21:06:02 +0200
Received: from wim by infomag with local (Exim 4.69)
	(envelope-from <wim@infomag.iguana.be>)
	id 1MET7a-0002Na-5t; Wed, 10 Jun 2009 21:06:02 +0200
Date:	Wed, 10 Jun 2009 21:06:02 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	matthieu castet <castet.matthieu@free.fr>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	biblbroks@sezampro.rs
Subject: Re: add bcm47xx watchdog driver
Message-ID: <20090610190602.GL16090@infomag.iguana.be>
References: <4A282D98.6020004@free.fr> <20090605124813.d7666ed0.akpm@linux-foundation.org> <4A29805D.60205@free.fr> <200906081615.45889.florian@openwrt.org> <20090610171732.GI16090@infomag.iguana.be> <4A2FFFDA.6010807@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A2FFFDA.6010807@free.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Matthieu,

>> +
>> +#define WDT_DEFAULT_TIME	30	/* seconds */
>> +#define WDT_MAX_TIME		255	/* seconds */
> Why have changed this from 256 to 255 ?

Since you use a timer to control the real watchdog, the wdt_time function is arbitraty anyway.
Most watchdog drivers use 0xFFFF. Since you only went to 256 it made more sense to have it as 0xFF which is 255.
We can make it 65535 also. 

>> +}
>> +
>> +static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
>> +	nsigned long code, void *unused)
>        ^^^^
> Does this build ?

Nope. should be unsigned.

Kind regards,
Wim.
