Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 12:16:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52708 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007901AbbILKQk4PKwl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 12:16:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8CAGdpD007769;
        Sat, 12 Sep 2015 12:16:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8CAGdtI007768;
        Sat, 12 Sep 2015 12:16:39 +0200
Date:   Sat, 12 Sep 2015 12:16:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] MIPS: CONFIG_MIPS_MT_SMP should depend upon
 CPU_MIPSR2
Message-ID: <20150912101638.GA7422@linux-mips.org>
References: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
 <1438814560-19821-6-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438814560-19821-6-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49162
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

On Wed, Aug 05, 2015 at 03:42:39PM -0700, Paul Burton wrote:

> The MT ASE cannot be used with CPUs that implement older releases of the
> MIPS architecture than release 2, and is replaced in release 6. Encode
> these constraints in Kconfig to ensure that MT code is only built as
> part of kernels targeting an appropriate revision of the architecture.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: <stable@vger.kernel.org> # 3.16+
> ---
> 
>  arch/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index cee5f93..ef248cf 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2114,7 +2114,7 @@ config CPU_R4K_CACHE_TLB
>  
>  config MIPS_MT_SMP
>  	bool "MIPS MT SMP support (1 TC on each available VPE)"
> -	depends on SYS_SUPPORTS_MULTITHREADING
> +	depends on SYS_SUPPORTS_MULTITHREADING && CPU_MIPSR2

Right now this line is

depends on SYS_SUPPORTS_MULTITHREADING && !CPU_MIPSR6

which I believe is correct.  The MT SMP support aka VSMP had been
carefully crafted to work on older ASEs that is all use of MIPS MT
instructions or features was carefully protected by cpu_has_mipsmt
or similar.

  Ralf
