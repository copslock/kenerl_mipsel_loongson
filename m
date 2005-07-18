Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 13:58:10 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:45578 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8226823AbVGRM5y>; Mon, 18 Jul 2005 13:57:54 +0100
Received: from [192.168.87.101] (pool-141-154-51-3.bos.east.verizon.net [141.154.51.3])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j6ICfmmN006847;
	Mon, 18 Jul 2005 08:41:50 -0400
In-Reply-To: <1121680641l.13805l.1l@cavan>
References: <1121270402l.7656l.3l@cavan> <ecb4efd1050714171318ce81aa@mail.gmail.com> <1121415711l.5178l.3l@cavan> <200507151117.49012.bruno.randolf@4g-systems.biz> <1121680641l.13805l.1l@cavan>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b30d00c05783e8ed4fc6dcb29563e232@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>,
	Clem Taylor <clem.taylor@gmail.com>
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Au1550 ethernet throughput low
Date:	Mon, 18 Jul 2005 08:56:04 -0400
To:	jaypee@hotpop.com
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jul 18, 2005, at 5:57 AM, jaypee@hotpop.com wrote:

> Thanks Bruno but I can't find that config option to select.

It is no longer an option in 2.6.  All Au1xxx processors force
CONFIG_DMA_NONCOHERENT because some cases still
don't work correctly.

> Changing from CONFIG_DMA_NONCOHERENT to CONFIG_DMA_COHERENT  make no 
> difference,

It won't, because the Ethernet driver knows the hardware works
correctly for this peripheral and assumes coherent IO.

Any Ethernet performance differences among Au1xxx designs are
likely to be related to processor speed, the memory interface
configuration, or PHY issues (improperly configured or high
error rates).

Thanks.

	-- Dan
