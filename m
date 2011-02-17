Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 12:44:33 +0100 (CET)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:43421 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491075Ab1BQLoa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 12:44:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id B4E022BE;
        Thu, 17 Feb 2011 12:44:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wL3PQOQCSVle; Thu, 17 Feb 2011 12:44:20 +0100 (CET)
Received: from [192.168.88.141] (unknown [213.172.107.226])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id CC7622BB;
        Thu, 17 Feb 2011 12:44:09 +0100 (CET)
Message-ID: <4D5D09FF.6010005@metafoo.de>
Date:   Thu, 17 Feb 2011 12:43:59 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
MIME-Version: 1.0
To:     Kumba <kumba@gentoo.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2]: Add support for Dallas/Maxim DS1685/1687 RTC
References: <4D5A65E3.1050707@gentoo.org> <4D5C5C66.6060205@metafoo.de> <4D5CF0EE.7000308@gentoo.org>
In-Reply-To: <4D5CF0EE.7000308@gentoo.org>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

On 02/17/2011 10:57 AM, Kumba wrote:
> On 02/16/2011 18:23, Lars-Peter Clausen wrote:
> 
>> Just pass the error up to rtc core.
> 
> How?  I looked at a few other drivers, but they, too, call dev_err() or
> dev_dbg().  Others don't appear to send any kind of string-based error
> value anywhere, they just return a -E* value.

That is what I meant. Pass the return value of rtc_valid_tm on, instead of
setting the time to 0 and pretend everything went fine.
You can still keep the dev_err though, no problem with that.

> 
> 
>> There is no need for these checks the core takes care that the values
>> are valid.
> 
> I've seen a few other RTC drivers implement these checks.  It's really
> hard to tell what drivers are, I guess, "right" and which ones are
> "wrong" in their approach when you've got already-accepted drivers in
> the tree doing things that I'm trying to fix in this driver.
> 
> That said, how is the core running these checks when I quickly turn
> around and write the values back to the RTC?
> 

What do you mean by 'quickly turning around and writing the values back'?
The rtc_time struct passed to the set_time callback is supposed to contain only
valid values.

> 
> 
>> There doesn't seem to be any code inside this file which is used
>> outside of
>> ds1685.c so it might be a good idea to merge the two files, or at
>> least move
>> this file to drivers/rtc/
> 
> I wasn't quite sure where headers typically went.  include/linux/rtc
> already existed, so I thought it was created at some point for holding
> .h files for RTC drivers.  IP32 will need to reference this header down
> the road anyways.  No harm if it has to look into drivers/rtc?

Well, if it is going to be shared it should probably remain somewhere in
include/, but everything thats not shared should be moved to rtc-ds1685.c like
for example ds1685_priv.


> 
> 
>> Just use BIT(x) instead of adding these defines
> 
> Noted, will research.
> 
> 
>> I think you should really use readb(pdata->regs + REG) instead of the
>> following
>> structs. Maybe add a helper function in the form of:
>> static uint8_t ds1685_read(struct ds1685_priv *ds1685, unsigned int
>> reg) {
>>     return readb(pdata->regs + REG);
>> }
>>
>> That should also help with the different paddings introduced in patch 2.
> 
> Working on this now.  Ran into some road blocks with gcc and inlining,
> but I worked around it.
> 
> 
>> All these macros that follow should really be functions.
> 
> Even the large ds1685_begin_data_access macro?  I can stick it into a
> inlined function, but I thought a macro was better.  Or am I trying to
> outfox the compiler by doing so?

I don't know what you are trying to do, but the current code is extremely
unreadable.
You have all those variables declared in your functions which are on first
sight not used, because they are only referenced from the macros. Furthermore
the invocation of the macro has not the syntax of a function call, although
semantically that is what it is.
And especially ds1685_rtc_begin_data_access is dangerous, because of the
'return 1', there is no indication when you read the code that a function could
magically exit upon invoking that macro.

> 
> If I do inline it, I need a fix for passing errors back to the RTC
> core.  I can't use dev_err() because it needs the device struct to work
> with, and I want to avoid passing too many arguments to an inlinable
> function.
Why? The compiled code will probably be exactly the same as now.

> 
> Thoughts?  The rest should be easy to convert into inlined functions.
> 
> 
> Thanks!,
> 
