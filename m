Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 15:46:02 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:60730 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23995079AbdHDNpzSY8WP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Aug 2017 15:45:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id 703B23F5C1;
        Fri,  4 Aug 2017 15:45:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lJiYevXI5tAX; Fri,  4 Aug 2017 15:45:45 +0200 (CEST)
Received: from [10.0.1.7] (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id 4EA473F59B;
        Fri,  4 Aug 2017 15:45:41 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Update PS2 R5900 to kernel 4.x?
From:   Fredrik Noring <noring@nocrew.org>
In-Reply-To: <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
Date:   Fri, 4 Aug 2017 15:45:41 +0200
Cc:     linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2CA3040B-8EB9-456C-A4DE-BFE0D097971C@nocrew.org>
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
 <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
 <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
To:     Joshua Kinard <kumba@gentoo.org>
X-Mailer: Apple Mail (2.3259)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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


> 4 aug. 2017 kl. 04:04 skrev Joshua Kinard <kumba@gentoo.org>:
> 
> Am not knowledgeable here, unfortunately.  If you have a Oops report and can
> trace through a debugger and look at the underlying asm, that might highlight
> something.  I've not had a lot of luck doing that on my SGI systems though.

Applying v3.9-rc1 commit 64b3122d gives this memory fault crash:

    [...]
    rtc-ps2 rtc-ps2: hctosys: unable to read the hardware clock
    RAMDISK: gzip image found at block 0
    VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
    devtmpfs: mounted
    Freeing unused kernel memory: 248k freed
    Memory fault
    Memory fault
    Memory fault
    [repeats ~30 times]
    Memory fault
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000ff00

The parent commit boots to Busybox without (apparent) problems. Commit 64b3122d
is small and I've also tried to apply the child commit 50150d2bb9 "mips: switch
to generic sys_fork() and sys_clone()" which is related (perhaps required), but
the crash persists.

A question is whether there is a problem with commit 64b3122d itself, e.g. the
handling of MIPS register 29, perhaps in the patched R5900 assembly, or
whether the commit depends on some previous change that hasn't been updated in
the R5900 patch, e.g. the system calls in arch/mips/kernel/scall32-n32.S which
(originally) seems to be a modified version of arch/mips/kernel/scall64-n32.S.
Several previous changes by Al Viro switch to generic system calls:

    git log --author=viro v3.8..v3.9 arch/mips/kernel

I'm not quite sure how these changes would apply to the R5900 patch. That's
where I'm stuck at the moment. I'm trying to figure out what is causing the
memory fault. Are there any kernel parameters that would be helpful for
debugging this?

> Could be doable.  I forget, was PS2 big -endian or little-endian?  I primarily
> work with big-endian these days due to my SGI systems.  I've got recent stage
> builds at several different ABI/ISA combos and even a working netboot
> filesystem.  Haven't had time to get kernels rolled yet (IP27 always spoils the
> fun).

Great! R5900 hardware is endian configurable according to the Toshiba manual

    http://www.lukasz.dk/files/tx79architecture.pdf

and the PS2 R5900 patch is little-endian which is probably simplest to start
with for interoperability with its BIOS etc.

> I have one of the PS2 debug machines in a closet somewhere.  Basically a normal
> PS2 with 4x RAM and says "TEST" on the side in the PS2 font.  Can't remember if
> it still works or not.

Why not give it a try? :) Linux on the PS2 works without a dvd. A simple setup
is a PS2 memory card (for the boot loader) and a usb memory (for the kernel and
a root file system). Later PS2 models have built-in ethernet.

> And it's insanely way out of date for modern Gentoo (by ~14 years), but I keep
> an archive of the original attempt to run Gentoo on a PS2 from ~2003 here:
> http://dev.gentoo.org/~kumba/mips/ps2/gentoo-ps2/
> 
> The "ps2dev.diff.bz2" patch might be of interest, as it has the changes for the
> toolchain in it.

Thanks!

Fredrik
From kumba@gentoo.org Fri Aug  4 16:13:58 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 16:14:04 +0200 (CEST)
Received: from resqmta-ch2-06v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:38]:58202
        "EHLO resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995083AbdHDON6EngAP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 16:13:58 +0200
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-06v.sys.comcast.net with ESMTP
        id ddMIdwgiAbXC4ddMRdzcQ7; Fri, 04 Aug 2017 14:13:55 +0000
Received: from [192.168.1.13] ([73.201.189.102])
        by resomta-ch2-20v.sys.comcast.net with SMTP
        id ddMQdtnC0VVkNddMQdb3R7; Fri, 04 Aug 2017 14:13:55 +0000
Subject: Re: Update PS2 R5900 to kernel 4.x?
To:     Fredrik Noring <noring@nocrew.org>
Cc:     linux-mips@linux-mips.org
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
 <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
 <b0356404-42b6-6e8b-e15b-57cf98b7d6e6@gentoo.org>
 <2CA3040B-8EB9-456C-A4DE-BFE0D097971C@nocrew.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <77bec1a2-7e2b-3012-a909-b5ec1fe24178@gentoo.org>
