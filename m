Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 15:34:43 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:54041 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022471AbXFOOel (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2007 15:34:41 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3EF3F3ECA; Fri, 15 Jun 2007 07:34:07 -0700 (PDT)
Message-ID: <4672A3C8.70308@ru.mvista.com>
Date:	Fri, 15 Jun 2007 18:35:52 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
References: <11818164011355-git-send-email-fbuihuu@gmail.com>  <11818164023940-git-send-email-fbuihuu@gmail.com>  <20070614111748.GA8223@alpha.franken.de>  <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>  <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>  <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>  <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl> <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com> <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>>I don't see how you can have hrtimer support if you choose a periodic
>>timer...

>  Well, periodic timers do seem to work somehow for everybody else with no 
> hassle whatsoever,

    Except the purely periodic timers can't serve as HRT (unless one cheats 
and also declares them as one-shot).

> starting from the DEC code I referred to and including 
> other platforms, like the i386, which uses the 8254 for the timer 
> interrupt and as a HPT, by default, the very same counter or the TSC in 

    What do you mean by HPT -- clocksource?

> the CPU if available or, I think, some chipset timer, because some 

    Weel there was ACPI timer (32-bit free running counter, IIRC) -- but 
somehow I was unable to find the code for it in the current source. And there 
is HPET which is indeed preferred over broken TSC.

> brilliant soul decided to break the TSC at one point.

>  Note that the 8254 can be reprogrammed into a one-shot mode, but somehow 
> nobody does it. ;-)

    Well, hrtimers can do it but the LAPIC timer is preferred over 8254.

>  Similarly for the local APIC timer that is used for 
> scheduling on i386 systems (if available).

    LAPIC timer is also used for HRT, i.e. in one-shot mode (simply because 
it's the best choice for such purpose -- HRTs are per-CPU).

>>>mips_timer_state appropriately, i.e. to flip at the HZ rate (it may be
>>>based on one of the south bridge choices mentioned above or some
>>>free-running counter for example), but people seem to prefer to write
>>>their own code for some reason. ;-)

>>Do you have any examples in mind which rewrite their own calibration
>>code ? I'm too lazy to search into all board code.

>  See arch/mips/mips-boards/generic/time.c for example.  Or any platform 
> that uses the CP0 timer interrupt and has a configurable CPU frequency -- 
> you can find them easily by looking for ones that calculate 
> mips_hpt_frequency rather than set it to a fixed value.

    Alchemy for one.

>   Maciej

WBR, Sergei
