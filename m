Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 09:05:33 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:55213 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990864AbdH3HEY37FgB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2017 09:04:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+VJEXeFw54vgkrrkhfv6n18UAWJVJl4Diqe9KFFq6q8=; b=zZT3aM7ZR+pXAT6QZYeGra/Rn+
        CsYzk9vKlYM5mKmu4qylF17H9zPHUeZsSCd072ifvqN/tmf0Ai7yVlx41THRLM567frLKVC0ls9xm
        lLmdFxHbVxuicZ8zO3RILPoprzyr3kCucUalas/X02lI6QXo8xDjHEA1f6LyKjsFfmGqGbmHcDrtk
        WU0WyMhxwSbA4KK+DePHfjABh0lLMlf/oA/c0+b0/bEQN/ocm4X4QojlqTj9VtVQWnBYo/xIeqpHL
        l1RAVaGEFe0/2J7f9OD7hGJ22q0PQHnNkhqSg0XYVi5u1xwTPV5XGhAxlU/QzojOdfhQ4FcyoRFD3
        Em7vIF+w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53256 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1dmuhZ-001xyB-Fg; Wed, 30 Aug 2017 04:34:06 +0000
Date:   Tue, 29 Aug 2017 21:34:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 7/8] watchdog: octeon-wdt: Add support for cn68XX SOCs.
Message-ID: <20170830043404.GC14791@roeck-us.net>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
 <1504021238-3184-8-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504021238-3184-8-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Tue, Aug 29, 2017 at 10:40:37AM -0500, Steven J. Hill wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 48 +++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index 73b5102..410800f 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -69,6 +69,9 @@
>  
>  #include <asm/octeon/octeon.h>
>  #include <asm/octeon/cvmx-boot-vector.h>
> +#include <asm/octeon/cvmx-ciu2-defs.h>
> +
> +static int divisor;
>  
>  /* The count needed to achieve timeout_sec. */
>  static unsigned int timeout_cnt;
> @@ -227,10 +230,10 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
>  	u64 cp0_epc = read_c0_epc();
>  
>  	/* Delay so output from all cores output is not jumbled together. */
> -	__delay(100000000ull * coreid);
> +	udelay(85000 * coreid);
>  
>  	octeon_wdt_write_string("\r\n*** NMI Watchdog interrupt on Core 0x");
> -	octeon_wdt_write_hex(coreid, 1);
> +	octeon_wdt_write_hex(coreid, 2);
>  	octeon_wdt_write_string(" ***\r\n");
>  	for (i = 0; i < 32; i++) {
>  		octeon_wdt_write_string("\t");
> @@ -253,11 +256,28 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
>  	octeon_wdt_write_hex(cp0_cause, 16);
>  	octeon_wdt_write_string("\r\n");
>  
> -	octeon_wdt_write_string("\tsum0\t0x");
> -	octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_SUM0(coreid * 2)), 16);
> -	octeon_wdt_write_string("\ten0\t0x");
> -	octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)), 16);
> -	octeon_wdt_write_string("\r\n");
> +	/* The CIU register is different for each Octeon model. */
> +	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
> +		octeon_wdt_write_string("\tsrc_wd\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SRC_PPX_IP2_WDOG(coreid)), 16);
> +		octeon_wdt_write_string("\ten_wd\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_EN_PPX_IP2_WDOG(coreid)), 16);
> +		octeon_wdt_write_string("\r\n");
> +		octeon_wdt_write_string("\tsrc_rml\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SRC_PPX_IP2_RML(coreid)), 16);
> +		octeon_wdt_write_string("\ten_rml\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_EN_PPX_IP2_RML(coreid)), 16);
> +		octeon_wdt_write_string("\r\n");
> +		octeon_wdt_write_string("\tsum\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SUM_PPX_IP2(coreid)), 16);
> +		octeon_wdt_write_string("\r\n");
> +	} else if (!octeon_has_feature(OCTEON_FEATURE_CIU3)) {
> +		octeon_wdt_write_string("\tsum0\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_SUM0(coreid * 2)), 16);
> +		octeon_wdt_write_string("\ten0\t0x");
> +		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)), 16);
> +		octeon_wdt_write_string("\r\n");
> +	}
>  
>  	octeon_wdt_write_string("*** Chip soft reset soon ***\r\n");
>  }
> @@ -366,7 +386,7 @@ static void octeon_wdt_calc_parameters(int t)
>  
>  	countdown_reset = periods > 2 ? periods - 2 : 0;
>  	heartbeat = t;
> -	timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * timeout_sec) >> 8;
> +	timeout_cnt = ((octeon_get_io_clock_rate() / divisor) * timeout_sec) >> 8;
>  }
>  
>  static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
> @@ -437,9 +457,7 @@ static enum cpuhp_state octeon_wdt_online;
>   */
>  static int __init octeon_wdt_init(void)
>  {
> -	int i;
>  	int ret;
> -	u64 *ptr;
>  
>  	octeon_wdt_bootvector = cvmx_boot_vector_get();
>  	if (!octeon_wdt_bootvector) {
> @@ -447,10 +465,15 @@ static int __init octeon_wdt_init(void)
>  		return -ENOMEM;
>  	}
>  
> +	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
> +		divisor = 0x200;
> +	else
> +		divisor = 0x100;
> +
>  	/*
>  	 * Watchdog time expiration length = The 16 bits of LEN
>  	 * represent the most significant bits of a 24 bit decrementer
> -	 * that decrements every 256 cycles.
> +	 * that decrements every divisor cycle.
>  	 *
>  	 * Try for a timeout of 5 sec, if that fails a smaller number
>  	 * of even seconds,
> @@ -458,8 +481,7 @@ static int __init octeon_wdt_init(void)
>  	max_timeout_sec = 6;
>  	do {
>  		max_timeout_sec--;
> -		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) *
> -			      max_timeout_sec) >> 8;
> +		timeout_cnt = ((octeon_get_io_clock_rate() / divisor) * max_timeout_sec) >> 8;
>  	} while (timeout_cnt > 65535);
>  
>  	BUG_ON(timeout_cnt == 0);
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
