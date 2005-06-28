Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 13:25:26 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:725 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226044AbVF1MZH>; Tue, 28 Jun 2005 13:25:07 +0100
Received: from dagger.cc.vt.edu (IDENT:mirapoint@[10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j5SCNq2L015029;
	Tue, 28 Jun 2005 08:24:02 -0400
Received: from [192.168.1.2] (68-232-96-93.chvlva.adelphia.net [68.232.96.93])
	by dagger.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DOB10516 (AUTH spbecker);
	Tue, 28 Jun 2005 08:23:46 -0400 (EDT)
Message-ID: <42C14151.5050209@gentoo.org>
Date:	Tue, 28 Jun 2005 08:23:45 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050625)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Markus Dahms <mad@automagically.de>
CC:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
References: <20050627100757.GA27679@gaspode.automagically.de> <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl> <20050627141842.GA28236@gaspode.automagically.de> <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl> <20050628062107.GA8665@gaspode.automagically.de> <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl> <20050628102013.GA10442@gaspode.automagically.de>
In-Reply-To: <20050628102013.GA10442@gaspode.automagically.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips


> [R4600 tlbex.c patch]
> 
> This doesn't seem to be enough. The patch applies almost cleanly on
> current CVS (offset -1 line), but the resulting kernel (I tried 64
> and 32-bit) still stops after "INIT: ...".
> 

This might be a good time to mention that cvs HEAD seems to have serious
problems with 64-bit ip22 kernels (at least on r5000 systems...I don't
have a working r4x00 box to test with), and it may be contributing to
your problems.  Basically, numerous messages about vmalloc dump to the
kernel log while doing a number of things disk related:

allocation failed: out of vmalloc space - use vmalloc=<size> to increase
size.

Symptons include ricerfs partitions not being able to mount (ext3 seems
to work, but still triggers the vmalloc error message), swapon failing
to turn the swap partition on, dd having major problems when dumping
large blocks, etc.  The initial probing of the scsi controller at boot
time also triggers the message.

I haven't tried a 32-bit kernel since 2.6.12_rc2 or so, however when I
did, everything seemed to work just fine, while a 64-bit kernel compiled
from the same checkout had the same problems I mention above.  At one
point I was trying to work out when this was introduced, and I *think*
it was the initial 2.6.11 merge, but I would have to double check that.
 I've been running a 64-bit 2.6.10 checkout since the beginning of the
year on that box, and the machine has been very stable.

-Steve
