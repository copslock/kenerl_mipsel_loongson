Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 09:59:10 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:46094 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491864Ab0CLI7G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Mar 2010 09:59:06 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1Nq0i1-0005TL-01; Fri, 12 Mar 2010 09:59:05 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 6B5BBC35BE; Fri, 12 Mar 2010 09:50:53 +0100 (CET)
Date:   Fri, 12 Mar 2010 09:50:53 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>,
        linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: tracing: Optimize the implementation
Message-ID: <20100312085053.GB6364@alpha.franken.de>
References: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Mar 12, 2010 at 02:07:37AM +0800, Wu Zhangjin wrote:
> +/*
> + * If the Instruction Pointer is in module space (0xc0000000), return ture;
> + * otherwise, it is in kernel space (0x80000000), return false.
> + */
> +#define in_module(ip) (unlikely((ip) & 0x40000000))
> +

looks broken for 64bit, but maybe this is a 32bit only feature...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
