Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 16:56:18 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44987 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493318AbZLCP4P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Dec 2009 16:56:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB3Fu6ll028395;
        Thu, 3 Dec 2009 15:56:06 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB3Fu4XS028392;
        Thu, 3 Dec 2009 15:56:04 GMT
Date:   Thu, 3 Dec 2009 15:56:04 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Paul Gortmaker <p_gortmaker@yahoo.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/3] RTC: rtc-cmos.c: fix warning for MIPS
Message-ID: <20091203155604.GC28957@linux-mips.org>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
 <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 05, 2009 at 09:21:54AM +0800, Wu Zhangjin wrote:

> This patch fixes the following warning with RTC_LIB on MIPS:
> 
> drivers/rtc/rtc-cmos.c:697:2: warning: #warning Assuming 128 bytes of
> RTC+NVRAM address space, not 64 bytes.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  drivers/rtc/rtc-cmos.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index f7a4701..21e48f7 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -691,7 +691,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
>  	 */
>  #if	defined(CONFIG_ATARI)
>  	address_space = 64;
> -#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) || defined(__sparc__)
> +#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) \
> +			|| defined(__sparc__) || defined(__mips__)
>  	address_space = 128;
>  #else
>  #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.

Ping.

This patch is now nearly a month old and I haven't yet heared anything.
This was actually meant to be 2.6.32 material.

  Ralf
