Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 05:17:58 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:38059 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006944AbbEXDRyIzOam (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 05:17:54 +0200
Received: from resomta-ch2-13v.sys.comcast.net ([69.252.207.109])
        by resqmta-ch2-04v.sys.comcast.net with comcast
        id XfHe1q0042N9P4d01fHopk; Sun, 24 May 2015 03:17:48 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-13v.sys.comcast.net with comcast
        id XfHn1q00542s2jH01fHnrk; Sun, 24 May 2015 03:17:48 +0000
Message-ID: <556142C5.7090206@gentoo.org>
Date:   Sat, 23 May 2015 23:17:25 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP30: SMP, Almost there?
References: <55597B21.4010704@gentoo.org>
In-Reply-To: <55597B21.4010704@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432437468;
        bh=MjgjJQ2iSU91a8RQSLMB6BTE7HqBJ65DngaZopSTLSM=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=d4Q/cs2W/pt59tKRCRYyXWxQh1HnUYuj4Fue4K3c0o7+/R6OpzSZMeNGvZRhe2VOs
         ZL3iLIeWH/5njRzdjDvqJU0v6gT9aAIW0Vi2nMzfkqPFBX+JA1q5JhUTelfj8oDWP7
         tmb3eq5kassvHLW45IZBngVFfb/2CxYeBGDvuHp/jPYidXWyjO8O3Q/b7UqaYDJI3k
         MhpwvuZ/q+sejzbaL3B4VSFaMedgwFSSImfcl4zH/qoSmLhBB3meUvbOV/nAA/eTZZ
         eC2BuQKncG50onqx2kOzQoDIkFLqUfzRqlcG+EfKxONMtDQzc9EzvTSes/r7RUWzuj
         guXXcerJ/4rEg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47596
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

On 05/18/2015 01:39, Joshua Kinard wrote:
> So I've gotten the second CPU in Octane to "tick" again...somehow.  I am
> certain someone's cat went missing in the process...

So, yeah, the problem appears to be specific to the R14000 CPU module.  I
swapped in an R12K dual CPU module, and after a little bit of tinkering to
revert a few hacks and clean up the code, it boots into SMP, mounts the
userland, and has successfully sync'ed a Gentoo Portage tree w/o annihilating
the XFS filesystem or the MD RAID5 array.  Even compiled a few C files.

# cat /proc/interrupts
           CPU0       CPU1
 14:          0          0     HEART  powerbtn
 15:          0          0     HEART  acfail
 16:          0      44887     HEART  qla1280
 17:          0      16904     HEART  qla1280
 18:       1853          0     HEART  ioc3-eth
 20:        243          0     HEART  ioc3-io
 46:     348850          0     HEART  cpu0-ipi
 47:          0     315948     HEART  cpu1-ipi
 50:       1268          0     HEART  heart_timer
 71:     118453     195177       CPU  timer

# cat /proc/cpuinfo
system type             : SGI Octane
machine                 : Unknown
processor               : 0
cpu model               : R12000 V3.5  FPU V0.0
BogoMIPS                : 600.47
byteorder               : big endian
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : no
hardware watchpoint     : yes, count: 0, address/irw mask: []
isa                     : mips2 mips3 mips4
ASEs implemented        :
shadow register sets    : 1
kscratch registers      : 0
package                 : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

processor               : 1
cpu model               : R12000 V3.5  FPU V0.0
BogoMIPS                : 600.47
byteorder               : big endian
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : no
hardware watchpoint     : yes, count: 0, address/irw mask: []
isa                     : mips2 mips3 mips4
ASEs implemented        :
shadow register sets    : 1
kscratch registers      : 0
package                 : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

I even got the IRQs to be fanned out across both CPUs.  Well, primarily the
qla1280 drivers.  They randomly hop between both CPUs, but no ill effects so far.

But if I boot that *same* working kernel on an R14000 dual module, I get handed
an IBE as soon as the userland mounts.  The only documented differences that I
can find on the R14000 is that it supports DDR memory, being able to do memory
operations on the rising edge and falling edge of each clock.  Not sure if that
matters to the kernel at all, but I know of nothing else that describes the
R14K's internals, such as if there's some new bit in CP0 config,
branch-diagnostic, status, etc, that might explain why these IBE's are happening.

Guess I need to hunt down my old dual R10K module next and verify that works
fine...

Also, is there a way to hardcode the cca=5 setting for IP30?  Maybe it needs to
be a hidden Kconfig item?.  I tried setting cpu->writecombine in cpu-probe.c,
but no dice there.  If I boot an SMP kernel on dual R12K's w/o cca=5, I'll get
one or two pretty-specific oopses.  The one I did grab complains about bad
spinlock magic in the core tty driver somewhere.  I can transcribe that oops
later on if interested.


--J
