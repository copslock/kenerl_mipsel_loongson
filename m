Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 11:11:15 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:63783 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22721285AbYJ3LLF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 11:11:05 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DBE703EC9; Thu, 30 Oct 2008 04:10:58 -0700 (PDT)
Message-ID: <4909963E.6060707@ru.mvista.com>
Date:	Thu, 30 Oct 2008 14:10:54 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	akpm@linux-foundation.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	alessandro.zummo@towertech.it, tsbogend@alpha.franken.de
Subject: Re: [patch 2/3] drivers/rtc/rtc-ds1286.c is borked
References: <200810292121.m9TLLXQF019907@imap1.linux-foundation.org>
In-Reply-To: <200810292121.m9TLLXQF019907@imap1.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

akpm@linux-foundation.org wrote:

> From: Andrew Morton <akpm@linux-foundation.org>
>
> drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_read':
> drivers/rtc/rtc-ds1286.c:33: error: implicit declaration of function '__raw_readl'
> drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_write':
> drivers/rtc/rtc-ds1286.c:38: error: implicit declaration of function '__raw_writel'
> drivers/rtc/rtc-ds1286.c: In function 'ds1286_probe':
> drivers/rtc/rtc-ds1286.c:345: error: implicit declaration of function 'ioremap'
> drivers/rtc/rtc-ds1286.c:345: warning: assignment makes pointer from integer without a cast
> drivers/rtc/rtc-ds1286.c:365: error: implicit declaration of function 'iounmap'
>   

   Again, on which architecture this happens?

WBR, Sergei
