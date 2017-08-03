Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 18:09:24 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:23062 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994897AbdHCQJR10XZJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Aug 2017 18:09:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id A95E43F602;
        Thu,  3 Aug 2017 18:09:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pFOUB4mIQHy5; Thu,  3 Aug 2017 18:09:05 +0200 (CEST)
Received: from [10.0.1.7] (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0631D3F3A6;
        Thu,  3 Aug 2017 18:09:03 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Update PS2 R5900 to kernel 4.x?
From:   Fredrik Noring <noring@nocrew.org>
In-Reply-To: <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
Date:   Thu, 3 Aug 2017 18:09:00 +0200
Cc:     linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <64C2A7A5-46FD-406C-9B51-5F45AEBA70F0@nocrew.org>
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
 <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
To:     Joshua Kinard <kumba@gentoo.org>
X-Mailer: Apple Mail (2.3259)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59349
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

Hi Joshua!

> 3 aug. 2017 kl. 16:25 skrev Joshua Kinard <kumba@gentoo.org>:
> 
> Didn't the PS2 kernel need a lot of userland changes and a special toolchain to
> deal with the hybrid nature of the R5900?

It depends, as I understand it. R5900 implements 64-bit MIPS III except LL, SC,
LLD and SCD, plus many extensions. Some instructions are emulated by the
kernel for compatibility, see changes to arch/mips/kernel/traps.c:

    https://github.com/frno7/linux/blob/ps2-v3.9-rc1-974fdb3/arch/mips/kernel/traps.c#L613

Since emulation is slow and R5900 has 128-bit load/store instructions, some
(optional) extensions were made:

    config R5900_128BIT_SUPPORT
        bool "Support for 128 bit general purpose registers”

    config MIPS_N32
        bool "Kernel support for n32 binaries”

as well as adding e.g. arch/mips/kernel/scall32-n32.S:

    https://github.com/frno7/linux/blob/ps2-v3.9-rc1-974fdb3/arch/mips/kernel/scall32-n32.S

Then there is a set of hardware bugs involving NOPs to avoid short loops, SYNCs
for MFC0 and MTC0, etc. Several updates address these. Jürgen Urban worked on
both the kernel and binutils about five years ago:

    https://sourceware.org/ml/binutils/2012-11/msg00360.html

I suspect the reason it crashes on 3.9 is that some of the changes are way out
of synch with the rest of the kernel since 2.6.35, even if the patch applies
fairly easily.

> Do you have a working userland that can run under the 3.9 kernel?

I started with the ”Black Rhino” (Debian) distribution and its Busybox, which
boots with 3.8, but I was actually hoping to get Gentoo MIPS working, as I’ve
seen you have stage 3 MIPS binaries. What are your thoughts on this?

> Last I heard, the latest kernel that would work
> on PS2 was a Sony-modified ~2.4.17 that was put out for some kind of
> specialized PS2 hardware found only in Japan.

I have a normal SCPH-70004 unit and as far as I understand the majority of the
manufactured PS2 units work (the last ones excepted). A slightly tricky part is
installing a boot loader (e.g. Free MC boot) on a memory card. No modifications
such as soldering is required.

All the best,
Fredrik
