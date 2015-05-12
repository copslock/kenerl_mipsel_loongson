Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 18:22:38 +0200 (CEST)
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:41419 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013148AbbELQWhJTgVN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 18:22:37 +0200
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-11v.sys.comcast.net with comcast
        id T4NJ1q00A5Clt1L014NYyM; Tue, 12 May 2015 16:22:32 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-po-17v.sys.comcast.net with comcast
        id T4NW1q00c42s2jH014NXq4; Tue, 12 May 2015 16:22:32 +0000
Message-ID: <555228C0.1050303@gentoo.org>
Date:   Tue, 12 May 2015 12:22:24 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP28: "Inconsistent ISA" messages during kernel build
References: <55516EF3.7010706@gentoo.org> <5551B894.9000204@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235321052BB1@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235321052BB1@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1431447752;
        bh=kvyos/IayyqsUifLKI1jKFEifWPlzeq/E+Z0/Nv6uKA=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=bzby93auwemn21SAthT2CWBGJStNv5AStZXTGOjOmbdbOk9KP0FW2pQX/FH17O7oL
         xp7DIR+NHD6Olk3ztKiH2OXuM7KYIYtPOwWpyXuuqDaxUfXeulYoPxtx3R/X5PVQ9R
         HZBFTkUc5rlIk/yk5iE5Kde0dhk4y5Cf0KwHGnvRFtYQAoXGV/L4Wj3Ized9LUaUUc
         hj8z3QqUwIevk03Kub/SQdGb2X6FCWCXzXEcCn56MW+uWw9ZMHIoh8q8QFl0Et4Xtb
         xSq+VU4JpNUVOx7zAe3a651BWEdKqmPzCeMU0oBcZZxkWSR05JpTdd8M2RaVK/twtc
         li2Zxq+0SnI3g==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47346
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

On 05/12/2015 05:00, Matthew Fortune wrote:
> Markos Chandras <Markos.Chandras@imgtec.com> writes:
>> On 05/12/2015 04:09 AM, Joshua Kinard wrote:
>>>
>>> Has anyone tried to build an IP28 kernel lately?  I've been getting
>>> quite a few warnings out of the linker regarding e_flags and the new
>> .MIPS.abiflags stuff.
>>>  Not seen it on the other SGI platforms, so I am assuming this has
>>> something to do with what flags are passed to the compiler/linker.
>>>
>>> mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent
>>> ISA between e_flags and .MIPS.abiflags
>>> mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent
>>> ISA extensions between e_flags and .MIPS.abiflags
>>>
>>> Seeing this on a build of 4.0.2 based off of a 20150418 checkout from
>> git.
>>>
>>> --J
>>>
>> Hi,
>>
>> I presume you are using binutils >= 2.25? I have seen this problem in my
>> local build tests as well and I discussed this with Matthew (now on CC).
>> It seems it's an 'innocent' warning added to binutils 2.25 but I am not
>> sure if this is now fixed or not. Matthew might be able to provide more
>> information.
> 
> I don't really know what an IP28 kernel is. What is the -march for this?
> There is an issue with -march=xlp as the XLP is marked as an XLR in the
> e_flags which is a mips64 but the xlp is a mips64r2 which is correctly
> annotated as such in the .MIPS.abiflags. I haven't quite figured out what
> to do about this yet.

It's one of the SGI platforms.  Specifically, the Indigo2 Impact R10000.
Here's a short list supported by Linux:

IP22: Indy, Indigo2 (R4x00)
IP27: Origin 200/2000, Onyx2 (R10K/R12K/R14K)
IP28: Indigo2 Impact R10000 (R10K)
IP30: Octane (R10K/R12K/R14K) (not in mainline)
IP32: O2 (R5000, RM5200, RM7000) (R10K/R12K not supported)

Valid -march values for these are:

IP22 (Indy): mips3, mips4, r4000, r4400, r4600, r5000
IP22 (Indigo2): mips3, r4000, r4400, r4600
IP27 to IP30: mips4, r10000, r12000, r14000
IP32: mips4, r5000, rm5200, rm7000


The IPxx number basically indicates the hardware platform.  There's also a
"software" IPxx number for some platforms to indicate minor variations of the
hardware.  E.g., hardware IP22 refers to both Indigo2 and Indy, but Indy is
"software" IP24.  An IP27 Origin 2000/Onyx2 with R12K/R14K node boards is
"software" IP31.  Origin 3x0/3000 is "software" IP35, Fuel is IP45, and Tezro
is IP53, though collectively, all three have a hardware of IP35.  Yes, SGI was
weird.

The Indigo2 was the odd duck of the group.  It has three hardware IPxx
variants, and I guess the "software" IPxx is the same for each.  The R4x00 CPU
is IP22, the rare R8000 is IP26, and the R10000 is IP28.  It's also a
non-coherent machine, which means the R10000's speculative execution feature
comes into play and you're lucky to keep an IP28 kernel running for more than a
few hours if you actually use it for anything.  IP32 (the O2) is also a
non-coherent platform and supports the R10K/R12K CPUs, but little effort has
been made to run Linux reliably on those.

As the GCC/MIPS maintainer, if you've ever wondered what the
-mr10k-cache-barrier switch was used for, it's specifically for building
kernels on IP28 (and maybe IP32) systems running the R10000 CPU.  Check out the
section in the R10000 manual on "Side effects of speculative execution" if you
ever get bored and gasp in wonder at SGI's insanity...

Btw, for anyone interested, there's a good condition R8000 I2 on eBay, item
#141663824264.  Such an odd CPU, that R8000...

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
