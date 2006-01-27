Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 08:21:12 +0000 (GMT)
Received: from midas-91-171-chn.midascomm.com ([203.196.171.91]:392 "EHLO
	info.midascomm.com") by ftp.linux-mips.org with ESMTP
	id S3458494AbWA0IUx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 08:20:53 +0000
Received: from bharathi.midascomm.com ([192.168.13.175])
	by info.midascomm.com (8.12.10/8.12.10) with ESMTP id k0R8PF1E012328
	for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 13:55:19 +0530
Date:	Fri, 27 Jan 2006 14:02:36 +0530 (IST)
From:	Bharathi Subramanian <sbharathi@MidasComm.Com>
To:	Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: Timer Interrupt
In-Reply-To: <00e501c61b75$a5f0c0a0$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.44.0601271349350.2185-100000@bharathi.midascomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-midascomm.com-MailScanner-Information: Please contact the ISP for more information
X-midascomm.com-MailScanner: Found to be clean
X-midascomm.com-MailScanner-From: sbharathi@midascomm.com
Return-Path: <sbharathi@MidasComm.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbharathi@MidasComm.Com
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jan 2006, Kevin D. Kissell wrote:

> You were on the right track when you tried hacking mips_timer_ack(),
> but note that both cycles_per_jiffy and mips_hpt_frequency end up
> being used in Count-based time calculations.

I fixed the CPU Clock down and Timer interrupt problem like this:

static void c0_timer_ack(void)
{
  int count;
 /* Bharathi: To maintain the Timer in clock down mode.
  * cpu_clk_change is set by PMU Driver */

 if(test_and_clear_bit(0, &cpu_clk_change))
 {
   READ_REG( PMU_CLKMODE, cpu_clk_div);
   /* Divide the orginal timer count */
   my_cycles_per_jiffy = cycles_per_jiffy >> (cpu_clk_divA);
 }
 /* Ack this timer interrupt and set the next one. */
 expirelo += my_cycles_per_jiffy;
 write_c0_compare(expirelo);

 /* Check to see if we have missed any timer interrupts. */
 count = read_c0_count();

 if ((count - expirelo) < 0x7fffffff) {
    expirelo = count + my_cycles_per_jiffy;
    write_c0_compare(expirelo);
 }
}

NOTE:

0. cpu_clk_change is global, static and exported to access in PMU Drv.

1. In time_init(), set my_cycles_per_jiffy = cycles_per_jiffy to
   handle initial state.

2. If needed, Change the SDRAM Refresh Rate during clk dwn.

3. Force few uSec delay after clock-up for smooth & stable transition.

4. I am NOT an expert in Kernel/MIPS. Feel free to correct me.

Kindly CC me.

Thanks :)
-- 
Bharathi S
