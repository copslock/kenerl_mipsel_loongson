Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 18:36:10 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27014166AbbDGQgIGuGL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 18:36:08 +0200
Date:   Tue, 7 Apr 2015 17:36:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     James Cowgill <James.Cowgill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: asm: elf: Set O32 default FPU flags
In-Reply-To: <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1504071617580.21028@eddie.linux-mips.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org> <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46809
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

Ralf,

On Thu, 26 Feb 2015, Markos Chandras wrote:

> Set good default FPU flags (FR0) for O32 binaries similar to what the
> kernel does for the N64/N32 ones. This also fixes a regression
> introduced in commit 46490b572544 ("MIPS: kernel: elf: Improve the
> overall ABI and FPU mode checks") when MIPS_O32_FP64_SUPPORT is
> disabled. In that case, the mips_set_personality_fp() did not set the
> FPU mode at all because it assumed that the FPU mode was already set
> properly. That led to O32 userland problems.
> 
> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Reported-by: Mans Rullgard <mans@mansr.com>
> Fixes: 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU mode checks")
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---

 Can you please backport this change to 4.0 ASAP, preferably before it 
hits the actual release?

 It fixes a 3.19->4.0 regression, likely affecting all FPU processors and 
wreaking havoc.  For example I came across a system that boots 3.19 just 
fine, but hangs in `ypbind' with 4.0.  It works again with this change 
applied.

 This is commit 5f067f5c in upstream-sfr.

 Thanks!

  Maciej
