Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 07:22:53 +0000 (GMT)
Received: from midas-91-171-chn.midascomm.com ([203.196.171.91]:7655 "EHLO
	info.midascomm.com") by ftp.linux-mips.org with ESMTP
	id S8133357AbWAQHWf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 07:22:35 +0000
Received: from bharathi.midascomm.com ([192.168.13.175])
	by info.midascomm.com (8.12.10/8.12.10) with ESMTP id k0H7Q2kP016839
	for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:56:03 +0530
Date:	Tue, 17 Jan 2006 13:00:58 +0530 (IST)
From:	Bharathi Subramanian <sbharathi@MidasComm.Com>
To:	Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: Timer Interrupt
In-Reply-To: <Pine.LNX.4.44.0601162057330.31018-100000@bharathi.midascomm.com>
Message-ID: <Pine.LNX.4.44.0601171226380.1259-100000@bharathi.midascomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-midascomm.com-MailScanner-Information: Please contact the ISP for more information
X-midascomm.com-MailScanner: Found to be clean
X-midascomm.com-MailScanner-From: sbharathi@midascomm.com
Return-Path: <sbharathi@MidasComm.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbharathi@MidasComm.Com
Precedence: bulk
X-list: linux-mips

On Mon, 16 Jan 2006, Bharathi Subramanian wrote:

> We are trying to implement the CPU Clock down feature for saving the 
> power. In this process, Whenever the CPU is put in 1/2 Clock then the 
> Timer interrupt is also getting delayed.
> 
> Later I found that CPU Counter is used to generate the timer intr. How 
> to make the Timer interrupt to happen at every 10ms, even if the CPU 
> is in 1/2, 1/4 or 1/8 of the original clock??
> 
> Processor: MIPS 4Kc 32B
  Kernel   : 2.4.20

In mips_timer_ack() function, the new Compare reg value loaded. Here I 
tried to put new counter value based on the present cpu clock divder 
setting. But board is getting rebooted.

Is it the right way to handle this issue?? Anybody faced same 
condition, kindly share your exprience with me.

Thanks,
-- 
Bharathi S
