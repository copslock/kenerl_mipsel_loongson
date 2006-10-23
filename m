Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 17:42:12 +0100 (BST)
Received: from gateway-1237.mvista.com ([63.81.120.158]:4261 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20038559AbWJWQmI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 17:42:08 +0100
Received: from [10.0.0.139] (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 448081BE1D; Mon, 23 Oct 2006 09:41:50 -0700 (PDT)
Message-ID: <453CF0CE.3000005@mvista.com>
Date:	Mon, 23 Oct 2006 09:41:50 -0700
From:	mlachwani <mlachwani@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, tglx@linutronix.de, johnstul@us.ibm.com
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>	<453BC5B4.50005@ru.mvista.com> <20061023.120407.122620341.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061023.120407.122620341.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Oh I missed final comment ...
>
> On Sun, 22 Oct 2006 23:25:40 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>   
>>> +	init_mips_clocksource();
>>>       
>>     Well, this is usually done via module_init()...
>>     
>
> As I wrote in reply to Manish, I do not see good reason to use
> module_init here.
>
> ---
> Atsushi Nemoto
>
>   
Ok, sounds good. Btw, I have a clockevents patch (needed for HRT and RT) 
based off the clocksource patch and working on Sibyte.
I will send that out once I verify that it works off your patch as well.

Thanks,
Manish Lachwani
