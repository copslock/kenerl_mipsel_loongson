Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2003 08:21:22 +0100 (BST)
Received: from 12-234-29-238.client.attbi.com ([IPv6:::ffff:12.234.29.238]:58754
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225200AbTE2HVU>; Thu, 29 May 2003 08:21:20 +0100
Received: from localhost.localdomain (greglaptop [127.0.0.1])
	by localhost.localdomain (8.12.8/8.12.5) with ESMTP id h4T7LJ4H001615
	for <linux-mips@linux-mips.org>; Thu, 29 May 2003 00:21:19 -0700
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.8/8.12.8/Submit) id h4T7LIYQ001613
	for linux-mips@linux-mips.org; Thu, 29 May 2003 00:21:18 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 29 May 2003 00:21:18 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: Hi, this is my patch for broadcom sb1250-mac.c
Message-ID: <20030529072118.GC1496@greglaptop.greghome.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <3ED586BE.9050906@netpower.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED586BE.9050906@netpower.com.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

> May 28 14:16:04 netpower kernel: skput:over: 801dce38:2498 put:2498 
> dev:eth2kern
> el BUG at skbuff.c:92!

I think this is your clue:

eth2kernel BUG at skbuff.c:92

Go read the code -- it's a overrun for skb_put().

-- greg
