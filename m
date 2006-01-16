Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 15:16:11 +0000 (GMT)
Received: from webmail.ict.ac.cn ([159.226.39.7]:53419 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133474AbWAPPPp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 15:15:45 +0000
Received: (qmail 10330 invoked by uid 507); 16 Jan 2006 14:48:21 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 16 Jan 2006 14:48:21 -0000
Message-ID: <43CBB943.7080807@ict.ac.cn>
Date:	Mon, 16 Jan 2006 23:18:27 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	colin <colin@realtek.com.tw>
CC:	linux-mips@linux-mips.org
Subject: Re: Can I use this kind of performance counters to implement oProfile?
References: <005101c61a75$43edc6b0$106215ac@realtek.com.tw>
In-Reply-To: <005101c61a75$43edc6b0$106215ac@realtek.com.tw>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

You should be able to accumulate counters during process switching or a
timer routine, I managed to implement perfctr(another profiling
software) for godson-2 cpu, for both cases with/without interrupt
support. You can look at generic perfctr code.

colin 写道:
> Hi all,
> Our SOC has performance counters, and we would like to use oProfile on it.
> After surveying the oProfile doc, I found that the model of our performance
> counters donot seem to fit oProfile.
> This is because oProfile uses the interrupts caused by overflow of, say,
> cache miss count to estimate the probability of this event in every portion.
> Our SOC doesn't emit interrupt when event count overflow. Therefore,
> oProfile cannot be used to estimate cache miss event on our chip. Is that
> right?
> 
> Regards,
> Colin
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
