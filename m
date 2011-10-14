Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2011 19:28:48 +0200 (CEST)
Received: from ams-iport-3.cisco.com ([144.254.224.146]:48759 "EHLO
        ams-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491102Ab1JNR2i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2011 19:28:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=manesoni@cisco.com; l=2602; q=dns/txt;
  s=iport; t=1318613318; x=1319822918;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=SsVo/wNCYiiAEZNZ+I+6NS7fn1aLzYkcNgQqQsnAMTU=;
  b=ATCxbf3PpFeldhQd/8D9FCCxJ/lYQjqNx+sh1xQOypvi+sq9QDrHXW+K
   cOWDl/sXKTyfqb0AuNcOELU2N6USqhqdLrWLgyoAvtr8n1VKJX7YSQdhS
   FUOG5YvcY/dyQ4d55nmKEZi8r+A/CzuK8UlLFmt+wNoaWOBkcIjrgeW3v
   U=;
X-IronPort-AV: E=Sophos;i="4.69,347,1315180800"; 
   d="scan'208";a="1047933"
Received: from ams-core-4.cisco.com ([144.254.72.77])
  by ams-iport-3.cisco.com with ESMTP; 14 Oct 2011 17:28:32 +0000
Received: from manesoni-ws.cisco.com ([10.65.83.37])
        by ams-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p9EHSVTs002371;
        Fri, 14 Oct 2011 17:28:32 GMT
Received: by manesoni-ws.cisco.com (Postfix, from userid 1001)
        id 780AD81CA3; Fri, 14 Oct 2011 22:58:31 +0530 (IST)
Date:   Fri, 14 Oct 2011 22:58:31 +0530
From:   Maneesh Soni <manesoni@cisco.com>
To:     David Daney <david.daney@cavium.com>
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, ananth@in.ibm.com, kamensky@cisco.com
Subject: Re: [PATCH] MIPS Kprobes: Support branch instructions probing
Message-ID: <20111014172831.GA8521@cisco.com>
Reply-To: manesoni@cisco.com
References: <20111013090749.GB16761@cisco.com>
 <4E971FD3.2020308@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E971FD3.2020308@cavium.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manesoni@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10582

On Thu, Oct 13, 2011 at 10:28:51AM -0700, David Daney wrote:
> On 10/13/2011 02:07 AM, Maneesh Soni wrote:
> >
> >From: Maneesh Soni<manesoni@cisco.com>
> >
> >This patch provides support for kprobes on branch instructions. The branch
> >instruction at the probed address is actually emulated and not executed
> >out-of-line like other normal instructions. Instead the delay-slot instruction
> >is copied and single stepped out of line.
> >
> >At the time of probe hit, the original branch instruction is evaluated
> >and the target cp0_epc is computed similar to compute_retrun_epc(). It
> >is also checked if the delay slot instruction can be skipped, which is
> >true if there is a NOP in delay slot or branch is taken in case of
> >branch likely instructions. Once the delay slot instruction is single
> >stepped the normal execution resume with the cp0_epc updated the earlier
> >computed cp0_epc as per the branch instructions.
> >
> 
> I haven't tested it but...
> 
> 
> >Signed-off-by: Maneesh Soni<manesoni@cisco.com>
> >---
> >  arch/mips/include/asm/kprobes.h |    7 +
> >  arch/mips/kernel/kprobes.c      |  341 +++++++++++++++++++++++++++++++++++----
> >  2 files changed, 320 insertions(+), 28 deletions(-)
> >
> [...]
> >+static int evaluate_branch_instruction(struct kprobe *p, struct pt_regs *regs,
> >+					struct kprobe_ctlblk *kcb)
> >  {
> >+	union mips_instruction insn = p->opcode;
> >+	unsigned int dspcontrol;
> >+	long epc;
> >+
> >+	epc = regs->cp0_epc;
> >+	if (epc&  3)
> >+		goto unaligned;
> >+
> >+	if (p->ainsn.insn->word == 0)
> >+		kcb->flags |= SKIP_DELAYSLOT;
> >+	else
> >+		kcb->flags&= ~SKIP_DELAYSLOT;
> >+
> >+	switch (insn.i_format.opcode) {
> >+	/*
> >+	 * jr and jalr are in r_format format.
> >+	 */
> >+	case spec_op:
> [...]
> >+	case bgtzl_op:
> >+		/* rt field assumed to be zero */
> >+		if ((long)regs->regs[insn.i_format.rs]>  0) {
> >+			epc = epc + 4 + (insn.i_format.simmediate<<  2);
> >+			kcb->flags |= SKIP_DELAYSLOT;
> >+		} else
> >+			epc += 8;
> >+		regs->cp0_epc = epc;
> >+		break;
> 
> 
> 
> Where is the handling for:
> 
> 	case cop1_op:
> 
> #ifdef CONFIG_CPU_CAVIUM_OCTEON
> 	case lwc2_op: /* This is bbit0 on Octeon */
> 	case ldc2_op: /* This is bbit032 on Octeon */
> 	case swc2_op: /* This is bbit1 on Octeon */
> 	case sdc2_op: /* This is bbit132 on Octeon */
> #endif
> 
> These are all defined in insn_has_delayslot() but not here.

My bad.. will include them as well. Actually as Ralf suggested,
will keep this as common code.

Thanks
Maneesh
