Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 19:24:46 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:53864 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990416AbdLFSYjaEmiC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 19:24:39 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 06 Dec 2017 18:23:23 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Wed, 6 Dec 2017 10:23:14 -0800
Date:   Wed, 6 Dec 2017 10:24:00 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>
CC:     Miodrag Dinic <Miodrag.Dinic@mips.com>,
        James Hogan <James.Hogan@mips.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        "Ding Tianhong" <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <Matt.Redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Message-ID: <20171206182400.6va3pqdmgisbino7@pburton-laptop>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
 <20171130100957.GG5027@jhogan-linux.mipstec.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
 <alpine.DEB.2.00.1712061657520.4584@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1712061657520.4584@tp.orcam.me.uk>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1512584601-637137-17626-570118-11
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.21
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187551
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n) 
X-BESS-Outbound-Spam-Status: SCORE=0.21 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61323
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

Hi Maciej, Aleksandar,

On Wed, Dec 06, 2017 at 05:50:52PM +0000, Maciej W. Rozycki wrote:
>  What problem are you trying to solve anyway?  Is it not something that 
> can be handled with the `execstack' utility?

The commit message states that for Android "non-exec stack is required".
Is Android checking that then Aleksandar? If so, how? I presume what you
actually want here is for the kernel to lie & indicate to whatever part
of Android that performs this check that the stack is non-executable
even when it is really executable?

Is this aimed at the Android emulator? If so would it be possible to
instead implement RIXI support & make the non-exec stack actually work?

>  NB as someone has observed with programs that do not request a 
> non-executable stack we actually propagate the execute permission to all 
> data pages.  Is it not something we would want to handle differently?

It would of course be ideal to mark data/heap memory non-executable -
the question is how should we know that it's safe to do so. The approach
I took in 1a770b85c1f1 ("MIPS: non-exec stack & heap when non-exec
PT_GNU_STACK is present") was to require the PT_GNU_STACK header in
order to mark both stack & heap non-executable, for reasons outlined in
its commit message:

  - I was told at the time that no MIPS tools were yet emitting
    PT_GNU_STACK, so we wouldn't be changing the behaviour of any
    existing binaries & thus wouldn't break any.

  - It matches the behaviour of both ARM & x86.

Marking the heap non-executable by default would have advantages in that
we wouldn't need to worry about icache coherency for it in
set_pte_at()/__update_cache(), so one idea I had was that we could
possibly initially mark pages non-executable in the TLB & later enable
execution only if we take a TLBXI exception, with the assumption being
that in most cases we'll never try executing from the heap. That's not
an idea I've yet found the time to implement or measure the impact of
though.

Thanks,
    Paul
