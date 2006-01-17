Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 15:20:41 +0000 (GMT)
Received: from midas-91-171-chn.midascomm.com ([203.196.171.91]:18048 "EHLO
	info.midascomm.com") by ftp.linux-mips.org with ESMTP
	id S8133469AbWAQPUX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 15:20:23 +0000
Received: from bharathi.midascomm.com ([192.168.13.175])
	by info.midascomm.com (8.12.10/8.12.10) with ESMTP id k0HFNmkP030333
	for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 20:53:49 +0530
Date:	Tue, 17 Jan 2006 20:58:51 +0530 (IST)
From:	Bharathi Subramanian <sbharathi@MidasComm.Com>
To:	Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: Timer Interrupt
In-Reply-To: <00e501c61b75$a5f0c0a0$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.44.0601172050500.4435-100000@bharathi.midascomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-midascomm.com-MailScanner-Information: Please contact the ISP for more information
X-midascomm.com-MailScanner: Found to be clean
X-midascomm.com-MailScanner-From: sbharathi@midascomm.com
Return-Path: <sbharathi@MidasComm.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbharathi@MidasComm.Com
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jan 2006, Kevin D. Kissell wrote:

> > CPUs may have a variable CPU frequency which makes CPU counter not
> > usable as a timer source". Does it mean that, we can't do the CPU
> > Clock down in MIPS Processor??

> You were on the right track when you tried hacking mips_timer_ack(),
> but note that both cycles_per_jiffy and mips_hpt_frequency end up
> being used in Count-based time calculations.  If the board is
> rebooting when you tested your mod, it's probably because there's an
> error or a typo in your code.

Maybe. Started checking it by added few prink() to see the values of 
my_cycle_per_jiffy, cycles_per_jiffy and mips_hpt_frequency.

> Note that just changing the Count register increment will result in
> some small error each time the clock mode changes,

This is not an major probelm. But as you indicated, I will make some
modification in PMU driver to takecare the drift.

Thanks,
-- 
Bharathi S
