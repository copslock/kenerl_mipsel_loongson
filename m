Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 03:29:17 +0100 (CET)
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:42492 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009239AbcA1C3NWLISE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 03:29:13 +0100
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-06v.sys.comcast.net with comcast
        id BEUU1s0012VvR6D01EV4XV; Thu, 28 Jan 2016 02:29:04 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id BEV11s00H0w5D3801EV2A8; Thu, 28 Jan 2016 02:29:04 +0000
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
To:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        macro@linux-mips.org
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
 <20150605131046.GD26432@linux-mips.org>
Cc:     linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, Steven.Hill@imgtec.com,
        alexander.h.duyck@redhat.com, davem@davemloft.net
From:   Joshua Kinard <kumba@gentoo.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <56A97CE1.5090004@gentoo.org>
Date:   Wed, 27 Jan 2016 21:28:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101
 Thunderbird/42.0
MIME-Version: 1.0
In-Reply-To: <20150605131046.GD26432@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1453948144;
        bh=l5ZLMjvbCMwKKf9CuT9AXZQNzJflO8rdZ0Rs15k7GFs=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=PBJ7sFFnyOP3Hlo3P5fMjKq1n9NBqDigzzqqSGFBopguerG4E1aKkRSWFsZAvRcH3
         22uh6nY3wgv0TxuCEqWOgitD0NB+mS4xbDdTxe/T9Sv93G2ECxNr1/tl2BYFvmQHPc
         7KSvAhGNvfBSjpuEgmRrOXeknptNbupKFYDk6iL7cs/T11o+pBHhX+6bHukNPTLfL0
         pVRQjKtZw3wzdVR8Bm3Bsk2d414L0HplTm7tU5YCvQb1Aug6AQhA+lkcVPTjrJXiLr
         5p2z00Zjq9PiOpN5fmVPaGGMmT8Q8LrQk6cnRryIcJtnG3Pa7b0v9ZkOO9PxY4VV5n
         h0r3NCACgvUYA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51504
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

On 06/05/2015 09:10, Ralf Baechle wrote:
> On Mon, Jun 01, 2015 at 05:09:34PM -0700, Leonid Yegoshin wrote:
> 
> Leonid,
> 
> to me the biggest technical problem with this patch is that the new Kconfig
> option is user visible.  This is the kind of deeply technical options
> which exceeds the technical knowledge of most users, so it should probably
> be driven by a select.
> 
> We probably also want to enquire how old CPUs from before the invention
> of the stype field are behaving.  If those as I hope for all treat an
> stype != 0 as stype 0 we could simply drop the option.  But we might
> simply be out of luck - dunno.
> 
> Maciej,
> 
> do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
> test this?  I think we don't need to test that SYNC actually works as
> intended but the simpler test that SYNC <stype != 0> is not causing a
> illegal instruction exception is sufficient, that is if something like
> 
> int main(int argc, charg *argv[])
> {
> 	asm("	.set	mips2		\n"
> 	"	sync	0x10		\n"
> 	"	sync	0x13		\n"
> 	"	sync	0x04		\n"
> 	"	.set	mips 0		\n");
> 
> 	return 0;
> }
> 
> doesn't crash we should be ok.
> 
> The kernel's SYNC emulation should already be ok.  We ignore the stype
> field entirely and for a uniprocessor R2000/R3000 that should be just
> the right thing.
> 
>   Ralf

I tried just compiling this on my SGI O2, which has an RM7000 CPU, and it is
refusing to even compile (after fixing typos):

# gcc -O2 -pipe sync_test.c -o sync_test
{standard input}: Assembler messages:
{standard input}:19: Error: invalid operands `sync 0x10'
{standard input}:20: Error: invalid operands `sync 0x13'
{standard input}:21: Error: invalid operands `sync 0x04'

So a bit of searching landed me here:
http://stackoverflow.com/questions/3599564/gnu-assembler-for-mips-how-to-emit-sync-instructions

And I recoded the sync insns like this:

int main(int argc, char *argv[])
{
	__asm__ volatile (      \
	"	.set    mips2				\n"
	"	.word (0x0000000f | (0x10 << 6))	\n"
	"	.word (0x0000000f | (0x14 << 6))	\n"
	"	.word (0x0000000f | (0x04 << 6))	\n"
	"	.set    mips0				\n"
	);

	return 0;
}

And the program compiles successfully and executes with no noticeable oddities
or errors.  Nothing in dmesg, no crashes, booms, or disappearance of small
kittens.  I did a quick disassembly to make sure all three got emitted:

004005e0 <main>:
  4005e0:       27bdfff8        addiu   sp,sp,-8
  4005e4:       afbe0004        sw      s8,4(sp)
  4005e8:       03a0f021        move    s8,sp
  4005ec:       afc40008        sw      a0,8(s8)
  4005f0:       afc5000c        sw      a1,12(s8)
> 4005f4:       0000040f        sync.p
> 4005f8:       0000050f        0x50f
> 4005fc:       0000010f        0x10f
  400600:       00001021        move    v0,zero


Same effect on my Octane (IP30) w/ an R14000 CPU.  Tested inside a uclibc-based
chroot, but no change.  Executes successfully silently.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
