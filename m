Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2003 20:06:00 +0100 (BST)
Received: from 66-122-194-201.ded.pacbell.net ([IPv6:::ffff:66.122.194.201]:12929
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225219AbTE2TF5>; Thu, 29 May 2003 20:05:57 +0100
Received: from localhost.localdomain (greglaptop [127.0.0.1])
	by localhost.localdomain (8.12.8/8.12.5) with ESMTP id h4TJ618E001573
	for <linux-mips@linux-mips.org>; Thu, 29 May 2003 12:06:01 -0700
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.8/8.12.8/Submit) id h4TJ614b001571
	for linux-mips@linux-mips.org; Thu, 29 May 2003 12:06:01 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 29 May 2003 12:06:01 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Re: Hi, this is my patch for broadcom sb1250-mac.c
Message-ID: <20030529190601.GA1488@greglaptop.internal.keyresearch.com>
Mail-Followup-To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <200305300246578.SM00840@RavProxy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305300246578.SM00840@RavProxy>
User-Agent: Mutt/1.4.1i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Fri, May 30, 2003 at 02:43:35AM +0800, Zhang Haitao wrote:

> and dear Greg Lindahl:
> you just pointed out the function skb_over_panic(), but there are
> many reasons will lead that fault!

It is not an obvious bug, but this is an important clue. If you then
look at skb_put (in include/linux/skbuff.h) you will find that you
have written beyond the end of a skbuf, or a stray pointer has damaged
the size of the skbuf. I would next put some debugging code before
every skb_put() call (there are only 2 in sbmac.c) to see if it will
overflow, and printk something if it is.

Any kernel bug that you can make happen repeatedly can be debugged in
this fashion.

-- greg
