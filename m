Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 14:31:07 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:20438 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024652AbXLCOa6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 14:30:58 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3003340095;
	Mon,  3 Dec 2007 15:30:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id fzxSSMXOw8hG; Mon,  3 Dec 2007 15:30:53 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id AFE1240003;
	Mon,  3 Dec 2007 15:30:53 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lB3EUv0Z011443;
	Mon, 3 Dec 2007 15:30:57 +0100
Date:	Mon, 3 Dec 2007 14:30:47 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: Rename Sibyte duart devices?
In-Reply-To: <20071203130818.GA6466@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0712031430050.19235@blysk.ds.pg.gda.pl>
References: <20071203130818.GA6466@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4980/Mon Dec  3 03:28:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 3 Dec 2007, Ralf Baechle wrote:

> Devices created by udev have been named duart? instead of the common
> ttyS?.  This is a nuisance because it requires changes to all sorts of
> config files such as /etc/inittab, /etc/securetty etc. to work.  I
> suggest to kill the problem by the root by something like the below
> patch.  Comments?

 Well, there is no problem with naming your device nodes in the filesystem
however you like and the only place that only cares is the "console="
command line option.  I think the root is ttyS devices should really be
only used for 8250-based devices and if you plug a standard PC serial
option card into one of the PCI slots, then all the hell will break loose.
I might be wrong though and the issue I am referring to may have gone now.

 [Sent twice to reach linux-serial.]

  Maciej
