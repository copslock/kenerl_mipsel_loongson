Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2006 02:55:32 +0100 (BST)
Received: from gateway-1237.mvista.com ([63.81.120.158]:56250 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20038926AbWJ0Bzb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Oct 2006 02:55:31 +0100
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 682B41BF2E; Thu, 26 Oct 2006 18:55:03 -0700 (PDT)
Message-ID: <454166F7.70200@mvista.com>
Date:	Thu, 26 Oct 2006 18:55:03 -0700
From:	mlachwani <mlachwani@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	m_lachwani@yahoo.com, creideiki+linux-mips@ferretporn.se,
	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
References: <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>	<20061026074216.68000.qmail@web37504.mail.mud.yahoo.com> <20061026.231642.126142599.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061026.231642.126142599.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

I tried out your patch on the SWARM SMP and it works.

thanks,
Manish Lachwani

Atsushi Nemoto wrote:
> On Thu, 26 Oct 2006 00:42:16 -0700 (PDT), Manish Lachwani <m_lachwani@yahoo.com> wrote:
>   
>> It could be that I am seeing a similar issue on the
>> SWARM board (sb1250) as well. Your patch removed the
>> shifts for mip_hpt_frequency from
>> arch/mips/sibyte/sb1250/time.c and in the
>> sb1250_hpt_read(). The Sibyte HPT is 1 Mhz. However,
>> when I added those shifts back, I did not see any
>> issues with the system clock. I could possibly try out
>> your patch with lower clocksource shift values and see
>> if the system clock is still wrong.
>>     
>
> I just sent the patch.  Please try it.
>
>   
>> Btw, the clocksource changes seem to work well on the
>> BCM 1480 based board. 
>>     
>
> Thanks, good news!
>
> As Ralf pointed out, current code still problematic on some SMP
> system, but I think IP27, SB1250, BCM1480 should be OK now while their
> mips_hpt_read are not using per-CPU cp0 timers.
>
> ---
> Atsushi Nemoto
>
>   
