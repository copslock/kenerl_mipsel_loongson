Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2003 16:47:04 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:6374 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225246AbTFKPrC>;
	Wed, 11 Jun 2003 16:47:02 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5BFkspI005098
	for <linux-mips@linux-mips.org>; Wed, 11 Jun 2003 17:46:55 +0200 (MEST)
Date: Wed, 11 Jun 2003 17:46:53 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Corruption in 2.4.x
Message-ID: <Pine.GSO.4.21.0306111738200.6450-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi,

Recently we started seeing slight file corruption and random segmentation
faults with the 2.4.x MIPS kernel from CVS. The problems appeared after
upgrading from 2.4.20 (CVS 2003-01-13) to 2.4.21-pre4 (CVS 2003-05-06), which
introduced the new cache/tlb optimizations.

Most prominent indication of the file corruption is the corruption of
/etc/motd, of which the non-first lines are rewritten by the startup scripts on
every boot up.

The CPU contains a VR4120A core, running in big endian mode. It should be very
similar to the core in the VR4131, with the following exceptions:
  - both the instruction and data cache are direct mapped instead of 2-way
    associative
  - the data cache is only 8 KiB instead of 16 KiB

Perhaps this rings a bell?

Our cross-toolchain consists of gcc 3.2.2 and binutils 2.13.2.1. Userland is
Debian (mostly woody).

Relevant part of dmesg:

| CPU revision is: 00000c72
| Primary instruction cache 16kB, physically tagged, direct mapped, linesize 16 bytes.
| Primary data cache 8kB direct mapped, linesize 16 bytes.

Relevant part of /proc/cpuinfo:

| cpu model               : NEC VR4122 V7.2
| BogoMIPS                : 165.88
| wait instruction        : no
| microsecond timers      : yes
| tlb_entries             : 32
| extra interrupt vector  : no
| hardware watchpoint     : no
| VCED exceptions         : not available
| VCEI exceptions         : not available

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
