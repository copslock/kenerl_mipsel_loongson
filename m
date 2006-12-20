Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 09:38:09 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:59047 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28581953AbWLTJiE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 09:38:04 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1Gwxsz-00006h-21
	for linux-mips@linux-mips.org; Wed, 20 Dec 2006 01:37:17 -0800
Message-ID: <7987092.post@talk.nabble.com>
Date:	Wed, 20 Dec 2006 01:37:17 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
In-Reply-To: <20061220.021508.97296486.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp> <20061220.000113.59033093.anemo@mba.ocn.ne.jp> <7949125.post@talk.nabble.com> <20061220.021508.97296486.anemo@mba.ocn.ne.jp>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips




Atsushi Nemoto wrote:
> 
> <snip>
> Hm, then it seems writing to COMPARE does not clear COUNT.
> 
> How about this?  You should still fix pnx8550_hpt_read() anyway, but I
> suppose gettimeofday() on PNX8550 was broken long time.
> 
> 
> Subject: [MIPS] Use custom timer_ack and clocksource_mips.read for PNX8550
> 

I have not tried the suggested change yet, but I have fiund the mips manual
and here is what it says:

The 32-bit register is both readable and writable through the MTC0 and MFC0
instructions as CP0 register 9. Upon reset, the Count register is set to 0.
Count and Compare together make up Timer_1 in the PR4450 (see Section 3.12).
The timer is active by default. When active, Count register contains a free
running
counter; on each processor clock-tick, the value in the register increments
by one.
However, when bit ST1 bit[3] in the CP0 Configuration register is enabled,
the timer is
stopped. When the ST1 bit is disabled, the timer returns to its default
state.
Timer_1 is active when the PR4450 is in Sleep mode, but is switched off when
the
PR4450 is in Coma mode.
When active, the register can be reset with the assertion of the Terminal
Count
(TC_1) signal, which is asserted when the values in the Count and Compare
registers
match. After the Count register is reset, it restarts its count on the next
processor
clock-tick.
In the PR4450, the TC_1 signal is fed to the external hardware interrupt
signal to
invoke an interrupt handler e.g., the timer interrupt. The TC_1 signal can
only be
reset to 0 when the interrupt handler performs a write to the Compare
register.
Consecutive writes to Count will result in undefined contents. At least one
instruction
must be inserted between consecutive writes to Count.

This seems to suggest that writing to the compare register does in fact
clear count.
If I do the following:
static void __init c0_hpt_timer_init(void)
{
#ifdef CONFIG_SOC_PNX8550 /* pnx8550 resets to zero */
    expirelo = cycles_per_jiffy;
#else
    expirelo = read_c0_count() + cycles_per_jiffy;
#endif
    write_c0_compare(expirelo);
    write_c0_count(cycles_per_jiffy); //Added DJL
}
Then I get  a normal startup.  i.e it boots fast (no 10second hang).  If I
remove the write_c0_count then I get the 10 second hang.
I have no idea if gettimeofday is broken.  ANy ideas on testing this? Is
there a test package / application that will do this?  Before I write my own

Thanks for the suggestions keep them coming!
Cheers
Dan


-- 
View this message in context: http://www.nabble.com/2.6.19-timer-API-changes-tf2838715.html#a7987092
Sent from the linux-mips main mailing list archive at Nabble.com.
