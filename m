Received:  by oss.sgi.com id <S42325AbQFTN34>;
	Tue, 20 Jun 2000 06:29:56 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56145 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42229AbQFTN3f>; Tue, 20 Jun 2000 06:29:35 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA03110
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 06:34:44 -0700 (PDT)
	mail_from (schrijvp@rc.bel.alcatel.be)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id GAA87880 for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 06:28:49 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA34505
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 06:26:43 -0700 (PDT)
	mail_from (schrijvp@rc.bel.alcatel.be)
Received: from relay1.alcatel.be (alc119.alcatel.be [195.207.101.119]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA00877
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 06:26:32 -0700 (PDT)
	mail_from (schrijvp@rc.bel.alcatel.be)
Received: from btmq9s.rc.bel.alcatel.be (localhost [127.0.0.1])
	by relay1.alcatel.be (8.10.1/8.10.1) with ESMTP id e5KDPFP12835;
	Tue, 20 Jun 2000 15:25:15 +0200 (MET DST)
Received: from btmxbh.rc.bel.alcatel.be (btmxbh [138.203.64.184])
	by btmq9s.rc.bel.alcatel.be (8.8.8+Sun/8.8.8/1.1) with ESMTP id PAA28199;
	Tue, 20 Jun 2000 15:25:25 +0200 (MET DST)
Received: (from schrijvp@localhost)
	by btmxbh.rc.bel.alcatel.be (8.9.3/8.9.3) id PAA09059;
	Tue, 20 Jun 2000 15:25:09 +0200
Date:   Tue, 20 Jun 2000 15:25:09 +0200
From:   De Schrijver Peter <schrijvp@rc.bel.alcatel.be>
To:     Benjamin Herrenschmidt <bh40@calva.net>
Cc:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Message-ID: <20000620152509.O1177@rc.bel.alcatel.be>
References: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be> <20000620122329.13473@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000620122329.13473@mailhost.mipsys.com>; from bh40@calva.net on Tue, Jun 20, 2000 at 02:23:29PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

> We still can decide (and that's what I currently do in the kernel) that
> IO space is only supported on one of those 3 busses (the one on which the
> external PCI is). This prevents however use of IOs on the AGP slot, which
> is a problem for things like XFree who may try to use VGA addresses on
> the card.
> 

Is this really a problem ? I would expect AGP cards to be fully addresseable via 
the I/O space assigned in the PCI IO resource base ?

Peter.
