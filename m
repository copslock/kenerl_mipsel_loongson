Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 12:55:36 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:64462 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1492320AbZKVLz3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2009 12:55:29 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id D39313ECB; Sun, 22 Nov 2009 03:55:19 -0800 (PST)
Message-ID: <4B09269B.8070602@ru.mvista.com>
Date:	Sun, 22 Nov 2009 14:55:07 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
Cc:	Ingo Molnar <mingo@elte.hu>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
References: <dae45f23b5d34f64fc60a445015e7dfe05aa0d07.1258875717.git.wuzhangjin@gmail.com>	 <20091122081328.GB24558@elte.hu> <1258888086.4548.52.camel@falcon.domain.org>
In-Reply-To: <1258888086.4548.52.camel@falcon.domain.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Wu Zhangjin wrote:

>>> +static void __maybe_unused setup_sched_clock_update(unsigned long tclk)
>>> +{
>>> +	unsigned long data;
>>> +
>>> +	data = (0xffffffffUL / tclk / 2 - 2) * HZ;
>>>       
>
> Because the MIPS c0 count's frequency is half of the cpu frequency(Hi, Ralf, does every MIPS c0 count meet this feature?),

   No, e.g. Alchemy's C0 Count ticks at full CPU speed.

WBR, Sergei
