Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2014 00:30:04 +0200 (CEST)
Received: from orbit.nwl.cc ([176.31.251.142]:51945 "EHLO mail.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822766AbaHLWaBz1GLS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Aug 2014 00:30:01 +0200
Received: from mail.nwl.cc (orbit [127.0.0.1])
        by mail.nwl.cc (Postfix) with ESMTP id 77E40231B3;
        Wed, 13 Aug 2014 00:30:01 +0200 (CEST)
Received: from base (orbit [127.0.0.1])
        by mail.nwl.cc (Postfix) with ESMTP id 524B222F48;
        Wed, 13 Aug 2014 00:30:01 +0200 (CEST)
Date:   Tue, 12 Aug 2014 03:29:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: ATH79: zboot and kernel parameters
Mail-Followup-To: linux-mips@linux-mips.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
References: <20140804231147.793FF227FD@mail.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140804231147.793FF227FD@mail.nwl.cc>
User-Agent: Mutt/1.5.22 (2013-10-16)
Message-Id: <20140812223001.524B222F48@mail.nwl.cc>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phil@nwl.cc
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

On Tue, Aug 05, 2014 at 01:14:43AM +0200, Phil Sutter wrote:
> I have this Routerboard 493g from Mikrotik, thanks to the
> OpenWrt-provided patches Linux-3.14.9 runs fine on it.
> 
> On top of that, I have added the necessary things to allow for zboot and
> indeed it can boot a compressed kernel. The only problem with that is
> for some reason the kernel parameters passed on by the boot loader do
> not make it into the kernel.
> 
> I have tried printing the parameters from inside decompress.c by
> mimicking the way head.S stores them for later access from inside C
> code, but had no luck so far. For whatever reason, the variables'
> contents seem to be zero.

Further investigation shows that registers a0 and a1 are indeed set by
the boot loader no matter if booting a compressed or uncompressed
kernel. In both cases a0 contains the value 0xB, a1 contains 0xA0872200.

The difference shows when accessing the memory at the location pointed
to by a1: the expected array of eleven char-pointers contains zeroes.

The boot laoder passes the following parameters:
console=ttyS0,115200 parts=1 boot_part_size=4194304 gpio=4023
HZ=340000000 mem=256M kmac=D4:CA:6D:A0:48:3A board=493G ver=3.10 boot=1
mlc=5

The uncompressed kernel sees the following values inside the
char-pointer array:
- a0871e00
- a0871e15
- a0871e1d
- a0871e34
- a0871e3e
- a0871e4b
- a0871e54
- a0871e6b
- a0871e76
- a0871e7f
- a0871e86

The values' distances match the parameters' lengths, so the boot loader
keeps the above kernel command line as continuous memory at address
0xa0871e00.

Explicitly printing (char *)0xa0871e00 does not show anything, so I
expect the memory at this address to be zero as well.

While searching for the code that could corrupt the mentioned memory
locations, I commented out the part of arch/mips/boot/compressed/head.S
commented to "Clear BSS" - and there it is, correct values show up.
Further debugging shows that _edata and _end are computed by the linker
to 0x804DFA40 and 0x808E1A50. Assuming these are in KSEG0 they include
the KSEG1 addresses above.

Putting this all together it occurs to me that vmlinuz is loaded to an
address so that it's bss section covers the area used by the boot loader
to pass it's parameters to the kernel. In order to overcome this, I have
tried to change the load address specified in arch/mips/ath79/Platform,
but without luck so far. Am I on the right track? Is this the right
place to fix this issue or are there alternative knobs to turn?

Best wishes, Phil
