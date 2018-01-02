Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 19:37:13 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:40168 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeABShF3ZWe0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 19:37:05 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 02 Jan 2018 18:35:42 +0000
Received: from [10.20.78.169] (10.20.78.169) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 2 Jan 2018
 10:35:20 -0800
Date:   Tue, 2 Jan 2018 18:35:08 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Miodrag Dinic <Miodrag.Dinic@mips.com>
CC:     Paul Burton <Paul.Burton@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        James Hogan <James.Hogan@mips.com>,
        "David Daney" <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
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
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tom Saeger" <tom.saeger@oracle.com>
Subject: RE: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A8E6B2@MIPSMAIL01.mipstec.com>
Message-ID: <alpine.DEB.2.00.1801021830110.31257@tp.orcam.me.uk>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com> <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com> <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com> <20171130100957.GG5027@jhogan-linux.mipstec.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com> <alpine.DEB.2.00.1712061657520.4584@tp.orcam.me.uk>,<20171206182400.6va3pqdmgisbino7@pburton-laptop> <48924BBB91ABDE4D9335632A6B179DD6A8E6B2@MIPSMAIL01.mipstec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1514918139-321459-14509-231746-8
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.21
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188580
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
X-archive-position: 61862
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

> > I presume what you
> > actually want here is for the kernel to lie & indicate to whatever part
> > of Android that performs this check that the stack is non-executable
> > even when it is really executable?
> 
> Basically yes, because we do not have other options at this point.

 Please make the purpose of this option unambiguous in documentation then, 
along with suitable precautionary notes about any adverse consequences of 
its use.

  Maciej
