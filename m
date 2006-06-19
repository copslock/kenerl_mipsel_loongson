Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 16:11:50 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:27044 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133545AbWFSPLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Jun 2006 16:11:41 +0100
Received: (qmail 4757 invoked from network); 19 Jun 2006 19:22:29 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 19 Jun 2006 19:22:29 -0000
Message-ID: <4496BE57.5040802@ru.mvista.com>
Date:	Mon, 19 Jun 2006 19:10:15 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Merge window ...
References: <20060619103653.GA4257@linux-mips.org> <20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:

> I think we should remove old boards support.
> Cannot build the following boards now.

    Some boards named here can hardly be considered old. :-)

> Toshiba RBTX4938
> RBHMA4500

    This is the same board. I think it's too early to remove this. MV has a 
number of patches for it BTW, only there was/is no time to push them upstream.

> Sibyte BCM91250A-SWARM

    It's really too early to remove this one. MV is working on the new kernel.

> Also the folowing boards don't have config file.

> Toshiba TBTX49[23]7

    I've pushed some patches for those resently...

> These boards are candidate for removal.
> If there are none objection, we can add to feature-removal-schedule.txt.

> Yoichi

WBR, Sergei
