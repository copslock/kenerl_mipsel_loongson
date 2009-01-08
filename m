Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 20:50:51 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:729 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365020AbZAHUut (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 20:50:49 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496666fb0001>; Thu, 08 Jan 2009 15:50:03 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 12:49:18 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 12:49:18 -0800
Message-ID: <496666CE.3050205@caviumnetworks.com>
Date:	Thu, 08 Jan 2009 12:49:18 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Linus Torvalds <torvalds@linux-foundation.org>
CC:	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] cpumask fallout: Initialize irq_default_affinity earlier.
References: <1231446081-8448-1-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.2.00.0901081227360.3283@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0901081227360.3283@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2009 20:49:18.0545 (UTC) FILETIME=[9351C410:01C971D2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Linus Torvalds wrote:
[...]
> In fact, I think it already is a no-op in the UP case, and you can 
> literally just do
> 
> 	static inline void __init init_irq_default_affinity(void)
> 	{
> 	 	alloc_cpumask_var(&irq_default_affinity, GFP_KERNEL);
> 	 	cpumask_setall(irq_default_affinity);
> 	}
> 
> and be done with it. I think it should all compile away to nothing if 
> CONFIG_SMP isn't set.

The 'inline' seems gratuitous to me.  Since it is static GCC should do 
the Right Thing.  However since you suggested it, I am testing it that way.

David Daney
