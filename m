Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2012 03:58:31 +0200 (CEST)
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40800 "EHLO e2.ny.us.ibm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903716Ab2DKB6W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Apr 2012 03:58:22 +0200
Received: from /spool/local
        by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <john.stultz@linaro.org>;
        Tue, 10 Apr 2012 21:58:15 -0400
Received: from d01dlp01.pok.ibm.com (9.56.224.56)
        by e2.ny.us.ibm.com (192.168.1.102) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 10 Apr 2012 21:58:13 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
        by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 04E9738C8054;
        Tue, 10 Apr 2012 21:58:12 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
        by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q3B1wC3A342974;
        Tue, 10 Apr 2012 21:58:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q3B1wBkP020478;
        Tue, 10 Apr 2012 22:58:11 -0300
Received: from [9.76.19.45] (sig-9-76-19-45.mts.ibm.com [9.76.19.45])
        by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q3B1wANp020010;
        Tue, 10 Apr 2012 22:58:10 -0300
Message-ID: <4F84E531.3010001@linaro.org>
Date:   Tue, 10 Apr 2012 18:58:09 -0700
From:   John Stultz <john.stultz@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Yong Zhang <yong.zhang0@gmail.com>, linux-mips@linux-mips.org
Subject: pnx_clocksource broken?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12041101-5112-0000-0000-000006F433FF
X-archive-position: 32930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john.stultz@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Looking at arch/mips/pnx8550/common/time.c the pnx_clocksource never 
seems to be assigned a mult/shift value before it calls 
clocksource_register(). Clearly this is broken and I suspect this 
clocksource is never used.

I was hoping to convert this driver over (its the last of 3 remaining) 
to use clocksource_register_hz/khz() but I'm not sure what the actual 
frequency of the hardware should be. Is mips_hpt_frequency the right 
value here?

Even so, if this is clocksource is never used, should it just be removed?

thanks
-john
