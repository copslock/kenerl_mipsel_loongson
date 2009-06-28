Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Jun 2009 20:54:12 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33412 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492908AbZF1SyF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Jun 2009 20:54:05 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5SInCF5024599;
	Sun, 28 Jun 2009 19:49:12 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5SInBdP024597;
	Sun, 28 Jun 2009 19:49:11 +0100
Date:	Sun, 28 Jun 2009 19:49:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Hookup sys_rt_tgsigqueueinfo and
	sys_perf_counter_open.
Message-ID: <20090628184910.GA23369@linux-mips.org>
References: <1246035237-7150-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246035237-7150-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 26, 2009 at 09:53:57AM -0700, David Daney wrote:

> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index 93cc672..49cf780 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -415,4 +415,6 @@ EXPORT(sysn32_call_table)
>  	PTR	sys_inotify_init1
>  	PTR	sys_preadv
>  	PTR	sys_pwritev
> +	PTR	compat_sys_rt_tgsigqueueinfo
> +	PTR	sys_perf_counter_open
>  	.size	sysn32_call_table,.-sysn32_call_table

You forgot to continue the number in the comment; I added that.

Thanks, applied!

  Ralf
