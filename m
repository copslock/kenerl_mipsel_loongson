Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Apr 2009 11:49:10 +0100 (BST)
Received: from pyxis.i-cable.com ([203.83.115.105]:6306 "HELO
	pyxis.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20024029AbZDMKtE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Apr 2009 11:49:04 +0100
Received: (qmail 26201 invoked by uid 104); 13 Apr 2009 10:48:47 -0000
Received: from 203.83.114.122 by pyxis (envelope-from <robert.zhangle@gmail.com>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.168977 secs); 13 Apr 2009 10:48:47 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 13 Apr 2009 10:48:43 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n3DAmY6j021130;
	Mon, 13 Apr 2009 18:48:35 +0800 (CST)
Date:	Mon, 13 Apr 2009 18:48:17 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	yanhua <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 10/14] lemote: rtc driver binary mode support
Message-ID: <20090413104816.GA6137@adriano.hkcable.com.hk>
Mail-Followup-To: yanhua <yanh@lemote.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
References: <49DD8238.7060609@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DD8238.7060609@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 13:06 Thu 09 Apr     , yanhua wrote:
> if (is_valid_irq(rtc_irq) &&
> - (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
> + (!(rtc_control & RTC_24H) /*|| (rtc_control & (RTC_DM_BINARY))*/)) {

Why not just remove this part "/*|| (rtc_control & (RTC_DM_BINARY))*/" ?

> dev_dbg(dev, "only 24-hr BCD mode supported\n");
> retval = -ENXIO;
> goto cleanup1;

Zhang, Le
