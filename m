Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 21:32:56 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:52970 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028748AbcEJTcu2xjZg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 21:32:50 +0200
Received: from [2001:bc8:30d7:120:daeb:97ff:feb6:3f19] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <aurelien@aurel32.net>)
        id 1b0DOh-0003pS-3L; Tue, 10 May 2016 21:32:47 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.87)
        (envelope-from <aurelien@aurel32.net>)
        id 1b0DOg-0002T1-M1; Tue, 10 May 2016 21:32:46 +0200
Date:   Tue, 10 May 2016 21:32:46 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        "stable # v4 . 0+" <stable@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: Disable preemption during
 prctl(PR_SET_FP_MODE, ...)
Message-ID: <20160510193246.GB7635@aurel32.net>
Mail-Followup-To: Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        "stable # v4 . 0+" <stable@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
References: <1461239038-19991-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461239038-19991-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53351
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

On 2016-04-21 12:43, Paul Burton wrote:
> Whilst a PR_SET_FP_MODE prctl is performed there are decisions made
> based upon whether the task is executing on the current CPU. This may
> change if we're preempted, so disable preemption to avoid such changes
> for the lifetime of the mode switch.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
> Cc: stable <stable@vger.kernel.org> # v4.0+
> ---
> 
>  arch/mips/kernel/process.c | 4 ++++
>  1 file changed, 4 insertions(+)

Both patches fixes building pillow, which otherwise hangs running
"python setup.py build" [1]. The setup code uses the multiprocessing
package, and it hangs in a call to PR_SET_FP_MODE.

You can therefore add for both patches:

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Thanks,
Aurelien

[1] https://buildd.debian.org/status/fetch.php?pkg=pillow&arch=mips&ver=3.2.0-1&stamp=1460852908

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
