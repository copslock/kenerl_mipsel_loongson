Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 19:28:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31681 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030396AbXI1S2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 19:28:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8SISCu3010299;
	Fri, 28 Sep 2007 19:28:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8SISCpf010298;
	Fri, 28 Sep 2007 19:28:12 +0100
Date:	Fri, 28 Sep 2007 19:28:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kyle McMartin <kyle@mcmartin.ca>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix fallocate on mips64 o32 ABI
Message-ID: <20070928182812.GC5933@linux-mips.org>
References: <20070928171520.GE22182@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070928171520.GE22182@fattire.cabal.ca>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 28, 2007 at 01:15:20PM -0400, Kyle McMartin wrote:

> mips was mistakenly forgetting to use the fallocate compat wrapper, which I
> noticed while cleaning up all the duplicate fallocate wrappers.
> 
> Signed-off-by: Kyle McMartin <kyle@mcmartin.ca>
> ---
>  arch/mips/kernel/scall64-o32.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index b3ed731..dd68afc 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -525,5 +525,5 @@ sys_call_table:
>  	PTR	compat_sys_signalfd
>  	PTR	compat_sys_timerfd
>  	PTR	sys_eventfd
> -	PTR	sys_fallocate			/* 4320 */
> +	PTR	sys32_fallocate			/* 4320 */
>  	.size	sys_call_table,.-sys_call_table

Thanks, applied.

  Ralf
