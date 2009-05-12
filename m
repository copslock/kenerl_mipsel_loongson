Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 23:42:12 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:24911 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025434AbZELWmG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 23:42:06 +0100
X-IronPort-AV: E=Sophos;i="4.41,184,1241395200"; 
   d="scan'208";a="184558853"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-1.cisco.com with ESMTP; 12 May 2009 22:41:43 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n4CMfhiC022869;
	Tue, 12 May 2009 15:41:43 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id n4CMfhga006446;
	Tue, 12 May 2009 22:41:43 GMT
Date:	Tue, 12 May 2009 15:41:43 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: Remove dead case label.
Message-ID: <20090512224143.GB32507@cuplxvomd02.corp.sa.net>
References: <4A09D0B1.2030305@caviumnetworks.com> <1242157315-20719-3-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242157315-20719-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=867; t=1242168103; x=1243032103;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=203/3]=20MIPS=3A=20Remove=20dead
	=20case=20label.
	|Sender:=20;
	bh=RPiJupRzI2gIuT+r05ABMdM5D9pZozK8qmODqLoLYqQ=;
	b=uLcTC/qZZUru/yJO28AYyFmKcG8Qudo6GU3IsmAhkw50F65kbVjFk7H3AQ
	v94D5tQEOk8iX6m0YBgq2RWMOTAK3lNYS2/FpL6SPt66MC8FgHbRjKl2aStR
	/JGxhqkQb5;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, May 12, 2009 at 12:41:55PM -0700, David Daney wrote:
> CPU_CAVIUM_OCTEON is mips_r2 which is handled before the switch.  This
> label in the switch statement is dead code, so we remove it.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/mm/tlbex.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 4108674..4dc4f3e 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -311,7 +311,6 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
>  	case CPU_BCM3302:
>  	case CPU_BCM4710:
>  	case CPU_LOONGSON2:
> -	case CPU_CAVIUM_OCTEON:
>  	case CPU_R5500:
>  		if (m4kc_tlbp_war())
>  			uasm_i_nop(p);

Fewer lines of code is good...

Reviewed by: David VomLehn <dvomlehn@cisco.com>
