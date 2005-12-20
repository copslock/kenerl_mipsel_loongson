Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2005 02:56:34 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:61894 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S8133960AbVLTC4R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Dec 2005 02:56:17 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1EoXgk-0006Jq-00
	for <linux-mips@linux-mips.org>; Tue, 20 Dec 2005 03:57:18 +0100
Subject: Kernel freezes in r4k_flush_icache_range() with
	CONFIG_CPU_MIPS32_R2
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 20 Dec 2005 03:57:18 +0100
Message-Id: <1135047438.9874.74.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


Hello all,

I'm porting linux for a board with a R4KECr2. So far I was using
CONFIG_CPU_MIPS32_R1 and the kernel (2.6.14) was running well.

But I'm unable to get it working with CONFIG_CPU_MIPS32_R2, it freezes
somewhere in trap_init, more exactly in r4k_flush_icache_range().

Here is a snippet from the generated assembly code:

00002624 <r4k_flush_icache_range>:
    2624:       27bdffd0        addiu   sp,sp,-48
    2628:       3c020000        lui     v0,0x0
    262c:       afb30024        sw      s3,36(sp)
    2630:       afb20020        sw      s2,32(sp)
    2634:       afbf0028        sw      ra,40(sp)
    2638:       afb1001c        sw      s1,28(sp)
    263c:       afb00018        sw      s0,24(sp)
[...]
    26a0:       bc900000        cache   0x10,0(a0)
    26a4:       1464fffd        bne     v1,a0,269c <r4k_flush_icache_range+0x78>
    26a8:       3c020000        lui     v0,0x0
    26ac:       2442277c        addiu   v0,v0,10108   <----------
    26b0:       00400408        jr.hb   v0
    26b4:       00000000        nop
[...]
    272c:       8c43000c        lw      v1,12(v0)
    2730:       0060f809        jalr    v1
    2734:       00000000        nop
    2738:       3c020000        lui     v0,0x0
    273c:       2442277c        addiu   v0,v0,10108   <----------
    2740:       00400408        jr.hb   v0
    2744:       00000000        nop
    2748:       8fbf0028        lw      ra,40(sp)
    274c:       8fb30024        lw      s3,36(sp)
    2750:       8fb20020        lw      s2,32(sp)
    2754:       8fb1001c        lw      s1,28(sp)
    2758:       8fb00018        lw      s0,24(sp)
    275c:       03e00008        jr      ra
    2760:       27bd0030        addiu   sp,sp,48
    2764:       3c020000        lui     v0,0x0
    2768:       8c430018        lw      v1,24(v0)
    276c:       0060f809        jalr    v1
    2770:       00000000        nop
    2774:       0800099c        j       2670 <r4k_flush_icache_range+0x4c>
    2778:       3c030000        lui     v1,0x0

0000277c <r4k_dma_cache_inv>:
[...]

At offset 0x26ac and 0x273c, we can see that instruction_hazard() got
duplicated due to inlining, and that the jr.hb is going to send us to
10108 (0x277C), outside the function...

The only way I managed to get a good value in v0 was by using -O0 and
making r4k_flush_icache_range return int.

Now I'm really not familiar with gcc inline assembly so I don't know if
this is a compiler bug or if something is missing in
instruction_hazard().


# mipsel-linux-gcc -v
Using built-in specs.
Target: mipsel-linux-uclibc
Configured
with: /home/work/buildroot/toolchain_build_mipsel/gcc-4.0.2/configure
--prefix=/opt/toolchains/mipsel-uclibc-0.9.28-gcc-4.0.2
--build=i386-pc-linux-gnu --host=i386-pc-linux-gnu
--target=mipsel-linux-uclibc --enable-languages=c,c++ --enable-shared
--disable-__cxa_atexit --enable-target-optspace --with-gnu-ld
--disable-nls --enable-threads --enable-multilib
Thread model: posix
gcc version 4.0.2
#

Thanks,

-- 
Maxime
