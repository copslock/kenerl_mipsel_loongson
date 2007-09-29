Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2007 06:39:42 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:40656 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20023038AbXI2Fjd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2007 06:39:33 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IbV2w-0007hg-AR; Sat, 29 Sep 2007 05:39:22 +0000
Message-ID: <46FDE507.90206@pobox.com>
Date:	Sat, 29 Sep 2007 01:39:19 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	Matteo Croce <technoboy85@gmail.com>
CC:	linux-mips@linux-mips.org, Eugene Konev <ejka@imfi.kspu.ru>,
	netdev@vger.kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
	pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
	kaber@coreworks.de, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][7/7] AR7: ethernet
References: <200709201728.10866.technoboy85@gmail.com> <200709201813.48408.technoboy85@gmail.com>
In-Reply-To: <200709201813.48408.technoboy85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Overall, looks pretty clean, good job!

Comments:

1) [major issue] Don't take and release a heavy lock on every single RX 
packet.

2) remove net_device_stats from private structure, and use net_device::stats

3) rx_ring_size should not be a module param, since that should be 
supported via ethtool

4) cpmac_tx_timeout() doesn't really do anything to alleviate the condition

5) don't set dev->mem_start and dev->mem_end, those are fields that are 
going away, and that's not their intended purpose.  just store a pointer 
to the resource info.
