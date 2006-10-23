Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 19:53:08 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:23225 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039547AbWJWSxD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 19:53:03 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 122BF3EC9; Mon, 23 Oct 2006 11:52:55 -0700 (PDT)
Message-ID: <453D0F85.3090207@ru.mvista.com>
Date:	Mon, 23 Oct 2006 22:52:53 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, tglx@linutronix.de,
	johnstul@us.ibm.com
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
References: <453BC5B4.50005@ru.mvista.com>	<20061023.120059.63742109.nemoto@toshiba-tops.co.jp>	<453CB658.9030307@ru.mvista.com> <20061024.002905.75184984.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061024.002905.75184984.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>    The whole idea of using such timer as TX39 has for both
>>generating the interrupts and as a clocksource was wrong, I'm
>>afraid.  You only can use a something similar to the MIPS counter
>>which doesn't ever get auto-reloaded for both purposes at once.

> Sure, we can do this improvement and it would be a right direction.
> But for now I just want to get previous facility back again.  And
> anyway I think someone who still have interest on this platform should
> make it buildable and bootable before further improvement ;-)

    Frankly, I'm sowewhat doubtful about TX39 timer code being sane at all 
since it doesn't clear the timer interrupt -- it clearly should override 
mips_timer_ack() and it doesn't! OTOH, it was working in 2.4 without this 
somehow... I'm puzzled since with the interrupt not being cleared anywhere 
jmr3927_do_gettimeoffset() should be returning complete crap once the frist 
interupt happens, i.e. only be jiffy-precise. Why it doesn't get the interrupt 
flood I don't know or contrarywise, no further interrupts after the first one, 
I don't know... :-/

> ---
> Atsushi Nemoto

WBR, Sergei
