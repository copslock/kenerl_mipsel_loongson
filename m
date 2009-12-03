Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 17:27:40 +0100 (CET)
Received: from elettra.colt-to.towertech.it ([213.215.222.70]:35275 "EHLO
        elettra.colt-to.towertech.it" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493537AbZLCQ1h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 17:27:37 +0100
Received: from linux.lan.towertech.it (93-39-58-60.ip74.fastwebnet.it [93.39.58.60])
        by elettra.colt-to.towertech.it (Postfix) with ESMTPSA id 9A1DA116649;
        Thu,  3 Dec 2009 17:27:36 +0100 (CET)
Date:   Thu, 3 Dec 2009 17:27:35 +0100
From:   Alessandro Zummo <a.zummo@towertech.it>
To:     rtc-linux@googlegroups.com
Cc:     wuzhangjin@gmail.com, Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-mips@linux-mips.org
Subject: Re: [rtc-linux] [PATCH v1 2/3] RTC: rtc-cmos.c: enable
 RTC_DM_BINARY of RTC_LIB for fuloong2e and fuloong2f
Message-ID: <20091203172735.7c934f61@linux.lan.towertech.it>
In-Reply-To: <f05318584db5160d73af2cfb36b4e3e481a7e7a4.1257383766.git.wuzhangjin@gmail.com>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
        <f05318584db5160d73af2cfb36b4e3e481a7e7a4.1257383766.git.wuzhangjin@gmail.com>
Organization: Tower Technologies
X-Mailer: Sylpheed
X-This-Is-A-Real-Message: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.95.2 at elettra
X-Virus-Status: Clean
Return-Path: <a.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Thu,  5 Nov 2009 09:22:09 +0800
Wu Zhangjin <wuzhangjin@gmail.com> wrote:

>  	 */
> -	if (is_valid_irq(rtc_irq) &&
> -	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
> -		dev_dbg(dev, "only 24-hr BCD mode supported\n");
> +	if (is_valid_irq(rtc_irq) && !(rtc_control & RTC_24H)) {
> +		dev_dbg(dev, "only 24-hr supported\n");

 If this check was there it's probably because there are problems
 in some other parts of the driver. I'm not keen to add this without
 some feedback by the original author or porter.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
