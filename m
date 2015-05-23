Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 00:58:19 +0200 (CEST)
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:50883 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006858AbbEWW6QSi5vA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 00:58:16 +0200
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-05v.sys.comcast.net with comcast
        id Xay81q0012S2Q5R01ayCn6; Sat, 23 May 2015 22:58:12 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-16v.sys.comcast.net with comcast
        id XayB1q00S42s2jH01ayCgL; Sat, 23 May 2015 22:58:12 +0000
Message-ID: <556105EE.9060802@gentoo.org>
Date:   Sat, 23 May 2015 18:57:50 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
References: <55597B21.4010704@gentoo.org> <5559D483.905@gentoo.org> <555C1A53.9010803@gentoo.org> <555D7469.7090806@gentoo.org> <20150522163826.GB6467@linux-mips.org>
In-Reply-To: <20150522163826.GB6467@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432421892;
        bh=D3QUlL171y00WTbfHs0hot6E4epMrrv2pv9k1JfGhYg=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=GiNjq4JsIdVByxbPwxjvJvOrIt9rtK4BSkDcbfoBTLeOE3k0QbBWz3ZauwKKncr2k
         6NYWn+tFmIQ5Hx2YTfti/IbI40Lnwkujn7Xz2YAMuDFAAWA3bqp1XrCZRB4lW54fKc
         xTFICJkz1+uv9FL8WFLUBuhxhbbDzsjhlkAxCTvT2UXfy3rkt33C3w4MvZtGT2+IXv
         F25IckODtrZzIevN0dp0ZI4FLaZ9Nn3uUQ1aytS+Y79MHttdn97Jp8H8qbd7bSkaOF
         M27UjOOVVQwiwAfFlQrTOPjENbjT3hsJ6XdPw7ZmIPV4QUva0nlvv3O2L9kotoeLif
         RLU7RqfCb0fuw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/22/2015 12:38, Ralf Baechle wrote:
> On Thu, May 21, 2015 at 02:00:09AM -0400, Joshua Kinard wrote:
> 
>> Where I am lost is, though, why would I get an IBE on a 'beqz' instruction?
>> It's a valid instruction from MIPS-I ('beqz' is just 'beq' w/ $0 as rt).  the
>> R10K Manual states this:
>>
>> """
>> A Bus Error exception occurs when a processor block read, upgrade, or
>> double/single/partial-word read request receives an external ERR completion
>> response, or a processor double/single/partial-word read request receives an
>> external ACK completion response where the associated external
>> double/single/partial-word data response contains an uncorrectable error. This
>> exception is not maskable.
>> """
>>
>> My guess is there's still something not kosher with icache flushing somewhere.
>>  I can reboot this kernel multiple times and not always get the same IBE.  Most
> 
> Not or improperly flush the I-cache will result in stale instructions
> getting executed.  An IBE error otoh is the result of a bus error being
> signalled for the CPU's attempt to load instructions from memory.  With
> the exception of a few special cases I-cache flushing doesn't happen
> when eecuting kernel code, but only for userland and it's also somewhat
> unlikely for improper I-cache flushing to result in an IBE error.

Well, the IBE's are happening in userland, loading init, on CPU1.  I hacked
together a basic bus error handler from IP27's and using that, instead of
seeing four IBE's in a row, I can get CPU1 to stall and dump whatever debug
data I want.  Downside is, I've only got the Odyssey Early console available,
so I have to take pictures of the debug text or oops data, then manually type
it into a text file.

Further experimenting with a dual R12K module suggests that whatever the
problem is, it's got something to do with the R14K.  I'm having better success
with the R12K dual module thus far.  More on that later...


> A huge problem tracking down the cause of a bus error is that they're
> getting signalled by an external agent that is they are not generated by
> the CPU itself and there may be a significant delay until the CPU
> actually takes the exception.  In my experience the EPC is practically
> always worthless in tracking down the cause of the bus error.  Details
> depend on circumstances, as usual.

I thought that agent might be HEART, but the HEART_CAUSE register reads
0x00000000 when an IBE happens, which means no issues from its end.

How does one probe the SysAD bus?  The R10K documentation has some breakdown of
the bit format of SysAD messages.  Is there a memory address somewhere that can
be used to read data off the bus or even talk to it to get error information
(like, does it have a CAUSE register or something)?

Otherwise, figuring out what's wrong with the R14K is going to take a long time...

--J
