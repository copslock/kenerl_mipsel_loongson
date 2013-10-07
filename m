Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 17:58:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35009 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868728Ab3JGP6K1y2Kg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 17:58:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r97Fw7uF013004;
        Mon, 7 Oct 2013 17:58:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r97Fw5HG013003;
        Mon, 7 Oct 2013 17:58:05 +0200
Date:   Mon, 7 Oct 2013 17:58:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: SmartMIPS: Fix build
Message-ID: <20131007155805.GH3098@linux-mips.org>
References: <1381158642-10598-1-git-send-email-treding@nvidia.com>
 <5252D343.6090100@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5252D343.6090100@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Oct 07, 2013 at 04:29:07PM +0100, Markos Chandras wrote:

> On 10/07/13 16:10, Thierry Reding wrote:
> >All CONFIG_CPU_HAS_SMARTMIPS #ifdefs have been removed from code, but
> >the ACX register declaration in struct pt_regs is still protected by it,
> >causing builds to fail. Remove the #ifdef protection and always declare
> >the register.
> >
> >Signed-off-by: Thierry Reding <treding@nvidia.com>
> >---
> >  arch/mips/include/asm/ptrace.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> >diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> >index 7bba9da..d47bdce 100644
> >--- a/arch/mips/include/asm/ptrace.h
> >+++ b/arch/mips/include/asm/ptrace.h
> >@@ -33,9 +33,7 @@ struct pt_regs {
> >  	unsigned long cp0_status;
> >  	unsigned long hi;
> >  	unsigned long lo;
> >-#ifdef CONFIG_CPU_HAS_SMARTMIPS
> >  	unsigned long acx;
> >-#endif
> >  	unsigned long cp0_badvaddr;
> >  	unsigned long cp0_cause;
> >  	unsigned long cp0_epc;
> >
> 
> Hi Thierry,
> 
> Looks good to me. Thanks!
> 
> Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

Looking good - but I've already pulled the offending patch.  Processor
specific registers in the register frame have historically been a PITA -
in particular because much of what's requiring space there is also
requiring space in the signal frame and that's a kernel ABI.

  Ralf
