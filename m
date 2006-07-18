Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 20:36:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38819 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133522AbWGRTgp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2006 20:36:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k6IJaljR016972;
	Tue, 18 Jul 2006 15:36:47 -0400
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k6IJakwV016971;
	Tue, 18 Jul 2006 15:36:46 -0400
Date:	Tue, 18 Jul 2006 15:36:46 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems after merge to 2.6.18-rc1
Message-ID: <20060718193646.GB16822@linux-mips.org>
References: <20060713163200.GA7186@gundam.enneenne.com> <20060714.103521.25910483.nemoto@toshiba-tops.co.jp> <20060714075441.GE7186@gundam.enneenne.com> <20060718174639.GB6887@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718174639.GB6887@enneenne.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 18, 2006 at 07:46:39PM +0200, Rodolfo Giometti wrote:

> > The first strange thing is that this time the kernel messages stop
> > after "au1xxx_pm_prepare: state = 3" and not after "au_sleep: Zzz..."
> > as before the merge! Maybe something as changed in serial console
> > magement?
> 
> Yes, something as changed... here the patch to remove the problem.
> 
>    diff --git a/kernel/power/main.c b/kernel/power/main.c
>    index 6d295c7..10bf859 100644
>    --- a/kernel/power/main.c
>    +++ b/kernel/power/main.c
>    @@ -86,7 +86,9 @@ static int suspend_prepare(suspend_state
>     			goto Thaw;
>     	}
>     
>    +#ifndef CONFIG_DEBUG_KERNEL
>     	suspend_console();
>    +#endif
>     	if ((error = device_suspend(PMSG_SUSPEND))) {
>     		printk(KERN_ERR "Some devices failed to suspend\n");
>     		goto Finish;
> 
> I'd like also sending this patch to the Linux main tree, where should
> I send it? I found nothing useful in MAINTAINERS file... :-o

You missed the last entry in MAINTAINERS ;-)  Send such stuff to
linux-kernel@vger.kernel.org.

  Ralf
