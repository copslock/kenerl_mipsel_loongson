Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 22:05:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47106 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493110AbZJOUFq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 22:05:46 +0200
Date:	Thu, 15 Oct 2009 21:05:46 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Put PGD in C0_CONTEXT for 64-bit R2
 processors.
In-Reply-To: <1255547816-7544-2-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.0910152104020.20490@eddie.linux-mips.org>
References: <4AD62353.2080603@caviumnetworks.com> <1255547816-7544-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Oct 2009, David Daney wrote:

> @@ -1406,6 +1424,7 @@ void __cpuinit build_tlb_refill_handler(void)
>  	case CPU_TX3912:
>  	case CPU_TX3922:
>  	case CPU_TX3927:
> +#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
>  		build_r3000_tlb_refill_handler();
>  		if (!run_once) {
>  			build_r3000_tlb_load_handler();
> @@ -1413,6 +1432,9 @@ void __cpuinit build_tlb_refill_handler(void)
>  			build_r3000_tlb_modify_handler();
>  			run_once++;
>  		}
> +#else
> +		panic("No R3000 TLB refill handler");
> +#endif
>  		break;
>  
>  	case CPU_R6000:

 Shouldn't this be #error or suchlike instead?

  Maciej
