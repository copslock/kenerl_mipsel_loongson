Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jul 2004 08:34:20 +0100 (BST)
Received: from [IPv6:::ffff:213.189.19.80] ([IPv6:::ffff:213.189.19.80]:55558
	"EHLO mail.kpsws.com") by linux-mips.org with ESMTP
	id <S8225319AbUGJHeP>; Sat, 10 Jul 2004 08:34:15 +0100
Received: (qmail 46330 invoked by uid 89); 10 Jul 2004 07:33:57 -0000
Received: from unknown (HELO mail.kpsws.com) (127.0.0.1)
  by localhost with SMTP; 10 Jul 2004 07:33:57 -0000
Received: from 80.56.56.210
        (SquirrelMail authenticated user pulsar@kpsws.com)
        by mail.kpsws.com with HTTP;
        Sat, 10 Jul 2004 09:33:57 +0200 (CEST)
Message-ID: <1557.80.56.56.210.1089444837.squirrel@mail.kpsws.com>
In-Reply-To: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com>
Date: Sat, 10 Jul 2004 09:33:57 +0200 (CEST)
Subject: Re: Strange, strange occurence
From: "Niels Sterrenburg" <niels.sterrenburg@philips.com>
To: "S C" <theansweriz42@hotmail.com>
Cc: linux-mips@linux-mips.org
Reply-To: niels.sterrenburg@philips.com
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Return-Path: <niels.sterrenburg@philips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niels.sterrenburg@philips.com
Precedence: bulk
X-list: linux-mips

Hi Steve,

When you set a breakpoint with the ice and step through,
for each step the ICE set's a breakpoint on the next instruction:
e.g.:
- modifies next instruction in memory (via CPU !!!)
  with a breakpoint instruction,
- and update the cache so that the breakpoint instruction is really in
memory and that i-cache is invalid.
(or something like that)

So indead you have a cache problem which is explanable solved/disapeared
by steppig through with the ICE.

Maybe a stupid question from me but why flushing an icache ?:
r4k_flush_icache_range

regards,

Niels

> Well I'm hoping it isn't so strange to some of you folks and you'll be
> able
> to tell what's going on :)
>
> Here's my problem:
>
> Using MontaVista Linux 3.1 on a Toshiba RBTx4938 board. Using YAMON, when
> I
> download the kernel via the debug ethernet port it runs fine. If I
> download
> the kernel via the Tx4938 inbuilt ethernet controller, it crashes!
>
> Memory checksumming and a quick manual memory dump inspection reveals that
> the kernel download went perfectly ok, and the image is completely and
> correctly downloaded to RAM.
>
> The crash is occuring inside the function r4k_flush_icache_range().
>
> I tried 'flush -i' and 'flush -d' on YAMON after the download but before
> the
> 'go', but that didn't help. I also tried completely disabling caches and
> loading/running uncached, but it gave the same error.
>
> Now, the final twist! Using an ICE, I set a breakpoint at the
> r4k_flush_icache_range function. Then I loaded the kernel as usual, ran it
> with the ICE, stepped through a few instructions inside the
> r4k_flush_icache_range function and then did a 'cont'. The kernel now
> booted
> fine!
>
> If I don't set the breakpoint inside that function though, and just try to
> run with the ICE the same
> error (Inst fetch/Load error) occurs.
>
> I'm at a loss trying to figure out what's going on. I suspect it has
> something to do with caches perhaps (duh!), but have no clue what!
> Anybody
> out there face a similar kind of a situation before?
>
> Thanks in advance for any help offered.
>
> Regards,
> -Steve
>
> _________________________________________________________________
> MSN 9 Dial-up Internet Access helps fight spam and pop-ups – now 2 months
> FREE! http://join.msn.click-url.com/go/onm00200361ave/direct/01/
>
>
>
