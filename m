Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2004 02:05:22 +0000 (GMT)
Received: from mail006.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.63]:12690
	"EHLO mail006.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8224936AbUAKCFV>; Sun, 11 Jan 2004 02:05:21 +0000
Received: from korath.adamsrealm.net.au (c210-49-87-133.rochd3.qld.optusnet.com.au [210.49.87.133])
	by mail006.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i0B25F620960
	for <linux-mips@linux-mips.org>; Sun, 11 Jan 2004 13:05:16 +1100
From: Adam Nielsen <a.nielsen@optushome.com.au>
To: linux-mips@linux-mips.org
Subject: Re: Running Linux on an NCD HMX X-Terminal
Date: Sun, 11 Jan 2004 12:04:23 +1000
User-Agent: KMail/1.5
References: <200401101240.i0ACePX01584@mwave.heeltoe.com>
In-Reply-To: <200401101240.i0ACePX01584@mwave.heeltoe.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401111204.23752@korath>
Return-Path: <a.nielsen@optushome.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@optushome.com.au
Precedence: bulk
X-list: linux-mips

> I brought up linux on the PPC403 version of an NCD x-terminal.  As I recall
> I had to write program to hack the elf header to get kernels to load.
> The project is at http://sourceforge.net/projects/explora-linux/

Hmm...this looks interesting!

> You may get lucky and find they used the same format for MIPS...

Well I am hopeful, given that they use the same manual for the HMX and the 
Explora, but running ncdhack on the kernel didn't seem to have any effect :-(

I did try some fiddling with the ELF files, just to see what would happen (but 
not having any experience with this, I was just guessing ;-))  The load 
address for the proper boot image is 0x40020000 but the kernel is 0x88002000 
which I think is partly why it doesn't work.  If I shrink the ELF file a 
little by removing a couple of the sections (by telling objcopy to ignore 
them) *and* I change the load address to 0x40020000 then the xterm actually 
downloads the image but then gives a "File corrupted CRC error" just as it 
goes to boot it.

I'm not sure why that happens, because manipulating the file properly with 
objcopy should adjust any CRC checksums accordingly.  I wonder whether the 
xterm is checking that the image is 'official'?

Cheers,
Adam.
