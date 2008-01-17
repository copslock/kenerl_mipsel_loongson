Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2008 16:50:48 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:52672 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S28583899AbYAQQuk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2008 16:50:40 +0000
Received: from [10.0.0.150] ([74.46.20.65]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 17 Jan 2008 11:50:33 -0500
Message-ID: <478F8758.1010105@raritan.com>
Date:	Thu, 17 Jan 2008 11:50:32 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <478D121C.4020701@raritan.com>	<20080115231421.GB9767@networkno.de>	<478E22A4.4070604@raritan.com> <20080117.010459.51867104.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080117.010459.51867104.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2008 16:50:33.0909 (UTC) FILETIME=[13B30650:01C85929]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Hmm.  The puts() in arch/mips/jmr3927/common/puts.c looks usable even
> on kernel entry.  You can verify if it can really be used on
> start_kernel(), then start tracking down the problem.
>
> ---
> Atsushi Nemoto
>   

puts() has helped, but I wish that I had something to dump the stack. Is 
kgdb easy to set up?

In main.c, init_IRQ() eventually uses kmalloc:
arch_init_irq() -> txx9_irq_init() -> ioremap() -> __get_vm_area_node() 
-> kmalloc_node()...
malloc_sizes is not yet initialized, though, which means that cs_cachep 
is zero for all entries. My system reboots when it reaches 
cpu_cache_get() in mm/slab.c where cachep is zero.

It seems to me that kmem_cache_init() ought to be run before any 
kmallocs. kmem_cache_init() seems to require mem_init(). After I moved 
mem_init and kmem_cache_init before init_IRQ(), it gets down to 
pidhash_init() before rebooting, which I am looking into now.


What ought to be done to fix the init_IRQ()/kmalloc problem?

Thanks
