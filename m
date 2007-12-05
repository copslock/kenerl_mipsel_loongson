Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 18:57:16 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:25869 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20031549AbXLES5I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2007 18:57:08 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A02813ECB; Wed,  5 Dec 2007 10:57:05 -0800 (PST)
Message-ID: <4756F494.8090207@ru.mvista.com>
Date:	Wed, 05 Dec 2007 21:57:24 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@fh-hagenberg.at>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Alchemy: fix interrupt routing
References: <200712051908.18780.sshtylyov@ru.mvista.com> <4756D42E.9040609@fh-hagenberg.at> <20071205182353.GC10697@linux-mips.org>
In-Reply-To: <20071205182353.GC10697@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>>Thanks a billion!
>>Finally I can boot linux-2.6.24-rc on my Au1200 again!

> And with a bit of luck Alchemy will now support tickless, too.

    It works:

Timer Stats Version: v0.2
Sample period: 8.024 s
     8,     1 swapper          __netdev_watchdog_up (dev_watchdog)
     8,     1 swapper          phy_connect (phy_timer)
     8,     1 swapper          phy_connect (phy_timer)
     7,     0 swapper          receive_chars (delayed_work_timer_fn)
     1,     1 swapper          cache_register (delayed_work_timer_fn)
     1,     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
     4,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
     2,   866 mvltd            schedule_timeout (process_timeout)
     1,     0 swapper          page_writeback_init (wb_timer_fn)
     1,     1 init             schedule_timeout (process_timeout)
41 total events, 5.109 events/sec

>   Ralf

WBR, Sergei
