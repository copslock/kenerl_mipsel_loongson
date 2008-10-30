Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 12:35:41 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:17548 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22726007AbYJ3Mfc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 12:35:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9UCZNiB013067;
	Thu, 30 Oct 2008 12:35:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9UCZLlN013066;
	Thu, 30 Oct 2008 12:35:21 GMT
Date:	Thu, 30 Oct 2008 12:35:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	alessandro.zummo@towertech.it, tsbogend@alpha.franken.de
Subject: Re: [patch 2/3] drivers/rtc/rtc-ds1286.c is borked
Message-ID: <20081030123521.GB12719@linux-mips.org>
References: <200810292121.m9TLLXQF019907@imap1.linux-foundation.org> <4909963E.6060707@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4909963E.6060707@ru.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 30, 2008 at 02:10:54PM +0300, Sergei Shtylyov wrote:
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Date: Thu, 30 Oct 2008 14:10:54 +0300
> To: akpm@linux-foundation.org
> Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
> 	alessandro.zummo@towertech.it, tsbogend@alpha.franken.de
> Subject: Re: [patch 2/3] drivers/rtc/rtc-ds1286.c is borked
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> Hello.
>
> akpm@linux-foundation.org wrote:
>
>> From: Andrew Morton <akpm@linux-foundation.org>
>>
>> drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_read':
>> drivers/rtc/rtc-ds1286.c:33: error: implicit declaration of function '__raw_readl'
>> drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_write':
>> drivers/rtc/rtc-ds1286.c:38: error: implicit declaration of function '__raw_writel'
>> drivers/rtc/rtc-ds1286.c: In function 'ds1286_probe':
>> drivers/rtc/rtc-ds1286.c:345: error: implicit declaration of function 'ioremap'
>> drivers/rtc/rtc-ds1286.c:345: warning: assignment makes pointer from integer without a cast
>> drivers/rtc/rtc-ds1286.c:365: error: implicit declaration of function 'iounmap'
>>   
>
>   Again, on which architecture this happens?

On non-MIPS.  <linux/io.h> is required to build the two files in question
but wasn't getting included explicitly.  On MIPS we were lucky; io.h
was getting dragged in indirectly through another header so things just
happened to work.

  Ralf
