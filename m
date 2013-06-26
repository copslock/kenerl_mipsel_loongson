Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 16:31:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48328 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823098Ab3FZObSQWi7Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 16:31:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QEVG8a008283;
        Wed, 26 Jun 2013 16:31:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QEVGt6008282;
        Wed, 26 Jun 2013 16:31:16 +0200
Date:   Wed, 26 Jun 2013 16:31:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add missing cpu_has_mips_1 guardian
Message-ID: <20130626143115.GA7171@linux-mips.org>
References: <20130621110301.GA23195@hades.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130621110301.GA23195@hades.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jun 21, 2013 at 07:03:01PM +0800, Tony Wu wrote:

>  arch/mips/include/asm/cpu-features.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index e5ec8fc..df5e523 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -136,7 +136,9 @@
>  #endif
>  #endif
>  
> +#ifndef cpu_has_mips_1
>  # define cpu_has_mips_1		(cpu_data[0].isa_level & MIPS_CPU_ISA_I)
> +#endif

cpu_has_mips_1 will always evaluate as MIPS I because later ISA revisions
always contain MIPS I as a subset.  So maybe we should rather remove
cpu_has_mips_1 and MIPS_CPU_ISA_I entirely.  The sole user of cpu_has_mips_1,
proc.c could easily be cleaned up, the sole test for MIPS_CPU_ISA_I in
traps.c is slightly more work to clean up because it really is a test for
the cp0 architecture.

  Ralf
