Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 23:29:43 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:4102 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S3467599AbWBMX3d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2006 23:29:33 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0E3C664D3D; Mon, 13 Feb 2006 23:35:51 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9AB7A82BB; Mon, 13 Feb 2006 23:35:45 +0000 (GMT)
Date:	Mon, 13 Feb 2006 23:35:45 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Peter 'p2' De Schrijver <p2@mind.be>,
	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060213233545.GA8892@deprecation.cyrius.com>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl> <20060213232704.GA8360@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213232704.GA8360@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-13 23:27]:
> Apparently it boots with current git and your fix.  I think p2 will
> confirm later.

Here's the boot log from p2:


>>boot 3/tftp/vmlinux-pmax console=ttyS2

-tftp boot(3), bootp 10.42.0.190:/tftpboot/vmlinux-pmax
-tftp load 2986117+0+118683
Linux version 2.6.16-rc3 (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #3 Mon Feb 13 22:40:31 GMT 2006
This is a DECstation 5000/2x0
CPU revision is: 00000230
FPU revision is: 00000340
Determined physical RAM map:
 memory: 0c000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: console=ttyS2
Primary instruction cache 64kB, linesize 4 bytes.
Primary data cache 64kB, linesize 4 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (25 instructions).
PID hash table entries: 1024 (order: 10, 16384 bytes)
Using 25.000 MHz high precision timer.
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 191488k/196608k available (2350k kernel code, 5044k reserved, 417k data, 148k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
SCSI subsystem initialized
TURBOchannel rev. 1 at 25.0 MHz (without parity)
    slot 0: DEC      PMAZ-AA  V5.3d
    slot 1: DEC      PMAGB-BA V1.0
    slot 2: DEC      PMAG-BA  V5.3a
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
fb0: PMAG-BA frame buffer device in slot 2
fb1: PMAGB-BA frame buffer device in slot 1
fb1: Osc0: 130.808MHz, Osc1: disabled, Osc0 selected
DECstation Z8530 serial driver version 0.09
ttyS00 at 0xbf900001 (irq = 14) is a Z85C30 SCC
ttyS01 at 0xbf900009 (irq = 14) is a Z85C30 SCC
ttyS02 at 0xbf980001 (irq = 15) is a Z85C30 SCC
ttyS03 at 0xbf980009 (irq = 15) is a Z85C30 SCC
rtc: Digital DECstation epoch (2000) detected
Real Time Clock Driver v1.12a
declance.c: v0.009 by Linux MIPS DECstation task force
declance0: IOASIC onboard LANCE, addr = 08:00:2b:38:72:b4, irq = 16
declance0: registered as eth0.
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
ESP: Total of 2 ESP hosts found, 2 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "<NULL>" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)

(He didn't specify root= so that's fine)
-- 
Martin Michlmayr
http://www.cyrius.com/
