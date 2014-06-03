Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 15:56:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45236 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFCN4uT51H9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jun 2014 15:56:50 +0200
Date:   Tue, 3 Jun 2014 14:56:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Kconfig: microMIPS and SmartMIPS are mutually
 exclusive
In-Reply-To: <20140603122451.GS17197@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1406031335030.18344@eddie.linux-mips.org>
References: <1401785177-7904-1-git-send-email-markos.chandras@imgtec.com> <20140603093434.GQ17197@linux-mips.org> <alpine.LFD.2.11.1406031214390.18344@eddie.linux-mips.org> <20140603122451.GS17197@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40419
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

On Tue, 3 Jun 2014, Ralf Baechle wrote:

> >  Do we need this CPU_HAS_SMARTMIPS setting at all?  Can't we just 
> > save/restore this SmartMIPS ACX register on context switches where 
> > available (straightforward to detect at the run time) and have the 
> > relevant pieces of code excluded (#ifdef-ed out or suchlike) on 
> > non-supported configurations such as microMIPS or MIPS64?
> 
> SmartMIPS has new instructions which are hardcoded in various assembler
> fragments, where something like if (cpu_has_smartmips) won't work.
> So until a more complex solution is implemented CPU_HAS_SMARTMIPS is
> what there is.

 Well:

	.set	push
	.set	smartmips
	# Whatever SmartMIPS stuff.
	.set	pop

should do.  It has been supported by GAS since forever (well, since it has 
included SmartMIPS instructions that is, which is 2.18; to support older 
versions we can use $(call as-instr,...) and some #ifdef-ry that we have 
anyway).  It's <asm/stackframe.h> only BTW for six instructions total.

 So I think that is straightforward to implement and much more reasonable 
than the hacks we have now.  A SmartMIPS-enabled kernel doesn't even check 
if the CPU it's run on implements the ASE so it'll just crash at some 
point trying to execute MFLHXU or MTLHX if it does not -- and obviously if 
two SmartMIPS user programs are run concurrently on a SmartMIPS-disabled 
kernel and use the ACX register, then they will yield random results.

  Maciej
