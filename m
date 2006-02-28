Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 21:34:21 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:25604 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133627AbWB1VeL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 21:34:11 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A59F964D3D; Tue, 28 Feb 2006 21:41:52 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5D43B81F5; Tue, 28 Feb 2006 22:41:44 +0100 (CET)
Date:	Tue, 28 Feb 2006 21:41:44 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: MIPS kernel status as of 2.6.16-rc5
Message-ID: <20060228214144.GA6615@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I did some tests with 2.6.16-rc5 on a number of platforms and here's
a status report.

Problems first. ;-)

Generic:
 - The iomap patch is not in the mips-linux tree yet.  Needs support for
   multiple PCI busses (as well for non-PCI busses?), see discussion at
   http://www.linux-mips.org/archives/linux-mips/2005-02/msg00023.html
   http://www.linux-mips.org/archives/linux-mips/2005-11/msg00124.html
   http://www.linux-mips.org/archives/linux-mips/2006-01/msg00172.html
   http://www.linux-mips.org/archives/linux-mips/2006-01/msg00232.html

Cobalt:
 - >2 min delay probing for hard drives.  The following patch still
   needs to be applied by Ralf:
   http://www.linux-mips.org/archives/linux-mips/2006-02/msg00218.html
 - The IDE/network interaction crash has been greatly improved by
   http://marc.theaimsgroup.com/?l=linux-netdev&m=114030066124134&w=2
   but is not 100% gone.  Nobody on netdev commented on the patch yet.
 - Possible corruption with USB (regression from 2.4) but I have
   not had a chance to reproduce this yet; possibly related to
   64-bit.  Will ask bug reporter to test with a 32-bit kernel.
   http://lists.debian.org/debian-mips/2006/02/msg00095.html

Cobalt (64-bit):
64-bit has a number of problems.  Peter Horton says "What surprises me
is that all the problems appear to be timing related rather than 32/64
bit portability issues. Maybe this is 'cos the RM5231 has such small
caches; doubling the size of all the kernel's pointers probably impacts
us badly and slows everything down."

 - Tulip driver thinks MAC address on Qube 2700 is "ff:ff:ff:ff:ff:ff"
 - Tulip driver needs fix from Grant Grundler that has been nacked by
   Jeff Garzik.
 - PCI audio with ALSA doesn't work.  In the past it failed with:
   http://www.linux-mips.org/archives/linux-mips/2006-01/msg00325.html
   now we get:
   http://www.linux-mips.org/archives/linux-mips/2006-02/msg00413.html

SGI:
 - IP22 doesn't shutdown due to a oops in the serial driver.  Patch at
   http://www.linux-mips.org/archives/linux-mips/2006-02/msg00391.html
 - IP22: Indigo2 with > 256 MB fails to boot (regression from 2.4;
   while 2.4 would only see 256 MB, it would at least boot)
 - IP22: VINO support is broken on 64-bit:
   http://www.linux-mips.org/archives/linux-mips/2006-02/msg00414.html
 - IP32: Apparently O2 with 384 MB RAM doesn't load, see
   http://lists.debian.org/debian-mips/2006/02/msg00031.html
   Kumba said IP32 works "only, it seems, on multiples like 64, 128, 256,
   and 512, based on issues we've seen gentoo-side"
 - IP32: FB doesn't work when you use > 4 MB RAM for it.

Broadcom:
 - The duart driver for SWARM is not in mainline anymore; a regression
   from 2.4.
 - Apparently USB hid is broken (says p2); a regression from 2.4.
 - There are a number of time related problems; patches available:
    - gettimeofday jumps backwards then forwards (generic plus SB1250)
      http://www.linux-mips.org/archives/linux-mips/2005-07/msg00295.html
    - fix lost ticks on SB1250
      http://www.linux-mips.org/archives/linux-mips/2006-01/msg00144.html
    - bcm1480 doubled process accounting times
      http://www.linux-mips.org/archives/linux-mips/2006-02/msg00404.html
 - Minor feature updates to the BCM1250/BCM1480 header files
   http://www.linux-mips.org/archives/linux-mips/2006-02/msg00217.html
 - bcm1x80: while 4 CPUs are found, Bogomips are never displayed.  So
   maybe something with the recent SMP change is still not 100% right.
   [Actually, it seems this is not reported in non-SMP either]
 - bcm1x80: PCI DMA seems completely broken.


What works:

Cobalt (32-bit):
 - boots
 - loading an initrd works (needs CoLo 1.21)
 - PCI works: SCSI, USB, audio and network tested

SGI IP22:
 - boots
 - loading of initrd image generated by tip22 works
 - HAL2 (sound) works, but driver should be converted to ALSA
 - VINO: supposedly works with a 32-bit kernel
 - fb: unknown

SGI IP32:
 - boots
 - loading of initrd image generated by tip32 works
 - fb works (with 4 MB)

Broadcom SWARM (1250):
 - boots
 - loading an initrd works
 - IDE works

-- 
Martin Michlmayr
http://www.cyrius.com/
