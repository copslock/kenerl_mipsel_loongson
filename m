Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADNgeX28816
	for linux-mips-outgoing; Tue, 13 Nov 2001 15:42:40 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADNgb028812
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 15:42:37 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fADNgSjR027307;
	Tue, 13 Nov 2001 15:42:28 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fADNgRcq027303;
	Tue, 13 Nov 2001 15:42:27 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 13 Nov 2001 15:42:26 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Krishna Kondaka <krishna@Sanera.net>
cc: ralf@gnu.org, linux-mips@oss.sgi.com
Subject: Re: BUG : Memory leak in Linux 2.4.2 MIPS SMP kernel
In-Reply-To: <200111132336.PAA06294@exceed1.sanera.net>
Message-ID: <Pine.LNX.4.10.10111131540360.19489-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> 1. Summary:
> 	Memory leak in Linux 2.4.2 MIPS SMP kernel

Fixed in the latest tree.

> /*
>  * Destroy context related info for an mm_struct that is about
>  * to be put to rest.
>  */
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

BTW you should check to see if mm->context really exist. It can bomb out
otherwise.

Current function is:

static inline void destroy_context(struct mm_struct *mm)
{
#ifdef CONFIG_SMP
        if (mm->context)
                kfree((void *)mm->context);
#endif
}
