Received:  by oss.sgi.com id <S305167AbQAKKGc>;
	Tue, 11 Jan 2000 02:06:32 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:50220 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQAKKGI>;
	Tue, 11 Jan 2000 02:06:08 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA02196; Tue, 11 Jan 2000 02:07:12 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA13517
	for linux-list;
	Tue, 11 Jan 2000 01:53:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA41722
	for <linux@engr.sgi.com>;
	Tue, 11 Jan 2000 01:53:40 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from hood.tvd.be (hood.tvd.be [195.162.196.21]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA06676
	for <linux@engr.sgi.com>; Tue, 11 Jan 2000 01:53:35 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg (cable-195-162-216-83.customer.chello.be [195.162.216.83])
	by hood.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id KAA23652
	for <linux@engr.sgi.com>; Tue, 11 Jan 2000 10:53:32 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian/GNU) with ESMTP id KAA25814
	for <linux@engr.sgi.com>; Tue, 11 Jan 2000 10:53:32 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Tue, 11 Jan 2000 10:53:32 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux@cthulhu.engr.sgi.com
Subject: kernel sources?
Message-ID: <Pine.LNX.4.05.10001111049230.25053-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

	Hi,

We are considering porting Linux to a R5000-based board.

I built a cross-compiler according to the guidelines in the MIPS-HOWTO and it
was a piece of cake.

Now I'm wondering which kernel sources you suggest to start a port with. I
tried the one from :pserver:cvs@linus.linux.sgi.com:/cvs (2.3.21) but
compilation stopped due to a problem in serial.c (I compiled for
CONFIG_ACER_PICA_61, just to see whether the tree worked).

Thanks in advance!

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
