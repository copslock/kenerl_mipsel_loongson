Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2014 15:21:35 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:8041 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823127AbaA1OVbwEP-4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jan 2014 15:21:31 +0100
Date:   Tue, 28 Jan 2014 14:20:19 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 14/15] mips: panic if vector register partitioning is
 implemented
Message-ID: <20140128142019.GE43648@pburton-linux.le.imgtec.org>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
 <1390836194-26286-15-git-send-email-paul.burton@imgtec.com>
 <52E6A7B5.2040505@gmail.com>
 <20140127193908.GL970@pburton-linux.le.imgtec.org>
 <52E6B9D7.8030208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <52E6B9D7.8030208@gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2014_01_28_14_21_25
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Jan 27, 2014 at 11:56:07AM -0800, David Daney wrote:
> ....
> On 01/27/2014 11:39 AM, Paul Burton wrote:
> >On Mon, Jan 27, 2014 at 10:38:45AM -0800, David Daney wrote:
> >>....
> >>On 01/27/2014 07:23 AM, Paul Burton wrote:
> >>>No current systems implementing MSA include support for vector register
> >>>partitioning which makes it somewhat difficult to implement support for
> >>>it in the kernel. Thus for the moment the kernel includes no such
> >>>support. However if the kernel were to be run on a system which
> >>>implemented register partitioning then it would not function correctly,
> >>>mishandling MSA disabled exceptions. Calling panic when run on a system
> >>>with vector register partitioning implemented ensures that we're not
> >>>caught out by this later but instead reminded to implement support once
> >>>such a system is available.
> >>>
> >>>Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >>>---
> >>>  arch/mips/kernel/cpu-probe.c | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> >>>index 852e085..003ba3c 100644
> >>>--- a/arch/mips/kernel/cpu-probe.c
> >>>+++ b/arch/mips/kernel/cpu-probe.c
> >>>@@ -1193,9 +1193,13 @@ void cpu_probe(void)
> >>>  	else
> >>>  		c->srsets = 1;
> >>>
> >>>-	if (cpu_has_msa)
> >>>+	if (cpu_has_msa) {
> >>>  		c->msa_id = cpu_get_msa_id();
> >>>
> >>>+		if (c->msa_id & MSA_IR_WRPF)
> >>>+			panic("Vector register partitioning unimplemented!");
> >>
> >>You should probably use a WARN_ON() instead.  There is no reason to crash
> >>the kernel for this condition is there?
> >>
> >
> >Well mapping vector registers reuses the MSA disabled exception, so if
> >the kernel were to continue with my current code & userland were to
> >execute an MSA instruction I believe it would appear to hang. [...]
> 
> The CPU probing things are called so early that any panic() or BUG() here
> will result in absolutely no console output as this code is called before
> any console drivers are enabled.

Fair point, I'd overlooked that. v2 on its way.

Paul

> 
> So the choice is really:
> 
> panic(): No output on console and system is frozen/locked-up.
> 
> WARN(): Nice stack trace on console, theoretical lockup once userspace code
> starts executing.
> 
> You can probably guess which I think is the better option.
> 
> >
> >Thanks,
> >     Paul
> >
> >>>+	}
> >>>+
> >>>  	cpu_probe_vmbits(c);
> >>>
> >>>  #ifdef CONFIG_64BIT
> >>>
> >>
> >>
> >>To report this email as SPAM, please forward it to spam@websense.com
> >
> >
> >
> 
> 
> To report this email as SPAM, please forward it to spam@websense.com
