Received:  by oss.sgi.com id <S305171AbQALQaa>;
	Wed, 12 Jan 2000 08:30:30 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:13857 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQALQaV>;
	Wed, 12 Jan 2000 08:30:21 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09961; Wed, 12 Jan 2000 08:31:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA26568
	for linux-list;
	Wed, 12 Jan 2000 08:19:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA05101
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 12 Jan 2000 08:19:33 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from hood.tvd.be (hood.tvd.be [195.162.196.21]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03115
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 08:19:13 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg (cable-195-162-216-83.customer.chello.be [195.162.216.83])
	by hood.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id RAA01341
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 17:19:03 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian/GNU) with ESMTP id RAA31048
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 17:19:02 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Wed, 12 Jan 2000 17:19:02 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux@cthulhu.engr.sgi.com
Subject: RE: kernel sources?
In-Reply-To: <XFMail.000111194757.Harald.Koerfgen@home.ivm.de>
Message-ID: <Pine.LNX.4.05.10001121706050.29324-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

	Hi again,

First of all I would like to thank everyone who replied to my question!

In the mean time I managed to get until setup_arch() (which is after the
printing of the Linux banner :-). However, I'm seeing some very weird things: I
had to #if 0/#endif all code in setup_arch() starting with `strncpy
(command_line, arcs_cmdline, CL_SIZE);', or the system crashes right after

    Loading R4000 MMU routines

(yes, this is before setup_arch()!).

I suspect the ELF loader in PMON to be buggy. I also had to disable all __init
stuff before, because functions marked __init ended up as all `nop' after
tftpboot.  

I thought PMON may have problems with large images, so I disabled some more
config options for stuff I don't need at this stage, but now the #if 0/#endif
trick no longer works neither :-(

Note that I now know I can see `in advance' whether an image will work or not
(read: suffers from the above problem): PMON seems to coalesce two sections
when things go wrong.

Loading a working image using tftpboot:

    Loading elf file: xxx.yyy.zzz.qqq:geert/vmlinux
     0x80080000/1101820 + 0x8018e000/90656 + 0x801a4220/352320 + 2097 syms/
    Entry address is 80080580

Loading a non-working image using tftpboot:

    Loading elf file: xxx.yyy.zzz.qqq:geert/vmlinux
      0x80080000/1192432 + 0x801a31f0/352400 + 2097 syms/
    Entry address is 80080580

`objdump --headers' or `objdump --disassemble-all' don't show anything
suspicious.

I'm using gcc version egcs-2.90.27 980315 (egcs-1.0.2 release) and binutils
version 2.8.1 (mipsel-linux), using BFD version 2.8.1, compiled as crossutils
under Solaris/SPARC from binutils-2.8.1-2.src.rpm and egcs-1.0.2-9.src.rpm.

Anyone with a clue? Thx!

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
