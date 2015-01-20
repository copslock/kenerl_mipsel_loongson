Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 23:20:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50187 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011955AbbATWUaWqi-w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jan 2015 23:20:30 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t0KMKTXD019352;
        Tue, 20 Jan 2015 23:20:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t0KMKSEs019351;
        Tue, 20 Jan 2015 23:20:28 +0100
Date:   Tue, 20 Jan 2015 23:20:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub
 instruction with addiu
Message-ID: <20150120222028.GI1205@linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com>
 <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org>
 <54BE3BFD.5070108@imgtec.com>
 <54BE8DC7.4030009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BE8DC7.4030009@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45376
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

On Tue, Jan 20, 2015 at 09:17:59AM -0800, David Daney wrote:

> >>>sub $reg, imm is not a real MIPS instruction. The assembler replaces
> >>>that with 'addi $reg, -imm'. However, addi has been removed from R6,
> >>>so we replace the 'sub' instruction with 'addiu' instead.
> >>>
> >>>Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >>>---
> >>>  arch/mips/include/asm/spinlock.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>>diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
> >>>index c6d06d383ef9..500050d3bda6 100644
> >>>--- a/arch/mips/include/asm/spinlock.h
> >>>+++ b/arch/mips/include/asm/spinlock.h
> >>>@@ -276,7 +276,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
> >>>  		do {
> >>>  			__asm__ __volatile__(
> >>>  			"1:	ll	%1, %2	# arch_read_unlock	\n"
> >>>-			"	sub	%1, 1				\n"
> >>>+			"	addiu	%1, -1				\n"
> >>>  			"	sc	%1, %0				\n"
> >>>  			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
> >>>  			: GCC_OFF12_ASM() (rw->lock)
> >>
> >>  This integer overflow trap is deliberate here -- have you seen the note
> >>just above:
> >>
> >>/* Note the use of sub, not subu which will make the kernel die with an
> >>    overflow exception if we ever try to unlock an rwlock that is already
> >>    unlocked or is being held by a writer.  */
> >>
> 
> According to a comment on another thread from Ralf, this has been observed
> in the wild only once.  We can simplify the code and remove that comment.
> Why not just use the ADDIU and be done with it?
> 
> There are many locking and atomic primitives that don't have any such error
> checking.  What makes the read lock so special that it needs this extra
> protection?

Because I was desparate to find a use for the signed add ;-)

Honestly, it's nice to have such a safeguard if it's available at no
runtime overhead at all but these days are such nice lock debugging tools
that the loss won't be missed.  So (cut'n'paste):

Why not just use the ADDIU and be done with it?

  Ralf
