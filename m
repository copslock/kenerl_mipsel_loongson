Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 18:40:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:19162 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20040205AbXJQRkN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 18:40:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HHeDPi011407;
	Wed, 17 Oct 2007 18:40:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HHeCxl011406;
	Wed, 17 Oct 2007 18:40:12 +0100
Date:	Wed, 17 Oct 2007 18:40:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: plat_timer_setup, mips_timer_ack, etc.
Message-ID: <20071017174012.GA11079@linux-mips.org>
References: <20071017.005211.108739735.anemo@mba.ocn.ne.jp> <20071016163610.GA25794@linux-mips.org> <20071017.020113.63743059.anemo@mba.ocn.ne.jp> <20071017162837.GA5491@linux-mips.org> <471639AC.8080301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471639AC.8080301@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 08:34:52PM +0400, Sergei Shtylyov wrote:

> >>$ git-grep mips_timer_ack arch/mips
> >>arch/mips/dec/time.c:   mips_timer_ack = dec_timer_ack;
> >>arch/mips/jmr3927/rbhma3100/setup.c:    mips_timer_ack = 
> >>jmr3927_timer_ack;
> 
>    TX3927 has three channel timer of which only channel 0 is used to 
> implement a clocksource -- however, clocksource code whould also need to be 
> changed since it's now jiffy-based and HRT doesn't tolerate this -- of 
> course, if anybody still cared about this boards
> 
> >>arch/mips/philips/pnx8550/common/time.c:        mips_timer_ack = 
> >>timer_ack;
> 
>    Here we have a case of a vendor abusing the count/compare register and 
> also adding 3 more of them. One pair can be used for clockevents, the other 
> for clocksource (its compare reg. being programmed to all ones).

Well, the TX3900 series is a bit of a frankenprocessor series.  Like take
32-bits from here, a limb from the R3000 and TLB from that other processor
and at the end shock it all well - at TTL levels that is ;-)  So it's not
quite obvious what to expect from that beast.

My question was mostly about the jmr3927 build failing with an undefined
reference to MIPS_CPU_IRQ_BASE.  For most other systems failing with the
same issue it made sense to glue that by converting the platform to
irq_cpu.  But if no device including the cp0 compare interrupt is directly
wired to the cp0 interrupt controller then enabling that doesn't make too
much sense.  So I guess jmr3927 and a hand full of other systems want a
different fix.

  Ralf
