Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 16:17:45 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:53846 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990482AbdK2PRiXFff- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 16:17:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 29 Nov 2017 15:17:25 +0000
Received: from [10.20.78.197] (10.20.78.197) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 29 Nov 2017
 07:17:21 -0800
Date:   Wed, 29 Nov 2017 15:17:08 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 0/5] MIPS: NT_PRFPREG regset handling fixes
Message-ID: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1511968633-637138-2170-105609-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187424
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61185
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

Hi,

 This series corrects a number of issues with NT_PRFPREG regset, most 
importantly an FCSR access API regression introduced with the addition of 
MSA support, and then a few smaller issues with the get/set handlers.

 I have decided to factor out non-MSA and MSA context helpers as the first 
step to avoid the issue with excessive indentation that would inevitably 
happen if the regression fix was applied to current code as it stands.  
It shouldn't be a big deal with backporting as this code hasn't changed 
much since the regression, and it will make any future bacports easier.  
Only a call to `init_fp_ctx' will have to be trivially resolved (though 
arguably commit ac9ad83bc318 ("MIPS: prevent FP context set via ptrace 
being discarded"), which has added `init_fp_ctx', would be good to 
backport as far as possible instead).

 These changes have been verified by examining the register state recorded 
in core dumps manually with GDB, as well as by running the GDB test suite.  
No user of ptrace(2) PTRACE_GETREGSET and PTRACE_SETREGSET requests is 
known for the MIPS port, so this part remains not covered, however it is 
assumed to remain consistent with how the creation of core file works.

 See individual patch descriptions for further details.

  Maciej
