Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 11:59:27 +0100 (CET)
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:51943 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013989AbaKSK7ZSTetm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 11:59:25 +0100
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-07v.sys.comcast.net with comcast
        id HNzB1p0015BUCh401NzDTL; Wed, 19 Nov 2014 10:59:13 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-16v.sys.comcast.net with comcast
        id HNzC1p0020gJalY01NzCsd; Wed, 19 Nov 2014 10:59:13 +0000
Message-ID: <546C77F6.4030101@gentoo.org>
Date:   Wed, 19 Nov 2014 05:59:02 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP Help
References: <5457187D.6030708@gentoo.org> <54607499.2070806@gentoo.org> <546B11C0.90805@gentoo.org> <alpine.LFD.2.11.1411180946130.4773@eddie.linux-mips.org> <546B3D9C.6000104@gentoo.org> <alpine.LFD.2.11.1411181255420.4773@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1411181255420.4773@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1416394753;
        bh=ipI+kHvlrMHAlkQRLj4+mH3smh3rGeUs9dUse+v606E=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=pcfEag11S3dPHQ70l7FCpYgQMIugemF/trRh0WveFm2Hvjdvjp3b7V1TAKr0I0U76
         gzGQeTHrcr1LD/mfhh6rlxkL4VU91GJ09V10MaI5tEGZmrwDzOkBg/OvUlFeBhhxvV
         SxazoNnJTwX+feLPH6B13enGDzemqUsmJgYFQVk1EV24Iy3Bbgiu6Mxt0tLE6k+8as
         9d71Je3Kxg3dWTQXH/jQXac/nlQiGdx+M/2UfL8gQmyOy24zlSyzqzf+7kpSll99Cu
         MYfY1bd10To/MXRhOL2Yb03G5i66GCrf5H2xrVMgoqN+lM9AIj1+MtUTKtA4c1ON4y
         j3j6/V4wqdTkg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44287
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

On 11/18/2014 08:10, Maciej W. Rozycki wrote:
> On Tue, 18 Nov 2014, Joshua Kinard wrote:
> 
[...]
>> This is an o32 userland.  So that means, given 64-bit wide registers, o32 is
>> going to stuff two 32-bit quantities into them?  I have an n32 chroot on a
>> different partition, but I haven't tried it w/ CONFIG_SMP yet.
> 
>  No, user registers have to be treated as 32-bit, that is sign-extended 
> from bit #31 (bits 63:32 are a copy of bit #31).  Using 32-bit operations 
> only guarantees that, e.g. when you load a register from its stack slot 
> using the 32-bit LW instruction, then on a 64-bit processor it will get 
> sign-extended in the hardware register from bit #31 through to bit #63.  

I've been aware of the sign-extending bit for some time.  Hence the
0xffffffffxxxxxxxx-style addresses.  Regardless if the stack contains
77abcdef77f00ba7, an LW insn loading that value will actually store
ffffffff77f00ba7 into the hardware register, right?

It just seemed odd that from the 64-bit stack addresses, it looked like there
were two 32-bit virtual addresses (77abcdef and 77f00ba7).  I wasn't sure if
that was normal behavior or not for 64-bit Linux/MIPS.  Or a symptom of
whatever bug is present in the IP30 code I've yet to find.


>  Of course an o32 bit program does not see it, it sees the environment as 
> it would on a 32-bit processor as it is supposed to run the same on a true 
> 32-bit processor.  Well, strictly speaking this is not completely true on 
> Linux, for that to be the case the UX bit you see set in the Status 
> register dumped above would have to be cleared, but this is a historical 
> artefact and nobody has had the incentive to clean this up yet (in a 
> reference environment you want UX clear for o32, UX set for n64 and PX set 
> for n32 where available, otherwise UX set).  Clearing the UX bit disables 
> all the 64-bit instructions in the user mode making a user program unable 
> to see or modify the upper 32 bits of any general register (they're still 
> sign-extended automatically).

A lot of the binaries on the Octane's filesystem are compiled w/ MIPS-IV.
Under o32, I know that doesn't allow for use of 64bit instructions, but I do
believe that o32 can still make use of newer instructions that were added in
the MIPS-III or MIPS-IV ISA (iirc, conditional move was one of those).

The problem seems to be, though, that there's some kind of subtle memory
corruption happening when I compile an IP30 kernel w/ CONFIG_SMP.  Without
CONFIG_SMP, it runs fine.  I was focusing on the spinlocks because I know that
without CONFIG_SMP, they compile away into nothing, but with CONFIG_SMP, even
on a uniprocessor machine, they'll convert to instructions and can still
highlight locking problems in the code.

It's just the question of where in the code is the corruption happening?  I may
not fully comprehend all the low-level bit-frobbing that goes on, but once I
get an idea of the code region causing it, I can usually figure something out.
 Problem is, like IP27, the serial ports are behind the IOC3 device, and the
old IOC3/kgdb interface code was removed in ~2008 (commit 8d60a903) and the new
kgdb interface code doesn't work w/ IOC3 (NULL pointer deref).  I've got a
rough idea on how to talk to the UART chip behind the IOC3 to make KGDB work
again, just not a good enough understanding of the serial-8250 core to know how
to add it.  And then I have to hope I don't end up debugging the code added to
debug the code...

So, for now, my post-analysis crash-tool is a Canon DSLR camera mounted on a
tripod to capture whatever debug data fits onto a single 1024x768 screen.


>  Please do yourself a favour and read a good MIPS architecture book; 
> Dominic Sweetman's "See MIPS Run" would be my recommendation and its 
> second edition has some focus on Linux too that might help.  Without a 
> good understanding of the architecture you'll be having a very, very hard 
> time debugging such low-level issues.

I've had a copy of the 2nd edition for a few years now.  It's an excellent
general reference, though I admit I've skipped over the TLB chapter a few
times.  Hopefully a third edition comes out at some point and has more in-depth
coverage of Linux running on MIPS, in addition to the general MIPS overview.

I've also got Robert Love's Linux Kernel Development, 3rd edition, but that's
2010 and is from the 2.6.x era.  I don't know of anything newer for the 3.x era.

--J
