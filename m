Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 21:12:04 +0100 (CET)
Received: from resqmta-ch2-04v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:36]:39080
        "EHLO resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdCOUL5vZVJL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 21:11:57 +0100
Received: from resomta-ch2-05v.sys.comcast.net ([69.252.207.101])
        by resqmta-ch2-04v.sys.comcast.net with SMTP
        id oFDEcI7ciE5a6oFH2cxl4b; Wed, 15 Mar 2017 20:11:56 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-05v.sys.comcast.net with SMTP
        id oFH0c6THllSbroFH1cD7mm; Wed, 15 Mar 2017 20:11:56 +0000
To:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: ARCS can't load CONFIG_DEBUG_LOCK_ALLOC kernel
Message-ID: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
Date:   Wed, 15 Mar 2017 16:11:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOX9vOnotQ5XcN9ZZHszMTaCZnNb8tR08ri2mRoJuvF/ACQNowFosuaBndtBqUDz7w8kavl/0AJv++gkma1vdLjME8cPGJm93WkJTyvC1LcBV+3VgBrn
 nLB8o9mXVZkKA9oetseHY8lrPoZ45I0XgDNJYUkEwHKmKjmS/laj9NEB
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57309
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

I've reported in the past that turning on CONFIG_DEBUG_LOCK_ALLOC produces a
kernel that can't boot on several SGI platforms.  It turns out that using
arcload (Stan's bootloader originally written for IP30), I can get some
debugging out on why.  I am still puzzled, but maybe this information can be
interpreted by someone else into something meaningful?

All addresses printed out of arcload are physical address.

ARCS Memory Map as printed by some debugging I added to the arcload binary:

0x00000000 - 0x00001000 ExceptionBlock
0x00001000 - 0x00002000 SystemParameterBlock
0x00002000 - 0x00004000 FirmwarePermanent
0x20004000 - 0x20f00000 FreeMemory***
0x20f00000 - 0x21000000 FirmwareTemporary
0x21000000 - 0x5fff0000 FreeMemory
0x5fff0000 - 0x5ffff000 LoadedProgram
0x5ffff000 - 0x60000000 FreeMemory
0x60000000 - 0xa0000000 FirmwarePermanent

The ***'ed FreeMemory segment is where the kernel is supposed to load.  Here's
the debugging for a kernel WITHOUT CONFIG_DEBUG_LOCK_ALLOC enabled (4102norm):

ELF Start: 0x20004000
Elf End  : 0x20a6fdd0
Size     : 0x00a6bdd0 (~10MB?)

# ls -l 4102norm
-rwxr-xr-x 1 root root 28M Mar 15 15:12 4102norm*


And the debugging kernel compiled with CONFIG_DEBUG_LOCK_ALLOC=y (no other
config changes from above):

ELF Start: 0x20004000
Elf End  : 0x2148bf80
Size     : 0x01487f80 (~20MB?)

# ls -l 4102dbg
-rwxr-xr-x 1 root root 29M Mar 15 15:21 4102dbg*


I am only using the traditional "vmlinux" make target, so there shouldn't be
any compression involved here.  Yet, it looks like, according to ARCS anyways,
that CONFIG_DEBUG_LOCK_ALLOC is adding an additional 10MB of "something", yet
the vmlinux file only grows by roughly 1MB.

If I examine both kernels with readelf and dump the program headers, I can see
these two sizes reflected under "MemSiz":

# mips64-unknown-linux-gnu-readelf -l 4102norm

Elf file type is EXEC (Executable file)
Entry point 0xa800000020700450
There are 2 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000004000 0xa800000020004000 0xa800000020004000
                 0x00000000009a5030 0x0000000000a6bdd0  RWE    10000
  NOTE           0x0000000000714bb0 0xa800000020714bb0 0xa800000020714bb0
                 0x0000000000000024 0x0000000000000024  R      4

# mips64-unknown-linux-gnu-readelf -l 4102dbg

Elf file type is EXEC (Executable file)
Entry point 0xa800000020749c80
There are 2 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000004000 0xa800000020004000 0xa800000020004000
                 0x0000000000a05850 0x0000000001487f80  RWE    10000
  NOTE           0x000000000075e330 0xa80000002075e330 0xa80000002075e330
                 0x0000000000000024 0x0000000000000024  R      4


So I'm not quite certain why ARCS or arcload dislike kernels with
CONFIG_DEBUG_LOCK_ALLOC=y.  This issue is known about on at least IP27 and IP30
platforms for the past few years, and it's been quite a hindrance in doing any
debugging of locks.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
