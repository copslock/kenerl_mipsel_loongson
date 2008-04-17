Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 13:43:26 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:47022 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S28574015AbYDQMnY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 13:43:24 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3HCgcgj024156
	for <linux-mips@linux-mips.org>; Thu, 17 Apr 2008 05:42:39 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3HChJ5F032172;
	Thu, 17 Apr 2008 13:43:19 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3HChJDg032171;
	Thu, 17 Apr 2008 13:43:19 +0100
Date:	Thu, 17 Apr 2008 13:43:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Patches for 34K APRP
Message-ID: <20080417124319.GA31453@linux-mips.org>
References: <4805FFE6.5080903@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4805FFE6.5080903@mips.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 03:32:22PM +0200, Kevin D. Kissell wrote:

>  arch/mips/kernel/setup.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index f8a535a..a6a0d62 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -336,6 +336,10 @@ static void __init bootmem_init(void)
>  #endif
>  		max_low_pfn = PFN_DOWN(HIGHMEM_START);
>  	}
> +	/*
> +	 * Propagate final value of max_low_pfn to max_pfn
> +	 */
> +	max_pfn = max_low_pfn;

That will be incorrect for systems with highmem.  So I think the right
fix is to replace all references to max_pfn in vpe.c with max_low_pfn.

It still won't play nicely with esotheric configurations such as
discontig memory ...

  Ralf
