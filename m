Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 14:57:44 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57874 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491077Ab1AXN5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 14:57:41 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0ODvD97031420;
        Mon, 24 Jan 2011 14:57:14 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0ODvDbT031418;
        Mon, 24 Jan 2011 14:57:13 +0100
Date:   Mon, 24 Jan 2011 14:57:13 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] tracing, MIPS: Substitute in_kernel_space() for
 in_module()
Message-ID: <20110124135713.GA31240@linux-mips.org>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
 <bce694a8e18c01fa0d2cc667561870b56a7d672f.1295464855.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce694a8e18c01fa0d2cc667561870b56a7d672f.1295464855.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 20, 2011 at 03:28:29AM +0800, Wu Zhangjin wrote:

> @@ -91,10 +91,16 @@ int ftrace_make_nop(struct module *mod,
>  	unsigned long ip = rec->ip;
>  
>  	/*
> -	 * We have compiled module with -mlong-calls, but compiled the kernel
> -	 * without it, we need to cope with them respectively.
> +	 * If ip is in kernel space, no long call, otherwise, long call is
> +	 * needed.
>  	 */

Or even better, just check if the destination is in the same 28-bit segment
of address space.  Something like:

	if ((src ^ dst) >> 28)  {
		/* out of range of simple R_MIPS_26 relocation */
	}

That way you no longer rely on a particular address layout - and there are
plans to change the address space layout eventually!

  Ralf
