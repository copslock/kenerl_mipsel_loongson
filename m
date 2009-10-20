Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 23:58:12 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3590 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493595AbZJTV6F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2009 23:58:05 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ade325d0000>; Tue, 20 Oct 2009 14:57:49 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 14:56:53 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 14:56:53 -0700
Message-ID: <4ADE3225.5050001@caviumnetworks.com>
Date:	Tue, 20 Oct 2009 14:56:53 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Thomas Gleixner <tglx@linutronix.de>
CC:	Linus Walleij <linus.walleij@stericsson.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code generic
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com> <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2009 21:56:53.0381 (UTC) FILETIME=[3BEB6350:01CA51D0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Thomas Gleixner wrote:
> On Sun, 18 Oct 2009, Linus Walleij wrote:
>> This moves the clocksource_set_clock() and clockevent_set_clock()
>> from the MIPS timer code into clockchips and clocksource where
>> it belongs. The patch was triggered by code posted by Mikael
>> Pettersson duplicating this code for the IOP ARM system. The
>> function signatures where altered slightly to fit into their
>> destination header files, unsigned int changed to u32 and inlined.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Mikael Pettersson <mikpe@it.uu.se>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> Ralf has stated in earlier conversation that this should be moved,
>> now we risk duplicating code so let's move it.
> 
> Please do not make that functions inline. They are too large and there
> is no benefit of inlining them.
> 

If that is the case, then perhaps they should not be defined in a header 
file.

IMHO if you are defining a function in a header file it should always be 
  'static inline'.  If you don't want it in-lined, put it in some 
library so we only pick up a single instance of it.

David Daney
