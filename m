Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2017 14:48:44 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:53173 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdKONsfaYtL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2017 14:48:35 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 15 Nov 2017 13:48:30 +0000
Received: from [10.20.78.46] (10.20.78.46) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Wed, 15 Nov 2017 05:48:20 -0800
Date:   Wed, 15 Nov 2017 13:48:06 +0000
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
In-Reply-To: <9a2d2b4b-9b6a-a7e2-78be-ff6a019d6e05@mips.com>
Message-ID: <alpine.DEB.2.00.1711151334200.3893@tp.orcam.me.uk>
References: <1507712360-20657-1-git-send-email-matt.redfearn@mips.com> <605f6a96-a843-085c-efc6-a2c0f2afd84a@mvista.com> <20171031234853.GD15260@jhogan-linux> <alpine.DEB.2.00.1711131045460.3893@tp.orcam.me.uk>
 <9a2d2b4b-9b6a-a7e2-78be-ff6a019d6e05@mips.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1510753708-298555-21235-376250-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.51
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186955
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.51 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60958
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

On Wed, 15 Nov 2017, Matt Redfearn wrote:

> I like the change you propose, however I can't coax GAS to reorder the
> instructions appropriately. With this patch on top of 4.14:
> 
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -195,14 +195,16 @@
>                 .set    push
>                 .set    noat
>                 .set    reorder
> -               mfc0    k0, CP0_STATUS
> -               sll     k0, 3           /* extract cu0 bit */
> -               .set    noreorder
> -               bltz    k0, 8f
> -                move   k0, sp
> +               mfc0    k1, CP0_STATUS
> +               sll     k1, 3           /* extract cu0 bit */
> +
> +               move    k0, sp
>                 .if \docfi
>                 .cfi_register sp, k0
>                 .endif
> +
> +               bltz    k1, 8f
> +
>  #ifdef CONFIG_EVA
>                 /*
>                  * Flush interAptiv's Return Prediction Stack (RPS) by writing
> @@ -228,7 +230,6 @@
>                 MFC0    k0, CP0_ENTRYHI
>                 MTC0    k0, CP0_ENTRYHI
>  #endif
> -               .set    reorder
>                 /* Called from user mode, new stack. */
>                 get_saved_sp docfi=\docfi tosp=1
>  8:
> 
> 
> The generated assembly is:
> 
> 80405d00 <handle_int>:
> 80405d00:       401b6000        mfc0    k1,c0_status
> 80405d04:       001bd8c0        sll     k1,k1,0x3
> 80405d08:       03a0d025        move    k0,sp
> 80405d0c:       07600007        bltz    k1,80405d2c <handle_int+0x2c>
> 80405d10:       00000000        nop
> 80405d14:       401a2000        mfc0    k0,c0_context
> 
> Apparently GAS has not been able to reorder the move into the branch delay
> slot for some reason. Any ideas?

 It could be the `.cfi_register' pseudo-op acting as a scheduling barrier.  
I think it can be moved further down, beyond the branch, because until 
clobbered later on $sp still holds the original value, so using either 
register for frame access or the value itself will yield the same result.

 Can you send me .i output from the offending source along with GCC 
options used to make .o output (use `V=1' with `make' if needed)?  I'll 
check if my hypothesis is right or find the actual cause otherwise.

  Maciej