Date:   Fri, 4 Aug 2017 10:13:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2CA3040B-8EB9-456C-A4DE-BFE0D097971C@nocrew.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOy4NTl3TQqVPuQKKNr2PIFLDU/kum3mt50WCvcXiP9yygHmH7A62yijwsQGnK5ZcqZqmKiI1dJvbxMtTpftWsJmvfW0dV6LMCYcJQyCZrN3bZiP3YN/
 042DnGvCti2+3nkO6vOIkJXU5sKYxgQ0gNbtyRE/+uK7ctKR3mp6H62326HER4HNCLfWVHczPZzGzSDEtYW+Q03gbG+2m/nzYjg=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59362
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

On 08/04/2017 09:45, Fredrik Noring wrote:
> 
>> 4 aug. 2017 kl. 04:04 skrev Joshua Kinard <kumba@gentoo.org>:
>>
>> Am not knowledgeable here, unfortunately.  If you have a Oops report and can
>> trace through a debugger and look at the underlying asm, that might highlight
>> something.  I've not had a lot of luck doing that on my SGI systems though.
> 
> Applying v3.9-rc1 commit 64b3122d gives this memory fault crash:
> 
>     [...]
>     rtc-ps2 rtc-ps2: hctosys: unable to read the hardware clock
>     RAMDISK: gzip image found at block 0
>     VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
>     devtmpfs: mounted
>     Freeing unused kernel memory: 248k freed
>     Memory fault
>     Memory fault
>     Memory fault
>     [repeats ~30 times]
>     Memory fault
>     Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000ff00
> 
> The parent commit boots to Busybox without (apparent) problems. Commit 64b3122d
> is small and I've also tried to apply the child commit 50150d2bb9 "mips: switch
> to generic sys_fork() and sys_clone()" which is related (perhaps required), but
> the crash persists.
> 
> A question is whether there is a problem with commit 64b3122d itself, e.g. the
> handling of MIPS register 29, perhaps in the patched R5900 assembly, or
> whether the commit depends on some previous change that hasn't been updated in
> the R5900 patch, e.g. the system calls in arch/mips/kernel/scall32-n32.S which
> (originally) seems to be a modified version of arch/mips/kernel/scall64-n32.S.
> Several previous changes by Al Viro switch to generic system calls:
> 
>     git log --author=viro v3.8..v3.9 arch/mips/kernel
> 
> I'm not quite sure how these changes would apply to the R5900 patch. That's
> where I'm stuck at the moment. I'm trying to figure out what is causing the
> memory fault. Are there any kernel parameters that would be helpful for
> debugging this?

Digging back into the Linux/MIPS git repo, it looks like this commit is part of
a branch that Viro was working on and there's one more commit by Viro that
comes after it, 50150d2bb903 ("mips: switch to generic sys_fork() and
sys_clone()").  So you might try to apply that change after 64b3122df48b, then
apply the three changes by Ralf in the same branch as well.  The branch merges
back into the main/master branch after that.

It appears the busybox init didn't like the changes to _sys_fork in
64b3122df48b, and is thus crashing, which causes the kernel to panic due to PID
1 dying.  Usually, the first thing init does after loading is fork off a call
to the shell/interpreter to start parsing the startup scripts, or process
/etc/inittab to load up what's specified in the runlevels.  That means the
"Memory fault" messages are not coming from the kernel, but from userland.

https://git.linux-mips.org/cgit/ralf/linux.git/log/arch/mips/kernel/syscall.c


>> Could be doable.  I forget, was PS2 big -endian or little-endian?  I primarily
>> work with big-endian these days due to my SGI systems.  I've got recent stage
>> builds at several different ABI/ISA combos and even a working netboot
>> filesystem.  Haven't had time to get kernels rolled yet (IP27 always spoils the
>> fun).
> 
> Great! R5900 hardware is endian configurable according to the Toshiba manual
> 
>     http://www.lukasz.dk/files/tx79architecture.pdf
> 
> and the PS2 R5900 patch is little-endian which is probably simplest to start
> with for interoperability with its BIOS etc.

Yeah, if the PS2 firmware is in little-endian, then that's what has to be used.
 Unless someone has figured out how to replace the firmware with something
custom, and trigger the CPU to go into big-endian mode.  But that would've
likely awakened the wrath of Sony's legal team.

I currently don't have an active little-endian userland to base from, but one
of our Gentoo/Embedded devs does have little-endian MIPS-III stage3 images
based on both uclibc-ng and musl:

http://gentoo.osuosl.org/experimental/mips/uclibc/mipsel3/stage3-mipsel3-uclibc-vanilla-20170709.tar.bz2

http://gentoo.osuosl.org/experimental/mips/musl/stage3-mipsel3-musl-vanilla-20160414.tar.bz2

The musl build is over a year old, though.  I am not sure if anything newer has
been built recently.  I don't know if a minimal netboot filesystem for
little-endian MIPS-III is available, and am also unsure if those builds will
operate sanely on a processor that claims MIPS-III compatibility but lacks the
LL/SC instructions.


>> I have one of the PS2 debug machines in a closet somewhere.  Basically a normal
>> PS2 with 4x RAM and says "TEST" on the side in the PS2 font.  Can't remember if
>> it still works or not.
> 
> Why not give it a try? :) Linux on the PS2 works without a dvd. A simple setup
> is a PS2 memory card (for the boot loader) and a usb memory (for the kernel and
> a root file system). Later PS2 models have built-in ethernet.

If I can find the time this weekend, and the power cord, I'll have to see if it
works.  I want to say it might've taken a power spike and stopped turning on,
but that might've been something else attached to my TV.  Thus far planning to
try and chase down possible timer/RCU bugs in SGI IP27 this weekend, but we'll see.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
