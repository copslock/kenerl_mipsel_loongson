Received:  by oss.sgi.com id <S305169AbQALJIA>;
	Wed, 12 Jan 2000 01:08:00 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:61528 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQALJHl>;
	Wed, 12 Jan 2000 01:07:41 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA07961; Wed, 12 Jan 2000 01:04:36 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA43038
	for linux-list;
	Wed, 12 Jan 2000 00:57:55 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA23114
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 12 Jan 2000 00:57:52 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from aeon.tvd.be (aeon.tvd.be [195.162.196.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA09356
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 00:57:47 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg (cable-195-162-216-83.customer.chello.be [195.162.216.83])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id JAA05869;
	Wed, 12 Jan 2000 09:57:41 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian/GNU) with ESMTP id JAA29504;
	Wed, 12 Jan 2000 09:57:41 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Wed, 12 Jan 2000 09:57:41 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     linux@cthulhu.engr.sgi.com
Subject: RE: kernel sources?
In-Reply-To: <XFMail.000111194757.Harald.Koerfgen@home.ivm.de>
Message-ID: <Pine.LNX.4.05.10001120953200.29324-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, 11 Jan 2000, Harald Koerfgen wrote:
> > Now I'm wondering which kernel sources you suggest to start a port with. I
> > tried the one from :pserver:cvs@linus.linux.sgi.com:/cvs (2.3.21) but
> > compilation stopped due to a problem in serial.c (I compiled for
> > CONFIG_ACER_PICA_61, just to see whether the tree worked).
> 
> This source tree as absolutely correct to start with. The attached patch should
> fix the complilation problem.

Thanks! But unfortunately it doesn't fix all problems:

serial.c: In function `line_info':
serial.c:3078: warning: long unsigned int format, unsigned int arg (arg 5)
serial.c: In function `autoconfig':
serial.c:3430: `ASYNC_IOC3' undeclared (first use this function)
serial.c:3430: (Each undeclared identifier is reported only once
serial.c:3430: for each function it appears in.)
serial.c: In function `rs_init':
serial.c:3999: `ASYNC_IOC3' undeclared (first use this function)
serial.c:4015: warning: long unsigned int format, unsigned int arg (arg 4)

I think some #ifdef CONFIG_SGI_IP27/#endif is missing there.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
