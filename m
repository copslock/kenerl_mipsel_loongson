Received:  by oss.sgi.com id <S42202AbQFVFnL>;
	Wed, 21 Jun 2000 22:43:11 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:65148 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42190AbQFVFmy>;
	Wed, 21 Jun 2000 22:42:54 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id WAA07945
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 22:37:54 -0700 (PDT)
	mail_from (mlan@cpu.lu)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA41828
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 22:42:21 -0700 (PDT)
	mail_from (mlan@cpu.lu)
Received: from mcp.cpu.lu (mcp.cpu.lu [193.168.2.34]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA02303
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jun 2000 22:42:19 -0700 (PDT)
	mail_from (mlan@cpu.lu)
Received: from piglet.grunz.lu (mfp [193.168.2.96])
	by mcp.cpu.lu (8.8.6 (PHNE_14041)/8.8.6) with ESMTP id HAA17559;
	Thu, 22 Jun 2000 07:42:26 +0200 (METDST)
Received: from cpu.lu (localhost [127.0.0.1])
	by piglet.grunz.lu (8.9.3/8.9.3) with ESMTP id XAA01021;
	Wed, 21 Jun 2000 23:47:04 +0200
Message-Id: <200006212147.XAA01021@piglet.grunz.lu>
Date:   Wed, 21 Jun 2000 23:47:01 +0200 (CEST)
From:   Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Proposal: non-PC ISA bus support
To:     bh40@calva.net
cc:     Geert.Uytterhoeven@sonycom.com, linuxppc-dev@lists.linuxppc.org,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <20000620122329.13473@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi all,

On  20 Jun, this message from Benjamin Herrenschmidt echoed through cyberspace:
> We still can decide (and that's what I currently do in the kernel) that
> IO space is only supported on one of those 3 busses (the one on which the
> external PCI is). This prevents however use of IOs on the AGP slot,

... and multiple host bridges, like on the 9x00 (bad, two separate buses
    à 3 slots) and 7x00/8x00 (no problem, second (fixed, video
    subsys) bus doesn't have IO devices).

struct pci_dev has void *sysdata. Can we use that for something
reasonable here? Like additional info (iobase per device, set by fixup
code)?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "
