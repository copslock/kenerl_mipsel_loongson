Received:  by oss.sgi.com id <S42319AbQFTMYf>;
	Tue, 20 Jun 2000 05:24:35 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36172 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42229AbQFTMYU>; Tue, 20 Jun 2000 05:24:20 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA02053
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 05:29:27 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA21641
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 05:23:46 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from [62.161.177.33] (mailhost.mipsys.com [62.161.177.33]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA05433
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 05:23:43 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from [192.168.1.19] by [192.168.1.2]
     with SMTP (QuickMail Pro Server for Mac 2.0); 20 JUN 00 14:25:21 UT
From:   Benjamin Herrenschmidt <bh40@calva.net>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Date:   Tue, 20 Jun 2000 14:23:29 +0200
Message-Id: <20000620122329.13473@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
References: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
X-Mailer: CTM PowerMail 3.0.3 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jun 20, 2000, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
wrote:


> 1. Provide /proc/bus/isa/map, which contains the ISA I/O and memory space
>    mappings on machines where these are memory mapped.
>
>    Example (on PPC CHRP LongTrail):
>
>	callisto$ cat /proc/bus/isa/map
>	f8000000	01000000	IO
>	f7000000	01000000	MEM
>	callisto$

Looks fine except for one thing: How can we handle weird HW (like Apple
Uni-N bridge) that has actually 3 different IO spaces at different
locations (all of them beeing childs of the same PCI bus).
This is more or less related since the ISA iospace can be considered as a
subset of the PCI IO space. The problem is generic (it happens with both
"pure" PCI drivers doing IOs and ISA drivers doing IOs). The problem
exist for both the kernel and userland apps like XFree wanting to do PCI
or ISA IOs. The kernel has a built-in IO-base, your patch would expose it
to userland fixing part of the problem for XFree (so userland don't have
to probe for zillion different bridges) but wouldn't solve the problem of
multiple busses.

Paul suggested mapping them one after each other in a single contiguous
region (with the appropriate fixup in the kernel PCI io resources) but
this can work only for PCI IOs (drivers using the io resource base).
Drivers hard-coding legacy IO addresses will still not work (except if
they are on the first bus).

We still can decide (and that's what I currently do in the kernel) that
IO space is only supported on one of those 3 busses (the one on which the
external PCI is). This prevents however use of IOs on the AGP slot, which
is a problem for things like XFree who may try to use VGA addresses on
the card.

I still don't have a clue about a good solution to this issue. Apple
solves it in their kernel by having an object oriented bus structure,
each device asking for mappings to their parent bridge, based on the
device tree and independently of PCI bus numbers.

Ben.
