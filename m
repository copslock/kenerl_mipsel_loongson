Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 11:19:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45750 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6862035Ab3JBJTMzqvr5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Oct 2013 11:19:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r929JAl6024127;
        Wed, 2 Oct 2013 11:19:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r929J9HA024126;
        Wed, 2 Oct 2013 11:19:09 +0200
Date:   Wed, 2 Oct 2013 11:19:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: fix forced successful syscalls
Message-ID: <20131002091909.GA23236@linux-mips.org>
References: <1380550969-9522-1-git-send-email-tanguy.bouzeloc@efixo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380550969-9522-1-git-send-email-tanguy.bouzeloc@efixo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38089
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

On Mon, Sep 30, 2013 at 04:22:49PM +0200, Tanguy Bouzeloc wrote:
> Date:   Mon, 30 Sep 2013 16:22:49 +0200
> From: Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org, Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
> Subject: [PATCH] MIPS: fix forced successful syscalls
> 
> On mips any syscalls who return a value between -MAXERRNO (1133) and
> -1, is considered as an error (the error flag is set and return value
> is the positive value of the error number).
> 
> But some syscalls can return values between -MAXERRNO and -1 like
> sys_time and sys_times. In this case the userspace return value is
> -return value of the syscall and the error flag set.
> 
> This patch add a TIF_NOERROR thread flag which indicates that the
> return value of a syscall is always correct.

To my personal embarassment I have to admit that I knew about this since the
day the syscall wrapper was written - but was considering it an acceptable
bug ...

Where it really bits is sigreturn and similar which use the following
stunt:

        /*
         * Don't let your children do this ...
         */
        __asm__ __volatile__(
                "move\t$29, %0\n\t"
                "j\tsyscall_exit"
                :/* no outputs */
                :"r" (&regs));
        /* Unreached */

to keep the syscall return path from tampering with the return value.

The scall*.S part of your patch is clearing TIF_NOERROR using a non-atomic
LW/SW sequence.  This needs to be done atomically or the thread's flags
variable might get corrupted.  This is complicated by MIPS I, R5900 and
afair some older oddball not-quite MIPS II CPUs lacking LL/SC rsp. LLD/SCD.

  Ralf
