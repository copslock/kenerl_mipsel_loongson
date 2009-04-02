Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 11:56:51 +0100 (BST)
Received: from tenor.i-cable.com ([203.83.115.107]:33153 "HELO
	tenor.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20025401AbZDBK4o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 11:56:44 +0100
Received: (qmail 4517 invoked by uid 508); 2 Apr 2009 10:56:33 -0000
Received: from 203.83.114.122 by tenor (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7824.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 3.168078 secs); 02 Apr 2009 10:56:33 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 2 Apr 2009 10:56:29 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n32AuSSW026094;
	Thu, 2 Apr 2009 18:56:29 +0800 (CST)
Date:	Thu, 2 Apr 2009 18:56:13 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	wuzj@lemote.com
Subject: Re: [PATCH] added Loongson cpu-feature-overrides.h
Message-ID: <20090402105613.GC28319@adriano.hkcable.com.hk>
Mail-Followup-To: linux-mips@linux-mips.org, wuzj@lemote.com
References: <1238658105-23260-1-git-send-email-r0bertz@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238658105-23260-1-git-send-email-r0bertz@gentoo.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 15:41 Thu 02 Apr     , Zhang Le wrote:
> diff --git a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
> new file mode 100644
> index 0000000..550a10d
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h

[snip]

> +#define cpu_icache_snoops_remote_store	1

This maybe should not exist here, since this only matters on SMP.
It exists in Wu's version. Maybe Wu could explain it. Maybe it is just a typo.

Pulling him in.

Zhang Le

> +
> +#endif /* __ASM_MACH_LEMOTE_CPU_FEATURE_OVERRIDES_H */
> -- 
> 1.6.2
> 
