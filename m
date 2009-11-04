Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 17:25:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39637 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493367AbZKDQZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 17:25:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA4GQp9x022014;
	Wed, 4 Nov 2009 17:26:52 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA4GQoP0022012;
	Wed, 4 Nov 2009 17:26:50 +0100
Date:	Wed, 4 Nov 2009 17:26:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2] RTC: enable RTC_LIB for fuloong2e and fuloong2f
Message-ID: <20091104162650.GB18408@linux-mips.org>
References: <1257349762-21407-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257349762-21407-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 04, 2009 at 11:49:22PM +0800, Wu Zhangjin wrote:

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index f7a4701..820bdad 100644
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

I'd like to see at least this first segment included for 2.6.32 already.

  Ralf
