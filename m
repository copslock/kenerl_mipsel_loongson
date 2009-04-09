Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 12:55:15 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:4412 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021464AbZDILzI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 12:55:08 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 6DA9A3EC9; Thu,  9 Apr 2009 04:55:05 -0700 (PDT)
Message-ID: <49DDE244.6030606@ru.mvista.com>
Date:	Thu, 09 Apr 2009 15:55:48 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	yanhua <yanh@lemote.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 10/14] lemote: rtc driver binary mode support
References: <49DD8238.7060609@lemote.com>
In-Reply-To: <49DD8238.7060609@lemote.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

yanhua wrote:

> The original driver will exit when detect rtc binary mode. In fact both
> the binary mode and bcd are supported

[...]

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index b6d35f5..85c327e 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -757,7 +757,7 @@ cmos_do_probe(struct device *dev, struct resource
> *ports, int rtc_irq)
> * <asm-generic/rtc.h> doesn't know 12-hour mode either.
> */
> if (is_valid_irq(rtc_irq) &&
> - (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
> + (!(rtc_control & RTC_24H) /*|| (rtc_control & (RTC_DM_BINARY))*/)) {
> dev_dbg(dev, "only 24-hr BCD mode supported\n");

   Perhaps the message should be changed too then...

> retval = -ENXIO;
> goto cleanup1;

WBR, Sergei
