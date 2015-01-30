Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 18:55:45 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:36972 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011164AbbA3RznR10rQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 18:55:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id DA46421B8E2;
        Fri, 30 Jan 2015 19:55:37 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id ih43OaXqjrL6; Fri, 30 Jan 2015 19:55:33 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id DB2CA5BC007;
        Fri, 30 Jan 2015 19:55:32 +0200 (EET)
Date:   Fri, 30 Jan 2015 19:55:32 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: fix kernel lockup or crash after CPU
 offline/online
Message-ID: <20150130175532.GE591@fuloong-minipc.musicnaut.iki.fi>
References: <1421355719-17576-1-git-send-email-aaro.koskinen@iki.fi>
 <1421355719-17576-2-git-send-email-aaro.koskinen@iki.fi>
 <alpine.LFD.2.11.1501300347170.28301@eddie.linux-mips.org>
 <54CB5B59.5050203@imgtec.com>
 <alpine.LFD.2.11.1501301242080.28301@eddie.linux-mips.org>
 <54CB9C6D.1080506@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54CB9C6D.1080506@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

On Fri, Jan 30, 2015 at 02:59:57PM +0000, James Hogan wrote:
> On 30/01/15 12:47, Maciej W. Rozycki wrote:
> > On Fri, 30 Jan 2015, James Hogan wrote:
> > 
> >>>  Hmm, why can a call to `printk' cause a TLB miss, what's so special about 
> >>> this function?  Does it use kernel mapped addresses for any purpose such 
> >>> as `vmalloc'?
> >>
> >> It would be the fact netconsole (or whatever other console is in use) is
> >> built as a kernel module, memory for which is allocated from the vmalloc
> >> area.
> > 
> >  Ah, I see, thanks for enlightening me.  But in that case wouldn't it be 
> > possible to postpone console output from `printk' until it is safe to 
> > access the device?  In a manner similar to how for example we handle calls 
> > to `printk' made from the hardirq context.  That would make things less 
> > fragile.
> 
> Hmm, kernel/printk/printk.c does have:
> 
> static inline int can_use_console(unsigned int cpu)
> {
> 	return cpu_online(cpu) || have_callable_console();
> }
> 
> which should prevent it dumping printk buffer to console. CPU shouldn't
> be marked online that early, which suggests that the console has the
> CON_ANYTIME flag set, which it probably shouldn't if it depends on
> module code. call_console_drivers() seems to ensure the CPU is online or
> has CON_ANYTIME before calling the console write callback.
> 
> A quick glance and I can't see any evidence of netconsole being able to
> get CON_ANYTIME.

It does not set the flag. But flags are kept in module's static data,
so the original problem stays.

A.
