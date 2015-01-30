Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 19:53:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54213 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011164AbbA3Sx4l5uBL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 19:53:56 +0100
Date:   Fri, 30 Jan 2015 18:53:56 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: fix kernel lockup or crash after CPU
 offline/online
In-Reply-To: <20150130182316.GA30459@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.LFD.2.11.1501301851300.28301@eddie.linux-mips.org>
References: <1421355719-17576-1-git-send-email-aaro.koskinen@iki.fi> <1421355719-17576-2-git-send-email-aaro.koskinen@iki.fi> <alpine.LFD.2.11.1501300347170.28301@eddie.linux-mips.org> <54CB5B59.5050203@imgtec.com> <alpine.LFD.2.11.1501301242080.28301@eddie.linux-mips.org>
 <54CB9C6D.1080506@imgtec.com> <20150130175532.GE591@fuloong-minipc.musicnaut.iki.fi> <20150130182316.GA30459@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 30 Jan 2015, James Hogan wrote:

> > > Hmm, kernel/printk/printk.c does have:
> > > 
> > > static inline int can_use_console(unsigned int cpu)
> > > {
> > > 	return cpu_online(cpu) || have_callable_console();
> > > }
> > > 
> > > which should prevent it dumping printk buffer to console. CPU shouldn't
> > > be marked online that early, which suggests that the console has the
> > > CON_ANYTIME flag set, which it probably shouldn't if it depends on
> > > module code. call_console_drivers() seems to ensure the CPU is online or
> > > has CON_ANYTIME before calling the console write callback.
> > > 
> > > A quick glance and I can't see any evidence of netconsole being able to
> > > get CON_ANYTIME.
> > 
> > It does not set the flag. But flags are kept in module's static data,
> > so the original problem stays.
> > 
> > A.
> 
> Ah yes, of course. This approach looks correct to me then.

 In such a case shouldn't the flags be copied out on console registration 
to a structure that is guaranteed to be accessible at all times?

  Maciej
