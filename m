Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2007 21:38:35 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:24072 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023854AbXHWUi1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Aug 2007 21:38:27 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E711ED8C9; Thu, 23 Aug 2007 20:38:19 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4F0145437A; Thu, 23 Aug 2007 22:37:57 +0200 (CEST)
Date:	Thu, 23 Aug 2007 22:37:57 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Tulip driver broken on Cobalt RaQ1 in 2.6
Message-ID: <20070823203757.GA25971@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We have Debian users who happily used 2.4.27 on their Cobalt Raq1 and
Qube 2700.  However, since we moved to 2.6 these machines stopped
working.  I found out that the network driver (tulip) is no longer
working on these machines.  Today I tried to track down when this
started to happen but I couldn't find a 2.6 release where it actually
worked.

The 2.4.27 release we have is based on Peter Horton's patches from
http://www.colonel-panic.org/cobalt-mips/  Today I tested current git,
and 2.6.18 (which work out of the box), as well as 2.6.12-rc2 and
2.6.16-rc1 with Peter's patches.  In all of these releases, network
would work fine on a RaQ2, but not on a RaQ1.  I'm not sure what
information to report because I found nothing obvious.  In 2.4.27, we
get:

PCI: Enabling device 00:07.0 (0045 -> 0047)
tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute media control info.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0x100000, 00:10:E0:00:27:5C, IRQ 4.

wheras 2.6.16-rc1 has:

PCI: Enabling device 0000:00:07.0 (0041 -> 0043)
tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute media control info.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at b0001000, 00:10:E0:00:27:5C, IRQ 20.

The address is different but I doubt this makes a difference because the
RaQ2 shows the same difference and here networking works.  I also noticed
the following in the boot logs of the RaQ1 with 2.6 that doesn't happen
with 2.4, but that's because 2.4 doesn't have such a warning:

Galileo: revision 2
Galileo: PCI retry count exceeded (06.0)

Does anyone who knows about Cobalt hardware have any idea where to look?
I'm happy to send boot logs and test patches if someone wants to
investigate this problem.

-- 
Martin Michlmayr
http://www.cyrius.com/

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=raq1-git
Content-Transfer-Encoding: 8bit

Linux version 2.6.23-rc3-gb377fd39 (tbm@em64t) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #46 Thu Aug 23 09:06:46 UTC 2007
console [early0] enabled
CPU revision is: 00002810
FPU revision is: 00002810
Determined physical RAM map:
 memory: 03000000 @ 00000000 (usable)
Built 1 zonelists in Zone order.  Total pages: 12192
Kernel command line: console=ttyS0,115200 root=/dev/sda1
Primary instruction cache 16kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 16kB, 2-way, linesize 32 bytes.
Synthesized TLB refill handler (21 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 45080k/49152k available (2445k kernel code, 4056k reserved, 447k data, 96k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
SCSI subsystem initialized
Galileo: revision 2
Galileo: PCI retry count exceeded (06.0)
Cobalt board ID: 4
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Activating ISA DMA hang workarounds.
Cobalt LCD Driver v2.10
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ÿserial8250.0: ttyS0 at MMIO 0x1c800000 (irq = 21) is a ST16650V2
console handover: boot [early0] -> real [ttyS0]
loop: module loaded
Linux Tulip driver version 1.1.15 (Feb 27, 2007)
PCI: Enabling device 0000:00:07.0 (0041 -> 0043)
tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using substitute media control info.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21142/43 Tulip rev 65 at Port 0x1000, 00:10:E0:00:27:5C, IRQ 20.
PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1
pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)
PCI: Unable to reserve I/O region #3:8@f0000170 for device 0000:00:09.1
pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)
pata_via 0000:00:09.1: no available native port
physmap platform flash device: 00080000 at 1fc00000
Found: AMD AM29F040
physmap-flash.0: Found 1 x8 devices at 0x0 in 8-bit bank
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Using physmap partition information
Creating 1 MTD partitions on "physmap-flash.0":
0x00000000-0x00080000 : "firmware"
input: Cobalt buttons as /class/input/input0
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15

--ikeVEW9yuYc//A+q--
