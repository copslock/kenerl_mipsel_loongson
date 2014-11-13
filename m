Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 11:31:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50505 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013592AbaKMKbJmMN46 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 11:31:09 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sADAV8dl017851;
        Thu, 13 Nov 2014 11:31:08 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sADAV8WB017850;
        Thu, 13 Nov 2014 11:31:08 +0100
Date:   Thu, 13 Nov 2014 11:31:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 05/11] MIPS: mm: c-r4k: Ensure CCA is set to non-coherent
 on UP kernels.
Message-ID: <20141113103108.GB13753@linux-mips.org>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
 <1415858743-24492-6-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415858743-24492-6-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44109
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

On Thu, Nov 13, 2014 at 12:05:37AM -0600, Steven J. Hill wrote:

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 1559360..076e660 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1595,8 +1595,17 @@ early_param("cca", cca_setup);
>  
>  static void coherency_setup(void)
>  {
> -	if (cca < 0 || cca > 7)
> -		cca = read_c0_config() & CONF_CM_CMASK;
> +	if (cca < 0 || cca > 7) {
> +		/*
> +		 * Set CCA to non-coherent to ensure that the UP kernel
> +		 * behaves properly even on MC processors where the ROM
> +		 * may have prepared the C0 registers for SMP operation.
> +		 */
> +		if (!config_enabled(CONFIG_SMP))
> +			cca = _CACHE_CACHABLE_NONCOHERENT >> _CACHE_SHIFT;
> +		else
> +			cca = read_c0_config() & CONF_CM_CMASK;
> +	}

NAK.  This would trigger falsely on pretty much every SMP platform in
MIPS history except Octeon - with usually fatal consequences.

Is there a performance disadvantage or why is this desirable?

  Ralf
