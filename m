Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 12:35:25 +0100 (CET)
Received: from h155.mvista.com ([63.81.120.155]:1132 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S528495AbYC1LfR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 12:35:17 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1E7FA3ECA; Fri, 28 Mar 2008 04:34:44 -0700 (PDT)
Message-ID: <47ECD828.8090600@ru.mvista.com>
Date:	Fri, 28 Mar 2008 14:36:08 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Nico Coesel <ncoesel@DEALogic.nl>
Subject: Re: FW: Alchemy power managment code.
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl> <47E7B970.30105@ru.mvista.com> <47E7BB4B.3080507@ru.mvista.com> <20080327223134.GA26997@linux-mips.org>
In-Reply-To: <20080327223134.GA26997@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>> >    The TOY cpunter 0 clockevent driver is also need to be written for

>>>the recent kernel as CP0 timer stops ticking after wait insn is executed 
>>>-- see arch/mips/au1000/common/time.c...

>>   And here's found another possible issue with Alchemy PM -- the CP0 
>>counter counts at unpredictable frequency in idle state (after executing 
>>"wait"), so the MIPS clocksource will probably be unstable?

> Correct - and cevt-r4k won't be usable either.  I guess that means you
> leave the user the choice between either these two or using wait.  Not
> nice but ...

    The Alchemy code doesn't even try to use CP0 counter when CONFIG_PM=y if 
you look into arch/mips/au1000/common/time.c... or at least it didn't before 
Atsushi removed do_fast_pm_gettimeoffset().

>   Ralf

WBR, Sergei
