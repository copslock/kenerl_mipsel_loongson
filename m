Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2007 14:06:05 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:17597 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28645331AbXABOF7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2007 14:05:59 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1H1kH5-0002yf-Al
	for linux-mips@linux-mips.org; Tue, 02 Jan 2007 06:05:55 -0800
Message-ID: <8124491.post@talk.nabble.com>
Date:	Tue, 2 Jan 2007 06:05:55 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
In-Reply-To: <acd2a5930612280820l43639382x1f573386f2752d18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <20061228171405.b1e3eed8.vitalywool@gmail.com> <20061229.011621.05599370.anemo@mba.ocn.ne.jp> <acd2a5930612280820l43639382x1f573386f2752d18@mail.gmail.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips



Vitaly Wool-4 wrote:
> 
> On 12/28/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>>
>> On Thu, 28 Dec 2006 17:14:05 +0300, Vitaly Wool <vitalywool@gmail.com>
>> wrote:
>> > --- linux-mips.git.orig/arch/mips/philips/pnx8550/common/time.c
>> > +++ linux-mips.git/arch/mips/philips/pnx8550/common/time.c
>> > @@ -29,11 +29,22 @@
>> >  #include <asm/hardirq.h>
>> >  #include <asm/div64.h>
>> >  #include <asm/debug.h>
>> > +#include <asm/time.h>
>>
>> As I said before, asm/time.h is already included just before there.
>> Why double inclusion?
>>
>>
> Oh shoot, thanks, this hunk is bogus.
> 
> Vitaly
> 
> 
I have now tried this new patch and am still not having much success and am
still not understanding the patch very well.
First things first, if I do use the line 
clocksource_mips.read = hpt_read; 
It does not compile as this symbol is not in a header file and is a static
struct in arch/mips/kernel/time.c
I can make it not static and extern it from pnx8550/common/time.c is this
how I should do it?

Secondly I look at the logic for the arch/mips/kernel/time.c in the
time_init code
I think we want to follow the else branch (/* We know counter frequency.  Or
we can get it.  */)
In this case it then checks to see if mips_hpt_read is undefined which in
our case it is.
It then defines the mips_hpt_read to be c0_hpt_read

It then also overrides mips_timer_ack to be c0_timer_ack which i think is
wrong as we have already overridden this function in
arch/mips/philips/pnx8550/common/time.c.  (Is this behaviour correct?)

I used the patch and ran the kernel,  It does not work very well, Long Hang
after 
Memory: ......
Very slow behaviour after this.

I tried the following:
else {
    /* We know counter frequency.  Or we can get it.  */
    if (!mips_hpt_read) 
    {
        /* No external high precision timer -- use R4k.  */
	mips_hpt_read = c0_hpt_read;

	if (!mips_timer_state) {
            /* No external timer interrupt -- use R4k.  */
	    mips_hpt_init = c0_hpt_timer_init;
+	    if(!mips_timer_ack)
                mips_timer_ack = c0_timer_ack;
	}
}
This means it uses the mips_timer_ack function defined in
arch/mips/philips/pnx8550/common/time.c 
(mips_timer_ack = timer_ack;)

If I use this patch then the kernel still hangs for a long time at 
Memory: ...... (of the order of 12-14 secs)
It then seems to run at full speed and to a prompt.

In summary:
How do I override clocksource_mips.read properly?
Should mips_timer_ack = c0_timer_ack; be being done even though the board
specific mips_timer_ack = timer_ack; has been done?
Finally there is still the long hang which still looks top be related to
waiting for counter to cycle could ?

Any help with all three would be appreciated but 1 and 2 appear to be more
generic questions whilst 3 is PNX8550 specific (any help  would be
appreciated there as well).

Cheers
Dan




-- 
View this message in context: http://www.nabble.com/-PATCH--respin--pnx8550%3A-fix-system-timer-support-tf2890537.html#a8124491
Sent from the linux-mips main mailing list archive at Nabble.com.
