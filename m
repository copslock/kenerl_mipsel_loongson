Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 15:53:05 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:55008 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28577122AbWLSPxB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 15:53:01 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3893F3ECA; Tue, 19 Dec 2006 07:52:39 -0800 (PST)
Message-ID: <45880AC4.5010403@ru.mvista.com>
Date:	Tue, 19 Dec 2006 18:52:36 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	danieljlaird@hotmail.com, linux-mips@linux-mips.org,
	Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: 2.6.19 timer API changes
References: <7925588.post@talk.nabble.com>	<7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061219.233410.25911550.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>When I run the kernel it hangs in the calibrate_delay function. 
>>Eventually the complete kernel does run but it runs very slow. 
>>This is usually an issue with the Timer Interuppt setup etc.  But I have
>>looked at the other MIPS ports and seem to have made the same changes. 

>>On the PNX8550 it does not use the CP0 timer but use a different timer (the
>>Custom MIPS core has 3 extra timers) 

> Hmm, do the TIMER1 and CP0_COUNTER run at same speed?  If no, the
> PNX8550 port should be broken (i.e. gettimeofday() did not work
> properly) even without the timer API changes.  You should provide
> custom clocksource.mips_read (previously named mips_hpt_read) function
> which returns TIMER1 counter value.  If the TIMER1 was not 32-bit
> free-run counter, some trick would be required.  Refer sb1250 or
> jmr3927 for example.

    I would like to discourage you from repeating those JMR3927 clocksource 
"tricks" when you have 3 spare count/compare regs. This will warrant troubles 
when clockevents support gets merged into mainline (in fact, it was not 
necessary even on JMR3927 which has 3 timers). Although, if the timer isn't 
auto-reloading (I assume it isn't), the trick shouldn't be needed.

> ---
> Atsushi Nemoto

WBR, Sergei
