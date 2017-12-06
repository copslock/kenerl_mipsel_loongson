Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 18:56:39 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:44813 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLFR4aYgXl9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 18:56:30 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 06 Dec 2017 17:54:09 +0000
Received: from [10.20.78.27] (10.20.78.27) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Wed, 6 Dec 2017 09:54:02 -0800
Date:   Wed, 6 Dec 2017 17:50:52 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Miodrag Dinic <Miodrag.Dinic@mips.com>
CC:     James Hogan <James.Hogan@mips.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Matt Redfearn" <Matt.Redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Burton <Paul.Burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: RE: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
Message-ID: <alpine.DEB.2.00.1712061657520.4584@tp.orcam.me.uk>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com> <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com> <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>,<20171130100957.GG5027@jhogan-linux.mipstec.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1512582847-321459-27965-5668-6
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.21
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187686
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.20 PR0N_SUBJECT           META: Subject has letters 
        around special characters (pr0n) 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.21 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, PR0N_SUBJECT, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Hi Miodrag,

> When kernel is detecting the type of mapping it should apply :
> 
> fs/binfmt_elf.c:
> ...
> 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
> 		current->personality |= READ_IMPLIES_EXEC;
> ...
> 
> this effectively calls mips_elf_read_implies_exec() which performs a check:
> ...
> 	if (!cpu_has_rixi) {
> 		/* The CPU doesn't support non-executable memory */
> 		return 1;
> 	}
> 
> 	return 0;
> }
> 
> This will in turn make stack & heap executable on processors without 
> RIXI, which are practically all processors with MIPS ISA R < 6.
> 
> We would like to have an option to override this and force 
> non-executable mappings for such systems.

 Of course you can't force a non-executable mapping with a system where 
all valid pages are executable, as David has already noted.  Did you mean 
the other condition, that is:

	if (exstack != EXSTACK_DISABLE_X) {
		/* The binary doesn't request a non-executable stack */
		return 1;
	}

?  In which case you do want to respect the lack of the RIXI feature, 
i.e.:

int mips_elf_read_implies_exec(void *elf_ex, int exstack)
{
	if (!cpu_has_rixi) {
		/* The CPU doesn't support non-executable memory */
		return 1;
        }

	switch (nonxstack) {
	case EXSTACK_DISABLE_X:
		return 0;
	case EXSTACK_ENABLE_X:
		return 1;
	default:
		break;
	}

	if (exstack != EXSTACK_DISABLE_X) {
		/* The binary doesn't request a non-executable stack */
		return 1;
	}

	return 0;
}

(I'd replace `break' with `return exstack != EXSTACK_DISABLE_X' and 
discard the code that follows, but that can be a separate optimisation).

 What problem are you trying to solve anyway?  Is it not something that 
can be handled with the `execstack' utility?

 NB as someone has observed with programs that do not request a 
non-executable stack we actually propagate the execute permission to all 
data pages.  Is it not something we would want to handle differently?

  Maciej
