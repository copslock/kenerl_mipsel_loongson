Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 18:35:55 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:27626 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022269AbXCTSfy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 18:35:54 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9B7CC3ED1; Tue, 20 Mar 2007 11:35:15 -0700 (PDT)
Message-ID: <46002989.5000609@ru.mvista.com>
Date:	Tue, 20 Mar 2007 21:35:53 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	dsaxena@plexity.net, netdev@vger.kernel.org, ralf@linux-mips.org,
	jeff@garzik.org, linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: Re: [PATCH] Netpoll support for Sibyte MAC
References: <20070319224311.GA10176@plexity.net> <20070320.102248.68134682.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070320.102248.68134682.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>NETPOLL support for Sibyte MAC

>>Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
>>Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

> If you added NETPOLL support, do not forget to ensure hard_start_xmit
> routine callable from interrupt context (or irq disabled).
> See commit bce305f4fe779f29d99d414685243f5da0803254 for example.

    You're absolutely right: this driver is very likely to blow up the caller 
when called with interrupts disabled -- it uses spin_unlock_irq() there! This 
*must* be fixed.

> ---
> Atsushi Nemoto

WBR, Sergei
