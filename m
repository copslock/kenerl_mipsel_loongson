Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 22:47:14 +0100 (CET)
Received: from snt0-omc3-s42.snt0.hotmail.com ([65.54.51.79]:19941 "EHLO
        snt0-omc3-s42.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816383AbaCVVrMgE1P0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Mar 2014 22:47:12 +0100
Received: from SNT145-W98 ([65.55.90.135]) by snt0-omc3-s42.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Sat, 22 Mar 2014 14:47:06 -0700
X-TMN:  [XXg/WSBJU+CNLw4mULoiK/xH9VLgw5fY]
X-Originating-Email: [nickkrause@sympatico.ca]
Message-ID: <SNT145-W982FA6E38A0213DE61456DA5780@phx.gbl>
From:   Nick Krause <nickkrause@sympatico.ca>
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PATCH[60485 Bug adding breakpoint]
Date:   Sat, 22 Mar 2014 21:47:06 +0000
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 22 Mar 2014 21:47:06.0269 (UTC) FILETIME=[44B1B4D0:01CF4618]
Return-Path: <nickkrause@sympatico.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nickkrause@sympatico.ca
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

Here is my new patch as corrected for the the bug 60845.
https://bugzilla.kernel.org/show_bug.cgi?id=60845
This is the link to the bug and my comments / conversation on to get the corrections needed.
Below is my patch for the bug, please let me know if it gets added finally .

--- linux-3.13.6/arch/mips/pci/msi-octeon.c.orig    2014-03-22 17:32:44.762754254 -0400
+++ linux-3.13.6/arch/mips/pci/msi-octeon.c    2014-03-22 17:34:19.974753699 -0400
@@ -150,6 +150,7 @@ msi_irq_allocated:
         msg.address_lo =
             ((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
         msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV)>> 32;
+        break;
     case OCTEON_DMA_BAR_TYPE_BIG:
         /* When using big bar, Bar 0 is based at 0 */
         msg.address_lo = (0 + CVMX_PCI_MSI_RCV) & 0xffffffff;
Signed-off-by: nickkrause@sympatico.ca
Nick
 		 	   		  
From macro@linux-mips.org Sat Mar 22 23:21:05 2014
Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 23:21:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50931 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816015AbaCVWVFDKnWt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Mar 2014 23:21:05 +0100
Date:   Sat, 22 Mar 2014 22:21:04 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add 1074K CPU support explicitly.
In-Reply-To: <1389992630-64139-1-git-send-email-Steven.Hill@imgtec.com>
Message-ID: <alpine.LFD.2.10.1403222210230.21669@eddie.linux-mips.org>
References: <1389992630-64139-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Alpine 2.10 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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
Content-Length: 1451
Lines: 49

On Fri, 17 Jan 2014, Steven J. Hill wrote:

> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
> 
> The 1074K is a multiprocessing coherent processing system (CPS) based
> on modified 74K cores. This patch makes the 1074K an actual unique
> CPU type, instead of a 74K derivative, which it is not.
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
[...]
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 13b549a..7184363 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1106,9 +1106,10 @@ static void probe_pcache(void)
>  	case CPU_34K:
>  	case CPU_74K:
>  	case CPU_1004K:
> +	case CPU_1074K:
>  	case CPU_INTERAPTIV:
>  	case CPU_PROAPTIV:
> -		if (current_cpu_type() == CPU_74K)
> +		if ((c->cputype == CPU_74K) || (c->cputype == CPU_1074K))
>  			alias_74k_erratum(c);
>  		if ((read_c0_config7() & (1 << 16))) {
>  			/* effectively physically indexed dcache,

 Hmm, wouldn't it make sense to avoid the repeated condition check and 
make it:

	case CPU_74K:
	case CPU_1074K:
		alias_74k_erratum(c);
		/* Fall through. */
	case CPU_M14KC:
	case CPU_M14KEC:
	case CPU_24K:
	case CPU_34K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
	
or suchlike instead?  Also why `c->cputype == CPU_74K' rather than 
`current_cpu_type() == CPU_74K'?

  Maciej
