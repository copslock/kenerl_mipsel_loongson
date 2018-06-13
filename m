Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 23:21:51 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:58142 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeFMVVnhmCLn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 23:21:43 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 13 Jun 2018 21:21:26 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 13
 Jun 2018 14:21:37 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Wed, 13 Jun
 2018 14:21:37 -0700
Date:   Wed, 13 Jun 2018 14:21:25 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix arch_trigger_cpumask_backtrace()
Message-ID: <20180613212125.gxbqusrjgzb257sj@pburton-laptop>
References: <1517802167-20340-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1517802167-20340-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1528924886-321459-969-20993-1
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194029
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: chenhc@lemote.com,ralf@linux-mips.org,steven.hill@cavium.com,linux-mips@linux-mips.org,zhangfx@lemote.com,wuzhangjin@gmail.com,stable@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Huacai,

On Mon, Feb 05, 2018 at 11:42:47AM +0800, Huacai Chen wrote:
> SysRq-L and RCU stall detector call arch_trigger_cpumask_backtrace() to
> trigger other CPU's backtrace, but its behavior is totally broken. The
> root cause is arch_trigger_cpumask_backtrace() use call-function IPI in
> irq context, which trigger deadlocks in smp_call_function_single() and
> smp_call_function_many().
> 
> This patch fix arch_trigger_cpumask_backtrace() by:
> 1, Use a dedecated IPI (SMP_CPU_BACKTRACE) to trigger backtraces;
> 2, If myself is in target cpumask, do backtrace and clear myself;
> 3, Use a spinlock to avoid parallel backtrace output;
> 4, Handle SMP_CPU_BACKTRACE IPI for Loongson-3.
> 
> I have attempted to implement SMP_CPU_BACKTRACE for all MIPS CPUs, but I
> failed because some of their IPIs are not extensible. :(

Interesting - I've been using a similar patch internally for a little
while which can be seen here:

  https://git.linux-mips.org/cgit/linux-mti.git/commit/?h=eng-v4.15&id=f46720d62919a0e99d2505f022efdae9a9518191

Mine uses the generic nmi_trigger_cpumask_backtrace() infrastructure to
handle most of the work, and just has to deal with sending the IPIs. It
relies upon some changes from Matt to do that for the generic platform.

If you have a chance could you test the branch below & let me know
whether it works for you?

  git://git.kernel.org/pub/scm/linux/kernel/git/paulburton/linux.git

  Branch "wip-cpumask-backtrace".

Hopefully with a little more work we can fix this up generically.

Thanks,
    Paul
