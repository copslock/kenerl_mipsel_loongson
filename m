Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2006 14:05:55 +0100 (BST)
Received: from smtp.osdl.org ([65.172.181.4]:15330 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8133889AbWGUNFq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2006 14:05:46 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6LD5anW032361
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Jul 2006 06:05:37 -0700
Received: from sony (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k6LD5aKB000454;
	Fri, 21 Jul 2006 06:05:36 -0700
Date:	Fri, 21 Jul 2006 06:05:13 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] no console disabling during suspend stage
Message-Id: <20060721060513.fd78b793.akpm@osdl.org>
In-Reply-To: <20060719091559.GD25330@enneenne.com>
References: <20060719091559.GD25330@enneenne.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Jul 2006 11:16:00 +0200
Rodolfo Giometti <giometti@linux.it> wrote:

> here a little patch to avoid disabling console during suspend stage
> while we are debugging kernel.
> 
> ...
>
> --- kernel/power/main.c	2006-07-19 10:54:11.000000000 +0200
> +++ kernel/power/main.c.new	2006-07-18 19:38:41.000000000 +0200
> @@ -86,7 +86,9 @@
>  			goto Thaw;
>  	}
>  
> +#ifndef CONFIG_DEBUG_KERNEL
>  	suspend_console();
> +#endif

CONFIG_DEBUG_KERNEL is not really the appropriate thing to use here - it's
more a user-interface/Kconfig level thing.

Can you please describe the problems which suspend_console() are causing?

Some runtime knob might be more appropriate.  Perhaps /sys/power/debug?

If the suspend_console() call is to be disabled then you'll want to disable
the matching resume_console() call too.

printk.c needs sem2mutex conversion.

The console_suspended/secondary_console_sem handling is racy.  Bad Linus. 
But as we're running on a single CPU and all other tasks are frozen it
doesn't matter.
