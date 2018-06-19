Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 01:28:55 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:34909 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993097AbeFSX2rhD08G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 01:28:47 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 19 Jun 2018 23:28:28 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 16:28:27 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 16:28:27 -0700
Date:   Tue, 19 Jun 2018 16:28:28 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Octeon: assign bool true/false not 1/0
Message-ID: <20180619232828.icebwaaeb5zudnr2@pburton-laptop>
References: <1529133992-15360-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1529133992-15360-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529450908-321459-12801-19000-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194207
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: hofrat@osadl.org,ralf@linux-mips.org,jhogan@kernel.org,david.daney@cavium.com,steven.hill@cavium.com,joe@perches.com,colin.king@canonical.com,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64388
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

Hi Nicholas,

On Sat, Jun 16, 2018 at 09:26:32AM +0200, Nicholas Mc Guire wrote:
> Booleans should be assigned true/false not 1/0 as comparison is not needed
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Problem located by scripts/coccinelle/misc/boolinit.cocci
>   ./arch/mips/cavium-octeon/octeon-irq.c:817:3-13:
>   WARNING: Assignment of bool to 0/1
> 
> Patch was compile tested with: cavium_octeon_defconfig
> (with a number of sparse warnings - not related to the proposed change)
> 
> Patch is against 4.17.0 (localversion-next is next-20180614)
> 
>  arch/mips/cavium-octeon/octeon-irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to mips-next for 4.19.

Paul
