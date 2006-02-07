Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 02:52:49 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:1451 "EHLO
	rwcrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S3466525AbWBGCwj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Feb 2006 02:52:39 +0000
Received: from [192.168.1.4] (unknown[69.140.185.48])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20060207025807m11005t8ire>; Tue, 7 Feb 2006 02:58:11 +0000
Message-ID: <43E80CC5.5090805@gentoo.org>
Date:	Mon, 06 Feb 2006 21:58:13 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: R10K/R12K Based O2's
References: <43DAFEFE.8060009@gentoo.org>
In-Reply-To: <43DAFEFE.8060009@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Round 2:

Discovered I'd built my IP32 R10K kernel with:
	A) An older version of Peter Fuerst's R10K Cache Barriers Patch
	B) Did a code change in the above patch that generated less
	   cache barriers instead of more

So I've re-done everything, and now have a kernel for IP32 R10K (and R12K) that 
uses the latest gcc cache barriers patch available on the IP28 site w/ the one 
code change that generates more cache barriers (See below for details).

It seems with the gcc patch and the stripped IP28 patch, a working IP32 R10K 
kernel can be produced that seems to handle itself very well.  It occasionally 
spits out CRIME CPU errors, and in my case, I've triggered two Oopses 
(non-fatal).  It seems the network adapter doesn't seem to trigger the 
speculative execution bug too much (which I believe is indicated by the CRIME 
CPU errors), however the scsi driver definitely causes them to appear every so 
often.

Patches and other misc. files available here:
http://dev.gentoo.org/~kumba/mips/netboot/testing/ip32/r10k/

Included there is a 2.6.15.2 kernel, the kernel patch, the gcc patch, the kernel 
disassembly (71MB whopper unpacked), and the cpio archive containing the netboot 
userland (this is actually 5-6 cpio archives slapped together with 'cat', but 
the kernel handles it just fine), and the md5/sha1 sums to verify against.

To boot:
bootp(): console=ttyS0,<baud>  (gbefb seems to not respond on these systems)
Initramfs should take over and load a mini netboot userland.  Has basic 
capabilities, and supports a few fs'es (xfs, ext2/3, no reiser/jfs, etc)


Stats:

# uname -a
Linux netboot-2006.0 2.6.15.2-mipsgit-20060109 #2 Sun Feb 5 19:28:36 EST 2006 
mips64 R10000 V2.6  FPU V0.0 SGI O2 GNU/Linux

# uptime
21:54:14 up 1 day,  2:23, load average: 2.01, 2.02, 2.00

Currently, it's building gcc-3.4.5 as I type this, using the disk for everything 
but swap.  There are some caveats, though, which are outlined below:


The Errors (Just a sample, and in no specific order):
CRIME CPU error at 0x00f73b850 status 0x00000004
CRIME CPU error at 0x01005fcc0 status 0x00000004
CRIME CPU error at 0x005a8b810 status 0x00000004
CRIME CPU error at 0x005a8b850 status 0x00000004
CRIME CPU error at 0x007bd7850 status 0x00000004
CRIME CPU error at 0x00802f850 status 0x00000004
CRIME CPU error at 0x003b0b850 status 0x00000004
CRIME CPU error at 0x00e33f850 status 0x00000004
CRIME CPU error at 0x00a1df850 status 0x00000004

If anyone has an idea just what those hex addresses are referencing, or what 
exact is the meaning of that status bit, I'd be curious to know.


The Oopses:
http://dev.gentoo.org/~kumba/mips/netboot/testing/ip32/r10k/ip32r10k-26152-oops1.txt
http://dev.gentoo.org/~kumba/mips/netboot/testing/ip32/r10k/ip32r10k-26152-oops2.txt

These seem similar to the old MC Bus Errors I hit when toying around in the 
early days of IP28 support.  They've pretty much vanished now since Peter wrote 
up the new IP28 bus error handler.  So whether this are the same or not is 
anyone's guess -- if so, I imagine there's some degree of fixups that can be 
done to IP32's bus error handler to take care of these.  But that's just pure 
speculation on my part.


Read the README file there too -- it's got some small /proc tweaks that, at a 
first glance, help the kernel to avoid touching the disk too often by turning 
off swap entirely and setting two other small vm settings.



--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
