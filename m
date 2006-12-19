Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 14:51:59 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:47519 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28576942AbWLSOvy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 14:51:54 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1GwgJo-0006wo-7E
	for linux-mips@linux-mips.org; Tue, 19 Dec 2006 06:51:48 -0800
Message-ID: <7948316.post@talk.nabble.com>
Date:	Tue, 19 Dec 2006 06:51:48 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
In-Reply-To: <20061219.233410.25911550.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips



Atsushi Nemoto wrote:
> 
> Hmm, do the TIMER1 and CP0_COUNTER run at same speed?  If no, the
> PNX8550 port should be broken (i.e. gettimeofday() did not work
> properly) even without the timer API changes.  You should provide
> custom clocksource.mips_read (previously named mips_hpt_read) function
> which returns TIMER1 counter value.  If the TIMER1 was not 32-bit
> free-run counter, some trick would be required.  Refer sb1250 or
> jmr3927 for example.
> 
> ---
> Atsushi Nemoto
> 
> 
> 
I am just starting to look into this (thankyou for your first comments).
I have reduced the problem code, so if I change the following:
/* For use both as a high precision timer and an interrupt source.  */
static void __init c0_hpt_timer_init(void)
{
	expirelo = read_c0_count() + cycles_per_jiffy;
	write_c0_compare(expirelo);
} (the 2.6.19 version)
to the following:
/* For use both as a high precision timer and an interrupt source.  */
static void __init c0_hpt_timer_init(void)
{
    unsigned int count = read_c0_count() - mips_hpt_read();
	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
	write_c0_count(expirelo - cycles_per_jiffy);
	write_c0_compare(expirelo);
	write_c0_count(count);
}

Then i get the system to boot up and all seems well.  I am new to this and
am looking into why this change makes the system boot up.  As always though
any help is appreciated.

Cheers
Dan
-- 
View this message in context: http://www.nabble.com/2.6.19-timer-API-changes-tf2838715.html#a7948316
Sent from the linux-mips main mailing list archive at Nabble.com.
