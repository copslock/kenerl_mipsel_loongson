Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 12:52:09 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:34547 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010717AbcBXLwHfnJtl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 12:52:07 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id D3DE985542;
        Wed, 24 Feb 2016 11:52:03 +0000 (UTC)
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1OBq0YZ024239;
        Wed, 24 Feb 2016 06:52:02 -0500
Message-ID: <56CD9960.4060908@redhat.com>
Date:   Wed, 24 Feb 2016 11:52:00 +0000
From:   Pedro Alves <palves@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Luis Machado <lgustavo@codesourcery.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        gdb-patches@sourceware.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org> <56B9F7E6.5010006@codesourcery.com> <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk> <56BB329F.3080606@codesourcery.com> <alpine.DEB.2.00.1602152315540.15885@tp.orcam.me.uk> <56C26D8A.9070401@redhat.com> <alpine.DEB.2.00.1602182328160.15885@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1602182328160.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <palves@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palves@redhat.com
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

Hi Maciej,

>  As to the kernel side with the observations made in this discussion I 
> think we should set the trap code for SIGTRAP signals issued with BREAK 
> instructions to TRAP_BRKPT unconditionally, regardless of the code used.  
> This won't of course affect encodings which send a different signal such 
> as SIGFPE.
> 
>  We're lacking a code suitable for (conditional) trap instructions.  I 
> think TRAP_TRAP or suchlike needs to be added.

Yeah, looks like it.

>> Hardware breakpoint hits are distinguished from software breakpoint hits,
>> because they're reported with "hwbreak", not "swbreak":
>>
>>  @item hwbreak
>>  The packet indicates the target stopped for a hardware breakpoint.
>>  The @var{r} part must be left empty.
> 
>  Umm, any requirements for this?  We have MIPS data hardware breakpoint 
> support in the Linux kernel (regrettably not for instructions, but that 
> could be added sometime), but I can't see TRAP_HWBKPT being set for them, 
> they just use generic SI_KERNEL as everything else right now.

Can userspace/ptrace still tell whether a hardware breakpoint triggered by
consulting debug registers, similarly to how it can for watchpoints,
with PTRACE_GET_WATCH_REGS, and looking at watchhi ?

(assuming this comment is correct):

/* Target to_stopped_by_watchpoint implementation.  Return 1 if
   stopped by watchpoint.  The watchhi R and W bits indicate the watch
   register triggered.  */

static int
mips_linux_stopped_by_watchpoint (struct target_ops *ops)
{


This is not reachable today, due to lack of TRAP_* in si_code, but I
think that can be fixed.


The only use for hwbreak currently is to know whether to ignore hardware
breakpoint traps gdb can't explain (gdb assumes they're a delayed event for
a hw breakpoint that has since been removed):

  /* Maybe this was a trap for a hardware breakpoint/watchpoint that
     has since been removed.  */
  if (random_signal && target_stopped_by_hw_breakpoint ())
    {
      /* A delayed hardware breakpoint event.  Ignore the trap.  */
      if (debug_infrun)
	fprintf_unfiltered (gdb_stdlog,
			    "infrun: delayed hardware breakpoint/watchpoint "
			    "trap, ignoring\n");
      random_signal = 0;
    }

So if the server claims it supports this stop reason, but then doesn't
send it for hw breakpoint trap, users will see their programs
occasionally stop for random spurious SIGTRAPs (if they use hardware
breapoints).

If the server does _not_ claim support for the swbreak/hwbreak stop
reason, then the old moribund breakpoints heuristic kicks in:

  /* Check if a moribund breakpoint explains the stop.  */
  if (!target_supports_stopped_by_sw_breakpoint ()
      || !target_supports_stopped_by_hw_breakpoint ())
    {
      for (ix = 0; VEC_iterate (bp_location_p, moribund_locations, ix, loc); ++ix)
	{
	  if (breakpoint_location_address_match (loc, aspace, bp_addr)
	      && need_moribund_for_location_type (loc))
	    {
	      bs = bpstat_alloc (loc, &bs_link);
	      /* For hits of moribund locations, we should just proceed.  */
	      bs->stop = 0;
	      bs->print = 0;
	      bs->print_it = print_it_noop;
	    }
	}
    }

Thanks,
Pedro Alves
