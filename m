Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 13:22:38 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21901 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024464AbXLJNWg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 13:22:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBADMJXp012909;
	Mon, 10 Dec 2007 13:22:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBADMHBg012908;
	Mon, 10 Dec 2007 13:22:17 GMT
Date:	Mon, 10 Dec 2007 13:22:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] set up Cobalt's mips_hpt_frequency
Message-ID: <20071210132217.GB11886@linux-mips.org>
References: <20071209212204.5e50a697.yoichi_yuasa@tripeaks.co.jp> <475D2B21.7050206@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475D2B21.7050206@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 10, 2007 at 03:03:45PM +0300, Sergei Shtylyov wrote:

>> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/time.c mips/arch/mips/cobalt/time.c
>> --- mips-orig/arch/mips/cobalt/time.c	2007-12-06 18:27:02.689043750 +0900
>> +++ mips/arch/mips/cobalt/time.c	2007-12-09 17:13:37.916769000 +0900
>> @@ -27,9 +27,28 @@
>>   void __init plat_time_init(void)
>>  {
>> +	u32 start, end;
>> +	int i = HZ / 10;
>> +
>>  	setup_pit_timer();
>>   	gt641xx_set_base_clock(GT641XX_BASE_CLOCK);
>>  -	mips_timer_state = gt641xx_timer0_state;
>> +	/*
>> +	 * MIPS counter frequency is measured between 100msec 
>
>    s/between/during/

Fixed.  The patch which will go to Linus will have the typo fix comment
folded into the actual mips_hpt_frequency patch.

  Ralf
