Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 19:36:35 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.232]:38541 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992378AbdJRRg2aEQwI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 19:36:28 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 18 Oct 2017 17:36:18 +0000
Received: from [10.20.78.218] (10.20.78.218) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 18 Oct 2017
 10:34:34 -0700
Date:   Wed, 18 Oct 2017 18:34:49 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Matthew Fortune <matthew.fortune@mips.com>,
        <linux-mips@linux-mips.org>, Corey Minyard <cminyard@mvista.com>,
        <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: Fix exception entry when CONFIG_EVA enabled
In-Reply-To: <1507712360-20657-1-git-send-email-matt.redfearn@mips.com>
Message-ID: <alpine.DEB.2.00.1710181817140.3886@tp.orcam.me.uk>
References: <1507712360-20657-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1508348177-321458-21541-2837-1
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186093
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
X-archive-position: 60447
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

On Wed, 11 Oct 2017, Matt Redfearn wrote:

> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index 5d3563c55e0c..2161357cc68f 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -199,6 +199,10 @@
>  		sll	k0, 3		/* extract cu0 bit */
>  		.set	noreorder
>  		bltz	k0, 8f
> +		 move	k0, sp
> +		.if \docfi
> +		.cfi_register sp, k0
> +		.endif

 Using $k1 for the Status.CU0 check would let us get rid of the 
`noreorder' block, making this code less fragile at no run-time cost, 
i.e.:

		mfc0	k1, CP0_STATUS
		sll	k1, 3
		move	k0, sp
		bltz	k1, 8f

(unfortunately I can't see a way to usefully fill the coprocessor move 
delay slot automatically scheduled by GAS here between MFC0 and SLL for 
processors that require it).

  Maciej
