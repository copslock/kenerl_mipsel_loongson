Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 04:48:51 +0100 (BST)
Received: from sigrand.ru ([80.66.88.167]:62693 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133355AbWFGDsm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 04:48:42 +0100
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id 58F5312A0044;
	Wed,  7 Jun 2006 10:48:35 +0700 (NOVST)
Date:	Wed, 7 Jun 2006 10:48:34 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <15450.060607@sigrand.ru>
To:	ashley jones <ashley_jones_2000@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re[2]: Socket buffer allocation outside DMA-able memory
In-reply-To: <20060606123735.19115.qmail@web38412.mail.mud.yahoo.com>
References: <20060606123735.19115.qmail@web38412.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Hello ashley,

Tuesday, June 06, 2006, 7:37:35 PM, you wrote:


aj>          I guess your 25 bit dma address field will be word alligned, so ur dma engine will be able to index up to 64 MB( 25+2 = 27 bits).
Address not aligned - if I don't do anything driver work incorrect!

aj>     * dont give whole 64 MB to linux, give only Lower 32 MB.
You mean with command line kernel option? If so - I already did so to
get all work!

aj>     * Give only upper 32 MB to linux, and give memory to ur dma engine from lower 32 MB, and once you recv any data you copy to skb and submit to linux. ( ofcourse your performance will get hit
aj> in this case.)
How can I do this? I have variant that if addres is upper than 32Mb then copy skbuffer to
previously allocated memory that lower than 32Mb, but perfomance is wery Important. Maybe
you mean this??
