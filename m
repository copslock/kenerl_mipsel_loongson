Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 22:56:54 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:42142 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025399AbZELV4i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 22:56:38 +0100
X-IronPort-AV: E=Sophos;i="4.41,184,1241395200"; 
   d="scan'208";a="184536599"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-1.cisco.com with ESMTP; 12 May 2009 21:56:18 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n4CLuI2O027876;
	Tue, 12 May 2009 14:56:18 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n4CLuI3f014963;
	Tue, 12 May 2009 21:56:18 GMT
Date:	Tue, 12 May 2009 14:56:18 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: Remove execution hazard barriers for Octeon.
Message-ID: <20090512215618.GA32507@cuplxvomd02.corp.sa.net>
References: <4A09D0B1.2030305@caviumnetworks.com> <1242157315-20719-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242157315-20719-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1060; t=1242165378; x=1243029378;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202/3]=20MIPS=3A=20Remove=20exec
	ution=20hazard=20barriers=20for=20Octeon.
	|Sender:=20;
	bh=jkiqe8eI6Fi/UN4FPq3b6E7Sj8XvMaX6daSAqVQN4Wk=;
	b=opNyWdHN5oRtgEXkyYmo5TQfsyCdJs2NPUXc22fZiar5FOKtKa1BZPkoIu
	LhITRI8rQ7X1pbJ858CLoPo/RY5ofqhgyv1nwOOc5GEKHFBkQJ44vKbd0N2e
	MgSmLLZYV0;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, May 12, 2009 at 12:41:54PM -0700, David Daney wrote:
> The Octeon has no execution hazards, so we can remove them and save an
> instruction per TLB handler invocation.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> index 04ce6e6..bb291f4 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> @@ -47,6 +47,7 @@
>  #define cpu_has_mips32r2	0
>  #define cpu_has_mips64r1	0
>  #define cpu_has_mips64r2	1
> +#define cpu_has_mips_r2_exec_hazard 0
>  #define cpu_has_dsp		0
>  #define cpu_has_mipsmt		0
>  #define cpu_has_userlocal	0
> -- 
> 1.6.0.6

Simple enough that even I can understand it.

Reviewed by: David VomLehn <dvomlehn@cisco.com>
