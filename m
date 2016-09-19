Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 16:11:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60372 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991963AbcISOLSnNmrO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Sep 2016 16:11:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8JEBHtH015950;
        Mon, 19 Sep 2016 16:11:17 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8JEBHBp015949;
        Mon, 19 Sep 2016 16:11:17 +0200
Date:   Mon, 19 Sep 2016 16:11:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Avoid a BUG warning during prctl(PR_SET_FP_MODE,
 ...)
Message-ID: <20160919141117.GA14137@linux-mips.org>
References: <1472639603-26533-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472639603-26533-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55167
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

On Wed, Aug 31, 2016 at 12:33:23PM +0200, Marcin Nowakowski wrote:

> cpu_has_fpu macro uses smp_processor_id() and is currently executed
> with preemption enabled, that triggers the warning at runtime.
> 
> It is assumed throughout the kernel that if any CPU has an FPU, then all
> CPUs would have an FPU as well, so it is safe to perform the check with
> preemption enabled - change the code to use raw_ variant of the check to
> avoid the warning.

(Resending this, doesn't seem to have gone out the first time.)

That assumption is wrong.  With VSMP and previously also SMTC kernels
there used to be CPU configurations where a single core had only one FPU
which would be associated with (virtual) processor 0.

There are some older discrete MP systems where not necessarily all CPUs
and FPUs have the save revision and handling FPU errata may have require
disabling some but not all FPUs.

But in all practice, your patch is probably a good solution before
something sort out all the othe issues with mixed CPU/FPU versions.

  Ralf
