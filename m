Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Feb 2007 20:35:35 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:26632 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20038926AbXBCUfa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Feb 2007 20:35:30 +0000
Received: (qmail 5414 invoked from network); 3 Feb 2007 21:34:28 +0100
Received: from scarran.roarinelk.net (HELO ?192.168.0.242?) (192.168.0.242)
  by wormhole.roarinelk.net with SMTP; 3 Feb 2007 21:34:28 +0100
Message-ID: <45C4F1B1.3070407@roarinelk.homelinux.net>
Date:	Sat, 03 Feb 2007 21:33:53 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: 2.6.20-rc: au1x irqs broken
References: <20070202.161857.55145886.nemoto@toshiba-tops.co.jp>	<20070202075328.GB23737@roarinelk.homelinux.net>	<20070202095814.GA23967@roarinelk.homelinux.net> <20070204.000338.21930811.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070204.000338.21930811.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> You are to drop PB1000 support?

I won't submit this patch for inclusion, ever. It was just a test.

> .ack entries are required for handle_edge_irq.  And if you wanted to
> unregister an irq handler by set_irq_handler(irq, NULL), .ack will be
> used even for level flow handler.

Good to know, Thanks.

-- 
  ml.
