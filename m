Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 12:58:59 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:51733 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133844AbVKCM6m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 12:58:42 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA3CxRMu009675;
	Thu, 3 Nov 2005 12:59:27 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA3CxQfB009674;
	Thu, 3 Nov 2005 12:59:26 GMT
Date:	Thu, 3 Nov 2005 12:59:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] use rtc_lock to protect RTC operations
Message-ID: <20051103125926.GB3149@linux-mips.org>
References: <20051103.010115.07642880.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103.010115.07642880.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 03, 2005 at 01:01:15AM +0900, Atsushi Nemoto wrote:

> Many RTC routines are not protected each other.  There are potential
> race, for example, ntp-update and /dev/rtc.  This patch fixes them
> using rtc_lock.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

> --- a/arch/mips/dec/time.c
> +++ b/arch/mips/dec/time.c
> @@ -37,10 +37,25 @@
>  #include <asm/dec/machtype.h>
>  
>  
> +/*
> + * Returns true if a clock update is in progress
> + */
> +static inline unsigned char dec_rtc_is_updating(void)
> +{
> +	unsigned char uip;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rtc_lock, flags);
> +	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
> +	spin_unlock_irqrestore(&rtc_lock, flags);

Unlike on PC CMOS_READ on a DEC is a single read operation, so atomic
and so doesn't need to be protected.  I'd have to check the datasheet
for any other reason why it might need locking though, so I apply your
patch for now and leave this to Maciej for later optimization.

  Ralf
