Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 10:34:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35677 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011292AbaJVIej3YUCi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 10:34:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9M8YcM4003860;
        Wed, 22 Oct 2014 10:34:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9M8YcZ3003859;
        Wed, 22 Oct 2014 10:34:38 +0200
Date:   Wed, 22 Oct 2014 10:34:37 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Cc:     Ben Hutchings <ben@decadent.org.uk>
Subject: Single MIPS kernel
Message-ID: <20141022083437.GB18581@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

This question comes up every once in a while and I've also been approached
during ELCE in Düsseldorf why there is no single MIPS kernel for all
platforms, so I thought I should post a writeup on the topic.

The primary reason is that MIPS kernels are using non-PIC kernels.  This
means code is linked to a particular absolute address.  The link address
depends on the memory range available on a particular system's available
memory range - there is no one size that fits all systems, not even a
large fraction of supported systems.

What does it take to make kernels relocatable?  A current kernel is not
relocatable.  One might do something along the lines of userland where
the dynamic linker is in a similar situation and needs to first relocate
itself before it can perform its actual job.

Two approaches.  First keeping the non-PIC code.  That requires keeping
the entire relocation.  A lasat_defconfig vmlinux is 5733098 bytes but
built with --emit-relocs to keep the reloc information in the final
binary the vmlinux file grows to 7217342 bytes!  A quick look at the
reloc sections:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 2] .rel.text         REL             00000000 461538 0eedf8 08     34   1  4
  [ 4] .rel__ex_table    REL             00000000 550330 0040e0 08     34   3  4
  [ 8] .rel.rodata       REL             00000000 554410 0310e0 08     34   7  4
  [10] .rel.pci_fixup    REL             00000000 5854f0 000998 08     34   9  4
  [12] .rel__ksymtab     REL             00000000 585e88 00b3b0 08     34  11  4
  [14] .rel__ksymtab_gpl REL             00000000 591238 007180 08     34  13  4
  [17] .rel__param       REL             00000000 5983b8 000858 08     34  16  4
  [19] .rel__modver      REL             00000000 598c10 000038 08     34  18  4
  [21] .rel.data         REL             00000000 598c48 00a130 08     34  20  4
  [23] .rel.init.text    REL             00000000 5a2d78 00f008 08     34  22  4
  [25] .rel.init.data    REL             00000000 5b1d80 001d08 08     34  24  4
  [27] .rel.exit.text    REL             00000000 5b3a88 000b78 08     34  26  4

The approach could probably be optimized but as a first order approximation
this demonstrates there would be plenty of bloat to the binary.  Positive
side of this approach: no runtime penalty.

Alternatively: make the kernel PIC code.  Over the thumb that'd going to
inflate the kernel by 10 or 15%.  Less than above approach but there'd
also be significant runtime overhead.  Probably nothing for a world where
benchmarks like network performance on 64 byte packets decide on the
fate of a product on the market.

Obviously there is the difference between 32 and 64 bit kernels.  64 bit
uses additional instructions that are not available on 32 bit processors
and using just 32 bit instructions won't fly on 64 bit kernels.

Hardware detection.  That's all easy in a device tree world but in all
reality many of the existing systems don't support device tree yet so a
generic kernel would have to figure out what platform it's running on
which would end up in something like an ISA style device probe.

  Ralf
