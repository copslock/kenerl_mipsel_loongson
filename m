Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA15754; Tue, 23 Apr 1996 19:05:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id TAA11371; Tue, 23 Apr 1996 19:05:45 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	 id TAA11362; Tue, 23 Apr 1996 19:05:43 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id TAA09132; Tue, 23 Apr 1996 19:05:42 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id WAA23379; Tue, 23 Apr 1996 22:05:40 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id WAA10247; Tue, 23 Apr 1996 22:05:40 -0400
Date: Tue, 23 Apr 1996 22:05:40 -0400
Message-Id: <199604240205.WAA10247@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: greg@xtp.engr.sgi.com
CC: alambie@wellington.sgi.com, linux@cthulhu.engr.sgi.com
In-reply-to: <9604230939.ZM27797@xtp.engr.sgi.com> (greg@xtp.engr.sgi.com)
Subject: Re: MIPS port kickoff meeting
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: "Greg Chesson" <greg@xtp.engr.sgi.com>
   Date: Tue, 23 Apr 1996 09:39:29 -0700

   There are US Gov't customers for Linux on SGI boxes who require
   64-bit OS.  So, let's support tho 32-bit ARCS boxes without
   compromising opportunities to sell new boxes (with 64-bit Linux).

Like I said I'll do the 32-bit port and work from there based upon how
I feel after that.

Remember I've got one kernel here which works on every 32-bit CPU type
Sun has every put into a box with almost no performance loss.  I can
do it too for MIPS and I will.  The goal being that some day I will be
able to slap the same kernel image into an INDY as I can for an ONYX
and a LEGO.

And also, I will design it such that, as in the traditional Linux
kernel model, you can config all this shit out and get the streamlined
minimal kernel which only works with a certain configuation. (MM code,
config it out because this is for an embedded system)

Later,
David S. Miller
davem@caip.rutgers.edu
