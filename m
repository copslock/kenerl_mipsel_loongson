Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 21:55:37 +0000 (GMT)
Received: from dialin-145-254-134-254.arcor-ip.net ([IPv6:::ffff:145.254.134.254]:62981
	"HELO as5200-1-c13.rrz.Uni-Koeln.DE") by linux-mips.org with SMTP
	id <S8225358AbTLIVzg>; Tue, 9 Dec 2003 21:55:36 +0000
Received: (qmail 3266 invoked from network); 9 Dec 2003 22:03:51 -0000
Received: from localhost (HELO Morannon.nonet) (127.0.0.1)
  by localhost with SMTP; 9 Dec 2003 22:03:51 -0000
Date: Tue, 9 Dec 2003 23:03:51 +0100 (CET)
From: Rainer Canavan <rainer@canavan.de>
Reply-To: Rainer Canavan <rainer@canavan.de>
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
To: linux-mips@linux-mips.org
In-Reply-To: <3FD5FE41.8040909@bitbox.co.uk>
Message-ID: <ML-3.4.1071007431.886.canavan@morannon.nonet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-Path: <rainer@canavan.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rainer@canavan.de
Precedence: bulk
X-list: linux-mips

> Has anyone got a 2.4.23 kernel running on the Cobalt Qube 2 ?

Not on a Qube2, but on a nasraq, which is essentially the same, just
without the second ethernet port and the pci slot but a scsi port instead.
Last kernel I tried on my Qube2 seems to be 2.4.22-rc2.

Works fine, as far as I can tell.
 
> I've cross compiled the latest kernel from CVS (using the default Cobalt 
> config in the tree) on a PC using gcc 2.95.4 and binutils 2.12.90.0.1 
> (both from Debian sources).
 
For me, it's 2.95.4-15 and 2.12.90.0.9-1, and I'm compiling my kernels
natively.

> The kernel boots okay from the HD, but I get strange segmentation faults 
> and other errors whilst running Debian's "dpkg" to install packages. If 
> I repeat the installation from scratch I get exactly the same errors in 
> exactly the same places :-(

I just tried updating, removing and installing a package without 
any problems.
 
> I've changed both the memory SIMMs for new ones and the problem is still 
> the same. I've done the same Debian install on an Au1100 board with no 
> problems at all.
> 
> Neither of the on-board ethernet ports work correctly with new kernel 
> either. The primary port seems to work fine pinging single packets back 
> and forth, but seems to stall for periods of approx 20 seconds when 
> performing bulk transfers. I've been using an RTL8139 card in the PCI 
> slot for network access.

I haven't tried my Qube2 yet, since that one's already wrapped up and
ready for Karsten Merker to pick up - he's going to send it to the 
Tulip Expert, so those problems may go away soon, hopefully. As to 
kernel versions starting about 2.4.17, I've never had the tulip driver
running reliably on my Qube2, but always got at least 2.4.18 and later 
working properly on my nasRaq (there was some patching involved at times, 
if I recall correctly).

Rainer
