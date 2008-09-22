Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2008 16:01:04 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:20786 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20135880AbYIVPBC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2008 16:01:02 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B8E843ED0; Mon, 22 Sep 2008 08:00:56 -0700 (PDT)
Message-ID: <48D7B365.6070305@ru.mvista.com>
Date:	Mon, 22 Sep 2008 19:01:57 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
References: <20080918.001358.08318211.anemo@mba.ocn.ne.jp>	<48D51B48.2090400@ru.mvista.com> <20080922.235608.106262139.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080922.235608.106262139.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>Add a helper routine to register tx4939ide driver and use it on
>>>RBTX4939 board.

>>  BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?

> Yes, next plan.  It should be much simpler than the tx4939ide driver.

    I suspect {ide|pata}_platform could be able to cover it... though I got 
muddled in the timing diagrams for the TX4938 external bus...

> ---
> Atsushi Nemoto

WBR, Sergei
