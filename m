Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Apr 2009 10:47:21 +0100 (BST)
Received: from apollo.i-cable.com ([203.83.115.103]:1983 "HELO
	apollo.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20022991AbZDNJrM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Apr 2009 10:47:12 +0100
Received: (qmail 26157 invoked by uid 508); 14 Apr 2009 09:47:02 -0000
Received: from 203.83.114.121 by apollo (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.138944 secs); 14 Apr 2009 09:47:02 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 14 Apr 2009 09:47:01 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n3E9l0JV019764;
	Tue, 14 Apr 2009 17:47:00 +0800 (HKT)
Date:	Tue, 14 Apr 2009 17:46:41 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	yanhua <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 1/14] lemote: Loongson2F based machines support
Message-ID: <20090414094640.GA28950@adriano.hkcable.com.hk>
Mail-Followup-To: yanhua <yanh@lemote.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
References: <49DD7E88.7040305@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DD7E88.7040305@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 12:50 Thu 09 Apr     , yanhua wrote:
...
> +static struct irqaction irq5 = {
> + .handler = timer_interrupt,
> + .flags = IRQF_DISABLED | IRQF_NOBALANCING,
> + .mask = CPU_MASK_NONE,

The mask field of irqaction has already been removed.
http://repo.or.cz/w/linux-2.6/linux-loongson.git?a=commit;h=9fb4061c577711830a173bc2b152000af788e3c6

Zhang, Le
