Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2018 21:08:52 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:59144 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeBZUInt90Ys (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Feb 2018 21:08:43 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 26 Feb 2018 20:08:35 +0000
Received: from [10.20.78.94] (10.20.78.94) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Mon, 26 Feb 2018 12:05:31 -0800
Date:   Mon, 26 Feb 2018 20:05:20 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] MIPS: Introduce isa-rev.h to define MIPS_ISA_REV
In-Reply-To: <1519664565-10955-2-git-send-email-matt.redfearn@mips.com>
Message-ID: <alpine.DEB.2.00.1802261957350.3553@tp.orcam.me.uk>
References: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com> <1519664565-10955-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1519675714-321458-3393-5778-9
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190449
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
X-archive-position: 62720
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

On Mon, 26 Feb 2018, Matt Redfearn wrote:

> +/* If the compiler has defined __mips_isa_rev, believe it. */
> +#ifdef __mips_isa_rev
> +#define MIPS_ISA_REV __mips_isa_rev
> +#else
> +/* The compiler hasn't defined the isa rev so assume it's MIPS I - V (0) */
> +#define MIPS_ISA_REV 0
> +#endif

 FYI, GCC has this:

/* The ISA revision level.  This is 0 for MIPS I to V and N for
   MIPS{32,64}rN.  */
int mips_isa_rev;

and this:

      if (mips_isa < 32)
	mips_isa_rev = 0;
      else
	mips_isa_rev = (mips_isa & 31) + 1;

and then:

      if (mips_isa_rev > 0)						\
	builtin_define_with_int_value ("__mips_isa_rev",		\
				       mips_isa_rev);			\

so your proposal looks like the right approach to me.  I think we should 
have the various target macros documented in the GCC manual.

Reviewed-by: Maciej W. Rozycki <macro@mips.com>

  Maciej
