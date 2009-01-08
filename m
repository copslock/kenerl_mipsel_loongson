Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 20:34:19 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58752 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S21365020AbZAHUeP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 20:34:15 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08KXcKk029966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2009 12:33:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08KXcbH012826;
	Thu, 8 Jan 2009 12:33:38 -0800
Date:	Thu, 8 Jan 2009 12:33:38 -0800 (PST)
From:	Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@localhost.localdomain
To:	David Daney <ddaney@caviumnetworks.com>
cc:	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] cpumask fallout: Initialize irq_default_affinity
 earlier.
In-Reply-To: <1231446081-8448-1-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.0901081227360.3283@localhost.localdomain>
References: <1231446081-8448-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Thu, 8 Jan 2009, David Daney wrote:
>  
> +#ifdef CONFIG_SMP
> +	init_irq_default_affinity();
> +#endif

Don't do this. It's horrible. It makes the code much harder to read.

What's so wrong with initializing affinity on UP? It's still conceptually 
a fine thing to do, although it's obviously trivially a no-op.

Also, since it's only used in "handle.c", why not just move it there? 
Then, just make it static, and make it a no-op for the non-SMP case. Ok?

In fact, I think it already is a no-op in the UP case, and you can 
literally just do

	static inline void __init init_irq_default_affinity(void)
	{
	 	alloc_cpumask_var(&irq_default_affinity, GFP_KERNEL);
	 	cpumask_setall(irq_default_affinity);
	}

and be done with it. I think it should all compile away to nothing if 
CONFIG_SMP isn't set.

			Linus
