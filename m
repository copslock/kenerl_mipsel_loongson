Received:  by oss.sgi.com id <S42324AbQFTNNq>;
	Tue, 20 Jun 2000 06:13:46 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:65078 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42229AbQFTNNX>;
	Tue, 20 Jun 2000 06:13:23 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA09035
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 06:08:10 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id GAA75456 for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 06:11:21 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA30985
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 06:09:35 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA05531
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 06:09:15 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA27880;
	Tue, 20 Jun 2000 15:09:23 +0200 (MET DST)
Date:   Tue, 20 Jun 2000 15:09:23 +0200 (MET DST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Benjamin Herrenschmidt <bh40@calva.net>
cc:     Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>,
        Linux kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: Proposal: non-PC ISA bus support
In-Reply-To: <20000620130238.15357@mailhost.mipsys.com>
Message-ID: <Pine.GSO.4.10.10006201508360.8592-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 20 Jun 2000, Benjamin Herrenschmidt wrote:
> On Tue, Jun 20, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> >Concatenating the I/O spaces seems like the best solution to me as well.
> 
> Would work if the ranges you are passing via /proc/bus/isa/xxxx are
> kernel virtual addresses and not physical addresses (I didn't check if
> this is the case).

Oops, /proc/bus/isa/map talks about physical addresses.

Workaround: patch the mmap() entry of /dev/mem.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
