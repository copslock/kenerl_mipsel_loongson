Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA30856
	for <pstadt@stud.fh-heilbronn.de>; Tue, 6 Jul 1999 00:37:35 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA16307; Mon, 5 Jul 1999 15:35:24 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA64411
	for linux-list;
	Mon, 5 Jul 1999 15:32:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA82341
	for <linux@engr.sgi.com>;
	Mon, 5 Jul 1999 15:32:42 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03108
	for <linux@engr.sgi.com>; Mon, 5 Jul 1999 15:32:04 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA09763
	for <linux@engr.sgi.com>; Tue, 6 Jul 1999 00:31:58 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA07089;
	Tue, 6 Jul 1999 00:31:23 +0200
Date: Tue, 6 Jul 1999 00:31:23 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Eric Jorgensen <alhaz@xmission.com>
Cc: "R.Charles Sweeten" <alpha@rasgroup.rasgroup.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Tandem 4440/A ??
Message-ID: <19990706003123.D6351@uni-koblenz.de>
References: <Pine.LNX.3.93.990705084553.17554A-100000@rasgroup.rasgroup.com> <3780F4D5.D9ACE8B3@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3780F4D5.D9ACE8B3@xmission.com>; from Eric Jorgensen on Mon, Jul 05, 1999 at 12:09:25PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 05, 1999 at 12:09:25PM -0600, Eric Jorgensen wrote:

> here with my own server on a T1 colocated at a company i work for, so I
> should go ahead and start a "Linux/Mips on Jazz/ARC Hardware" home page,
> if nobody else has one in the works already. Of course, it'd be cooler
> if i were running it on a Magnum, instead of a Sparc 2. Or if i had
> Linux running on my Magnum at all . . . . . 

Linux works just fine in little endian mode on Magnum 4000.  The big
endian mode uses the same partitioning scheme like IRIX which we
purely coincidentaly happen to support :-)

fdisk has some not too great support for creating Mips Disk Volume
Headers in current versions.  I've just written half of dvhtools and
in the same washup will rewrite a free version of fx.

> Jazz platform machines are bi-endian, being able to boot into either NT
> or RISCos. If yours is in big-endian mode and boots to an SRM console
> once you've got it hooked up to some video and a keyboard, you will need
> to switch the system into little-endian mode. on the Magnum this
> involves using a disk to load the ARC console into the boot prom, and
> the Magnum disk may or may not work in your system. You'll know SRM by
> the sinking feeling of futility generally associated with it. It's
> designed to mount a BSD filesystem and launch the OS, and I don't know
> if anybody has managed to get Linux/Mips to boot from SRM. It may well
> be possible, since Linux/Alpha is now booting correctly from the similar
> SRM console on AXP systems. 

It's actually fairly easy to get Linux running on that old Mips firmware.
For the most part of it you can just ignore it's existence.  For the
rest of it I can send you actual code :-)

I hope all that sounds at least somewhat attrative to somebody to
actually complete the big endian port.  Myself and if necessary hopefully
a couple of MIPS RISC/os engineers as well can help if necessary :-)

> To make things more confusing, Alpha and Mips both have both SRM and
> ARC consoles available, and both call their boot loader MiLo. 

We don't use Milo anymore on the little endian ARC machines.

  Ralf
