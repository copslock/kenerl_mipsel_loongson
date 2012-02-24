Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 09:40:58 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:48334 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903648Ab2BXIkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Feb 2012 09:40:52 +0100
Message-ID: <4F474D02.1040306@openwrt.org>
Date:   Fri, 24 Feb 2012 09:40:34 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V2 11/14] NET: MIPS: lantiq: convert etop driver to clkdev
 api
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>      <1330012993-13510-11-git-send-email-blogic@openwrt.org> <20120224.032812.10813781440356110.davem@davemloft.net>
In-Reply-To: <20120224.032812.10813781440356110.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 24/02/12 09:28, David Miller wrote:
> From: John Crispin <blogic@openwrt.org>
> Date: Thu, 23 Feb 2012 17:03:10 +0100
>
>> Update from old pmu_{dis,en}able() to ckldev api.
>>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
> Come on guys, don't do crap like this.
>
> When you have a 14 patch series, and I only see one or two of them
> I have no idea what in the world you want me to do with these patches.
>
> Are they dependent upon the previous patches that weren't sent to me?
>
> Are they not and I can just apply them as-is?
>
> Could I apply them as-is, but you want them to go via the MIPS tree
> for some reason and just want my ACK?
>
> Nobody knows because you didn't bother to say one way or another
> and that is extremely irritating because as a result I have to
> ask you all of these stupid questions and write this rediculious
> email.
>
> I'm just ignoring every single one of these MIPS patches, sorry.

Hi,

you are right, totally stupid of me to waste other peoples time like this.

I forgot the following things
* mention that i would welcome a ack'ed by from you
* mention that these patches should go via MIPS with the other patches
in the series
* I should have put in the commit messages, that you were CC'ed on, what
the rest of the series does
* on the last "fix locking issues" patch I also forgot to CC Ralf and MIPS


One question if I may ask
* do you want to be CC'ed for a full series even if only 1 patch relates
to netdev or should I simply think more about the commit message so it
is apparent what i expect ?

again, sorry for wasting your time with stupidity ... I will clean up
the mess I made during today ...

hope you accept my apology,
John
