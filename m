Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADNlxT28970
	for linux-mips-outgoing; Tue, 13 Nov 2001 15:47:59 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fADNlu028966
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 15:47:56 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fADNlrs10527;
	Wed, 14 Nov 2001 10:47:53 +1100
Date: Wed, 14 Nov 2001 10:47:53 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Krishna Kondaka <krishna@sanera.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: BUG : Memory leak in Linux 2.4.2 MIPS SMP kernel
Message-ID: <20011114104753.A10410@dea.linux-mips.net>
References: <200111132336.PAA06294@exceed1.sanera.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111132336.PAA06294@exceed1.sanera.net>; from krishna@sanera.net on Tue, Nov 13, 2001 at 03:36:32PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 13, 2001 at 03:36:32PM -0800, Krishna Kondaka wrote:

> extern inline void destroy_context(struct mm_struct *mm)
> {
> #ifdef CONFIG_SMP
>         kfree((void *)mm->context);
> #else
>         /* Nothing to do.  */
> #endif
> }
> 
> And when I tested this I do not see the memory leak any more.

Almost correct, as James already explained you have to check for a
non-null pointer first.  We got a more elegant implementation of
context switching which I'll add to CVS asap; it gets away without
any memory allocation.

  Ralf
