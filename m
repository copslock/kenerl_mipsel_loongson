Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 11:32:07 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:46287 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822330AbaG3JcEORaTc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 11:32:04 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XCQEp-0005GV-01; Wed, 30 Jul 2014 11:31:59 +0200
Date:   Wed, 30 Jul 2014 11:31:58 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Alex Smith <alex@alex-smith.me.uk>
Cc:     linux-mips@linux-mips.org, Alex Smith <alex.smith@imgtec.com>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 06/11] MIPS: O32/32-bit: Fix bug which can cause
 incorrect system call restarts
Message-ID: <20140730093158.GA19066@hall.aurel32.net>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
 <1406122816-2424-7-git-send-email-alex@alex-smith.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1406122816-2424-7-git-send-email-alex@alex-smith.me.uk>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Wed, Jul 23, 2014 at 02:40:11PM +0100, Alex Smith wrote:
> From: Alex Smith <alex.smith@imgtec.com>
> 
> On 32-bit/O32, pt_regs has a padding area at the beginning into which the
> syscall arguments passed via the user stack are copied. 4 arguments
> totalling 16 bytes are copied to offset 16 bytes into this area, however
> the area is only 24 bytes long. This means the last 2 arguments overwrite
> pt_regs->regs[{0,1}].
> 
> If a syscall function returns an error, handle_sys stores the original
> syscall number in pt_regs->regs[0] for syscall restart. signal.c checks
> whether regs[0] is non-zero, if it is it will check whether the syscall
> return value is one of the ERESTART* codes to see if it must be
> restarted.
> 
> Should a syscall be made that results in a non-zero value being copied
> off the user stack into regs[0], and then returns a positive (non-error)
> value that matches one of the ERESTART* error codes, this can be mistaken
> for requiring a syscall restart.
> 
> While the possibility for this to occur has always existed, it is made
> much more likely to occur by commit 46e12c07b3b9 ("MIPS: O32 / 32-bit:
> Always copy 4 stack arguments."), since now every syscall will copy 4
> arguments and overwrite regs[0], rather than just those with 7 or 8
> arguments.
> 
> Since that commit, booting Debian under a 32-bit MIPS kernel almost
> always results in a hang early in boot, due to a wait4 syscall returning
> a PID that matches one of the ERESTART* codes, which then causes an
> incorrect restart of the syscall.
> 
> The problem is fixed by increasing the size of the padding area so that
> arguments copied off the stack will not overwrite pt_regs->regs[{0,1}].
> 
> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> Cc: <stable@vger.kernel.org> # v3.13+
> ---
> Changes in v2:
>  - Rebase on current upstream.
>  - Split comment change into a separate commit.
> 
> I've rebased this patch on top of current mips-for-linux-next. However,
> for it to be applied to stable it needs an additional change to the
> PT_PADSLOT* definitions in arch/mips/kernel/smtc-asm.S to account for
> the changed pt_regs offsets. This file no longer exists since SMTC has
> been dropped.
> 
> I'm not sure what the correct way to deal with this is - can an
> alternate version of the patch be submitted for stable?
> ---
>  arch/mips/include/asm/ptrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index 7e6e682..c301fa9 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -23,7 +23,7 @@
>  struct pt_regs {
>  #ifdef CONFIG_32BIT
>  	/* Pad bytes for argument save space on the stack. */
> -	unsigned long pad0[6];
> +	unsigned long pad0[8];
>  #endif
>  
>  	/* Saved main processor registers. */

This patch looks fine to me, and I confirm it fixes a problem. Without
this patch, I am not able to boot a Debian user land on a 32-bit system.
It's a regression, so I think it should be merged as soon as possible,
even if the other patches in this series are merged later.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
