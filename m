Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 19:11:07 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:38959
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224827AbTFJSLF>; Tue, 10 Jun 2003 19:11:05 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19PnaG-0001v9-00; Tue, 10 Jun 2003 20:11:00 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19PnaG-0002dg-00; Tue, 10 Jun 2003 20:11:00 +0200
Date: Tue, 10 Jun 2003 20:11:00 +0200
To: mleopold@tiscali.dk
Cc: linux-mips@linux-mips.org
Subject: Re: Linux on Indigo2 (IP28) - R10000
Message-ID: <20030610181100.GB529@rembrandt.csv.ica.uni-stuttgart.de>
References: <3EDD28A400000B96@cpfe4.be.tisc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDD28A400000B96@cpfe4.be.tisc.dk>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

mleopold@tiscali.dk wrote:
> Hi All.
> I just got my hands on an old SGI Indigo2 and I would like to install Linux
> on it (preferably Debian). I've searched a few places and I get contradicting
> signals on whether this might work or not. The machine is an Indigo2 (IP28)
> 175MHz R10000.

I have such a machine, too. Short summary: It won't work yet.

> I've tried booting over the net using bootp and tftp following the instructionsin
> the debian-howto.. The machine gets an IP and immediately writes "execute
> format error" (using the r4k-ip22/tftpboot.img image). I'm guessing that
> this is and 32/64 bit problem, but I really haven't got a clue.

That's because the R10000 Firmware wnats only ELF64 objects.

> I found
> an other image looking like it might be a 64 bit image (from Kumba, the
> Gentoo guy), it downloads and then freezes the machine.
> 
> Can anybody give me some hints here: what I'm I suppose to do? Will this
> ever work? I don't really care about installation method (network, cd, etc).

Some SGI uniprocessor R10000 machines are non-I/O-coherent, specifically
the IP28 ans the IP32. The R10000 has a bug/performance feature which
leads to erraneously marked dirty cachelines, which wreaks havoc on those
machines for DMA transfers.

The solution is to use a special kernel with compiled in cache barriers
(needs a not-yet written compiler patch) and careful managing of page
table accesses from userspace (needs rmap, and thus 2.5 Kernel).

I'm working slowly on it, but I get constantly distracted by toolchain
issues. :-)

> There was some talk in Febuary on a guy got Linux up and running on an Origin
> 200 - and some bootable cd's. That sounded prety interesting =]

The Origin is easier to support, it has coherent I/O.

> Btw: I also got my hands on an Octane (IP30) with an R10000 (195 Mhz) -
> I haven't tried to install on this one, but that might be interesting too..

This one is also I/O coherent, so chances are much better than for IP28.


Thiemo
