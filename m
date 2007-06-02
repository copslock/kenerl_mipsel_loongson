Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2007 07:50:12 +0100 (BST)
Received: from web94308.mail.in2.yahoo.com ([203.104.16.218]:9396 "HELO
	web94308.mail.in2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022044AbXFBGuJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 2 Jun 2007 07:50:09 +0100
Received: (qmail 9709 invoked by uid 60001); 2 Jun 2007 06:49:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=vWMmtScOjhU2aOM16aEtKAADrpfTKPLjA9T4f8WvBJ0awpVc9RYnqOBsSJjnLvuJ/VxAorbXQNHOzNqJbPK9+OHxu8SduV1j5hXXY7XUPD7TIjEZyEbYi9g/wVorpdQW8IMExyp4Rp24REXDPnR38Pp9JLHt+YtMHtl6u4dBuLU=;
X-YMail-OSG: hjyJSqgVM1kE7zIAUu2h6fVeKKKUqpd3lD8aIxB7
Received: from [59.92.35.197] by web94308.mail.in2.yahoo.com via HTTP; Sat, 02 Jun 2007 07:49:01 BST
Date:	Sat, 2 Jun 2007 07:49:01 +0100 (BST)
From:	saravanan sar <sar_van81@yahoo.co.in>
Subject: porting linux to DBau1200
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-47621698-1180766941=:6401"
Content-Transfer-Encoding: 8bit
Message-ID: <858843.6401.qm@web94308.mail.in2.yahoo.com>
Return-Path: <sar_van81@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sar_van81@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-47621698-1180766941=:6401
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,

has anyone successfully ported linux to DBau1200 board ? here i have problem in mounting root filesystem. i compiled the linux kernel and got the vmlinuz image and ported to the board also. but when i boots up it shows the following error:
YAMON> go
Linux version 2.6.11-r000069-smp (root@suse) (gcc version 3.4.4) #8 Wed May 30 19:22:16 IST 2007
CPU revision is: 04030201
AMD Alchemy Db1200 Board
(PRId 04030201) @ 396MHZ
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line:  video=au1200fb:panel:bs console=ttyS0,115200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 2048 (order: 11, 32768 bytes)
calculating r4koff... 00060ae0(396000)
Using 396.000 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255872k/262144k available (1894k kernel code, 6124k reserved, 337k data, 116k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
Au1XXX Real Time Clock Driver v1.0
audit: initializing netlink socket (disabled)
audit(120525897.203:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
au1200fb: LCD controller driver for AU1200 processors<6>
au1200fb: Panel 2 SVGA_800x600
au1200fb: Win 2 0-FS gfx, 1-video, 2-ovly gfx, 3-ovly gfx
Panel(SVGA_800x600), 800x600
Console: switching to colour frame buffer device 100x75
rtc: I/O resource 70 is not free.
Serial: Au1x00 driver
ttyS0 at I/O 0xb1100000 (irq = 0) is a AU1X00_UART
ttyS1 at I/O 0xb1200000 (irq = 8) is a AU1X00_UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
netconsole: not configured, aborting
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0).

. i searched in the google regarding this and found that this corresponds to root filesystem not found. 

can anyone provide me any suggestions or solutions for creating root filesystem and linking that with the kernel ?

thanks in advance,

saravanan.

       
---------------------------------
 Did you know? You can CHAT without downloading messenger.  Know how!
--0-47621698-1180766941=:6401
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,<br><br>has anyone successfully ported linux to DBau1200 board ? here i have problem in mounting root filesystem. i compiled the linux kernel and got the vmlinuz image and ported to the board also. but when i boots up it shows the following error:<br>YAMON&gt; go<br>Linux version 2.6.11-r000069-smp (root@suse) (gcc version 3.4.4) #8 Wed May 30 19:22:16 IST 2007<br>CPU revision is: 04030201<br>AMD Alchemy Db1200 Board<br>(PRId 04030201) @ 396MHZ<br>Determined physical RAM map:<br>&nbsp;memory: 10000000 @ 00000000 (usable)<br>Built 1 zonelists<br>Kernel command line:&nbsp; video=au1200fb:panel:bs console=ttyS0,115200<br>Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.<br>Primary data cache 16kB, 4-way, linesize 32 bytes.<br>Synthesized TLB refill handler (17 instructions).<br>Synthesized TLB load handler fastpath (34 instructions).<br>Synthesized TLB store handler fastpath (34 instructions).<br>Synthesized TLB modify handler fastpath (33
 instructions).<br>PID hash table entries: 2048 (order: 11, 32768 bytes)<br>calculating r4koff... 00060ae0(396000)<br>Using 396.000 MHz high precision timer.<br>Console: colour dummy device 80x25<br>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<br>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Memory: 255872k/262144k available (1894k kernel code, 6124k reserved, 337k data, 116k init, 0k highmem)<br>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<br>Checking for 'wait' instruction...&nbsp; unavailable.<br>NET: Registered protocol family 16<br>Au1XXX Real Time Clock Driver v1.0<br>audit: initializing netlink socket (disabled)<br>audit(120525897.203:0): initialized<br>VFS: Disk quotas dquot_6.5.1<br>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>Initializing Cryptographic API<br>au1200fb: LCD controller driver for AU1200 processors&lt;6&gt;<br>au1200fb: Panel 2 SVGA_800x600<br>au1200fb: Win 2 0-FS gfx, 1-video,
 2-ovly gfx, 3-ovly gfx<br>Panel(SVGA_800x600), 800x600<br>Console: switching to colour frame buffer device 100x75<br>rtc: I/O resource 70 is not free.<br>Serial: Au1x00 driver<br>ttyS0 at I/O 0xb1100000 (irq = 0) is a AU1X00_UART<br>ttyS1 at I/O 0xb1200000 (irq = 8) is a AU1X00_UART<br>io scheduler noop registered<br>io scheduler anticipatory registered<br>io scheduler deadline registered<br>io scheduler cfq registered<br>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize<br>netconsole: not configured, aborting<br>NET: Registered protocol family 2<br>IP: routing cache hash table of 2048 buckets, 16Kbytes<br>TCP established hash table entries: 16384 (order: 5, 131072 bytes)<br>TCP bind hash table entries: 16384 (order: 4, 65536 bytes)<br>TCP: Hash tables configured (established 16384 bind 16384)<br>NET: Registered protocol family 1<br>Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0).<br><br>. i searched in the google
 regarding this and found that this corresponds to root filesystem not found. <br><br>can anyone provide me any suggestions or solutions for creating root filesystem and linking that with the kernel ?<br><br>thanks in advance,<br><br>saravanan.<br><p>&#32;


      <hr size=1></hr> Did you know? You can CHAT without downloading messenger. <a href="http://us.rd.yahoo.com/mail/in/ywebmessenger1/*http://in.messenger.yahoo.com/webmessengerpromo.php"> Know how!</a>
--0-47621698-1180766941=:6401--
