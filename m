Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2017 15:57:24 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:49927 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdKOO5QT-Kec (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2017 15:57:16 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 15 Nov 2017 14:57:07 +0000
Received: from [10.20.78.46] (10.20.78.46) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Wed, 15 Nov 2017 06:56:36 -0800
Date:   Wed, 15 Nov 2017 14:53:33 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
CC:     James Hogan <james.hogan@mips.com>,
        Corey Minyard <cminyard@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <matthew.fortune@mips.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        "Paul Burton" <paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Fix exception entry when CONFIG_EVA enabled
In-Reply-To: <alpine.DEB.2.00.1711151334200.3893@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1711151425100.3893@tp.orcam.me.uk>
References: <1507712360-20657-1-git-send-email-matt.redfearn@mips.com> <605f6a96-a843-085c-efc6-a2c0f2afd84a@mvista.com> <20171031234853.GD15260@jhogan-linux> <alpine.DEB.2.00.1711131045460.3893@tp.orcam.me.uk> <9a2d2b4b-9b6a-a7e2-78be-ff6a019d6e05@mips.com>
 <alpine.DEB.2.00.1711151334200.3893@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1510757827-298555-21233-380955-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186956
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60960
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

Hi Matt,

On Wed, 15 Nov 2017, Maciej W. Rozycki wrote:

>  Can you send me .i output from the offending source along with GCC 
> options used to make .o output (use `V=1' with `make' if needed)?  I'll 
> check if my hypothesis is right or find the actual cause otherwise.

 Thanks for the pieces requested.

 I can see what is going on here: the problem is the source is built with 
no optimisation enabled.  Consequently GAS does not schedule delay slots 
itself.  I wasn't aware we had this problem with kernel build flags -- it 
certainly affects more than just this piece of code.

 For GAS to schedule delay slots it has to be passed -O2 by the GCC 
driver.  The driver in turn will pass -O2 to GAS whenever at least -O has 
been used.  By default -O1 is passed, which only enables the removal of 
unnecessary NOPs, i.e. those that have been inserted precautionarily for 
execution hazard avoidance in the assembly pass and in the end turned out 
unnecessary and can be optionally removed in the relaxation pass.  NB 
GAS's default is actually -O2, i.e. when invoked directly, however this is 
overridden by the GCC driver as described.

 My recommendation would be using just the same CFLAGS for assembly 
sources that are used for C language sources; the GCC driver will silently 
filter out options that are irrelevant and interpret all the options that 
do have relevance.  This may be important for various `-f<foo>' and 
`-m<bar>' options which may sometimes affect assembly generation and, for 
that matter, multilib selection.

 This also means all CFLAGS should be passed to the linker as well, 
because again, they may affect linker options.

 So if you stick say `-O2' with your compiler invocation, for the purpose 
of this consideration possibly just like this:

$ make AFLAGS_genex.o=-O2 arch/mips/kernel/genex.o

then you should get the delay slot in question (and any other ones) 
scheduled.  Indeed with this build recipe applied I can already see a 
small code size reduction in `genex.o' even without your change:

$ size arch/mips/kernel/genex-?.o
   text	   data	    bss	    dec	    hex	filename
   8236	     48	      0	   8284	   205c	arch/mips/kernel/genex-0.o
   8204	     48	      0	   8252	   203c	arch/mips/kernel/genex-1.o
$

 HTH,

  Maciej
