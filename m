Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 01:24:17 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:19674 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225342AbUBEBYQ>;
	Thu, 5 Feb 2004 01:24:16 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i151OEOI025416
	for <linux-mips@linux-mips.org>; Wed, 4 Feb 2004 17:24:15 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i151OCBe013414
	for <linux-mips@linux-mips.org>; Wed, 4 Feb 2004 17:24:13 -0800 (PST)
Date: Wed, 4 Feb 2004 17:24:13 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: linux-mips@linux-mips.org
Subject: GNU gcc ld script problem
Message-ID: <Pine.LNX.4.44.0402041636370.7920-100000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

	This seems like a problem specific to the linker, but it's also so
specific to linux and MIPS that I decided to send it here first. If I was
wrong to do that let me know and I'll send it to bug-binutils@gnu.org 
instead.

	Anyway, I think I've found a problem in the ld scripts for MIPS.
Basically the built in script don't seem to fill in a .plt section. So if
I do this:

mips-linux-gcc prog.c
mips-linux-objdump -h a.out | grep plt

I get no output, but if I use my modified linker script I get this:

mips-linux-gcc -T tmp.ld prog.c
mips-linux-objdump -h a.out | grep plt
 10 .plt          00000030  0040052c  0040052c  0000052c  2**2

which I believe is the correct output. The change that I made was to move
.stub sections into the .plt from the .text section. So this:

  .plt            : { *(.plt) }
  .text           :
  {
    _ftext = . ;
    *(.text .stub .text.* .gnu.linkonce.t.*)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    *(.mips16.fn.*) *(.mips16.call.*)
  } =0

became this:

  .plt            : { *(.plt .stub) }
  .text           :
  {
    _ftext = . ;
    *(.text .text.* .gnu.linkonce.t.*)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    *(.mips16.fn.*) *(.mips16.call.*)
  } =0

If anyone needs more information on this issue just let me know. It has
been in the MIPS tools for a while. I have been working from a recent 
snapshot:

59) ./mips-linux-ld -v
GNU ld version 040121 20040121

but the same issue was around way back when (MontaVista preview kit 2.1):

61) /opt/hardhat/previewkit/mips/fp_be/bin/mips_fp_be-ld -v
GNU ld version 2.10.91 (with BFD 2.10.91.0.2)

Does anyone here have the knowledge to confirm that my changes are correct 
and commit privileges to the binutils tree?

	nathan

-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)
