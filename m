Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 23:16:05 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:56598 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2100592Ab1C1VQC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2011 23:16:02 +0200
Received: by qyl38 with SMTP id 38so2665550qyl.15
        for <linux-mips@linux-mips.org>; Mon, 28 Mar 2011 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SZrE7Od5jLHPppvVeB8SBCFdxMqcuKEstUV2dZ2xdYs=;
        b=PetaiJA/KsSMeWGdOfbgO2M2PbcTzMbekRg1lFAl//GcRihLa0dGl9XdqG/6oF20En
         ax33Hy8yo0yZ8oTnSHyE+cT/RoJDiRoTWnCvPeEPWXpOuF77he95jrK/U5J0Dgpgv/ws
         Jcl1dzjnSPYVegJhGwQ3nzXZvmyUlMtQ6pqps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WB2tdaf+8DU7jiYBLInDDdfKF1PyBwZm+xklswiIQEIZUFBbnQJ4H3QqGXRLD4QII5
         XYnvhzEOj9iHNCJD48mgY/GfVpx4Eh4SBH2I+9IzaY+dnJt1h/hEWGHhVaT08ASR30BJ
         23ObNhtrLvBgUEb9aNoZFugzebfR3ebEz058o=
MIME-Version: 1.0
Received: by 10.224.189.135 with SMTP id de7mr3588820qab.170.1301346956219;
 Mon, 28 Mar 2011 14:15:56 -0700 (PDT)
Received: by 10.229.6.200 with HTTP; Mon, 28 Mar 2011 14:15:55 -0700 (PDT)
In-Reply-To: <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
        <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
        <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
Date:   Tue, 29 Mar 2011 00:15:55 +0300
Message-ID: <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Maxin John <maxin.john@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Daniel Baluta <dbaluta@ixiacom.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <maxin.john@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxin.john@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

> Just add "depends on MIPS" and give it a try.
As per your suggestion, I have tried it in my qemu environment (MIPS malta).

With a minor modification in arch/mips/kernel/vmlinux.lds.S (added the
symbol  _sdata ), I was able to add kmemleak support for MIPS.

Output in MIPS (Malta):

debian-mips:~# uname -a
Linux debian-mips 2.6.38-08826-g1788c20-dirty #4 SMP Mon Mar 28
23:22:04 EEST 2011 mips GNU/Linux
debian-mips:~# mount -t debugfs nodev /sys/kernel/debug/
debian-mips:~# cat /sys/kernel/debug/kmemleak
unreferenced object 0x8f95d000 (size 4096):
  comm "swapper", pid 1, jiffies 4294937330 (age 467.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<80529644>] alloc_large_system_hash+0x2f8/0x410
    [<8053864c>] udp_table_init+0x4c/0x158
    [<80538774>] udp_init+0x1c/0x94
    [<80538b34>] inet_init+0x184/0x2a0
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f95e000 (size 4096):
  comm "swapper", pid 1, jiffies 4294937330 (age 467.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<80529644>] alloc_large_system_hash+0x2f8/0x410
    [<8053864c>] udp_table_init+0x4c/0x158
    [<8053881c>] udplite4_register+0x24/0xa8
    [<80538b3c>] inet_init+0x18c/0x2a0
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f982b80 (size 128):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.230s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b9b4c>] kmem_cache_alloc+0xe4/0x128
    [<8052d960>] kmemleak_test_init+0x4c/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f982b00 (size 128):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.230s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b9b4c>] kmem_cache_alloc+0xe4/0x128
    [<8052d97c>] kmemleak_test_init+0x68/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f980800 (size 1024):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.230s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b9b4c>] kmem_cache_alloc+0xe4/0x128
    [<8052d998>] kmemleak_test_init+0x84/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f980400 (size 1024):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b9b4c>] kmem_cache_alloc+0xe4/0x128
    [<8052d9b4>] kmemleak_test_init+0xa0/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f98a800 (size 2048):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b9b4c>] kmem_cache_alloc+0xe4/0x128
    [<8052d9d0>] kmemleak_test_init+0xbc/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f98a000 (size 2048):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b9b4c>] kmem_cache_alloc+0xe4/0x128
    [<8052d9ec>] kmemleak_test_init+0xd8/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f98b000 (size 4096):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b9b4c>] kmem_cache_alloc+0xe4/0x128
    [<8052da24>] kmemleak_test_init+0x110/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0xc0003000 (size 64):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
    [<801b1bfc>] __vmalloc_node+0x30/0x3c
    [<801b1d94>] vmalloc+0x2c/0x38
    [<8052da38>] kmemleak_test_init+0x124/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0xc0006000 (size 64):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
    [<801b1bfc>] __vmalloc_node+0x30/0x3c
    [<801b1d94>] vmalloc+0x2c/0x38
    [<8052da4c>] kmemleak_test_init+0x138/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0xc0009000 (size 64):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
    [<801b1bfc>] __vmalloc_node+0x30/0x3c
    [<801b1d94>] vmalloc+0x2c/0x38
    [<8052da60>] kmemleak_test_init+0x14c/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0xc000c000 (size 64):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
    [<801b1bfc>] __vmalloc_node+0x30/0x3c
    [<801b1d94>] vmalloc+0x2c/0x38
    [<8052da74>] kmemleak_test_init+0x160/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0xc000f000 (size 64):
  comm "swapper", pid 1, jiffies 4294937331 (age 467.270s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801b1b58>] __vmalloc_node_range+0x16c/0x1e0
    [<801b1bfc>] __vmalloc_node+0x30/0x3c
    [<801b1d94>] vmalloc+0x2c/0x38
    [<8052da88>] kmemleak_test_init+0x174/0x298
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18
unreferenced object 0x8f072000 (size 4096):
  comm "swapper", pid 1, jiffies 4294937680 (age 463.840s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<801ba3d8>] __kmalloc+0x130/0x180
    [<805461bc>] flow_cache_cpu_prepare+0x50/0xa8
    [<8053746c>] flow_cache_init_global+0x90/0x138
    [<80100584>] do_one_initcall+0x174/0x1e0
    [<8051f348>] kernel_init+0xe4/0x174
    [<80103d4c>] kernel_thread_helper+0x10/0x18


Please let me know your comments.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 832afbb..f5356fc 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -68,6 +68,7 @@ SECTIONS
        RODATA

        /* writeable */
+       _sdata = .;                  /* Start of data section */
        .data : {       /* Data */
                . = . + DATAOFFSET;             /* for CONFIG_MAPPED_KERNEL */

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index df9234c..5042421 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -398,7 +398,7 @@ config SLUB_STATS
 config DEBUG_KMEMLEAK
        bool "Kernel memory leak detector"
        depends on DEBUG_KERNEL && EXPERIMENTAL && !MEMORY_HOTPLUG && \
-               (X86 || ARM || PPC || S390 || SPARC64 || SUPERH ||
MICROBLAZE || TILE)
+               (X86 || ARM || PPC || MIPS || S390 || SPARC64 ||
SUPERH || MICROBLAZE || TILE)

        select DEBUG_FS if SYSFS
        select STACKTRACE if STACKTRACE_SUPPORT
