Received:  by oss.sgi.com id <S42252AbQI2UCe>;
	Fri, 29 Sep 2000 13:02:34 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:24590 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42239AbQI2UCL>;
	Fri, 29 Sep 2000 13:02:11 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 20D837F5; Fri, 29 Sep 2000 22:02:09 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 93E519014; Fri, 29 Sep 2000 22:01:03 +0200 (CEST)
Date:   Fri, 29 Sep 2000 22:01:03 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000929220103.A396@paradigm.rfc822.org>
References: <20000928214002.B767@paradigm.rfc822.org> <Pine.GSO.3.96.1000929112103.16748A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.GSO.3.96.1000929112103.16748A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Sep 29, 2000 at 11:36:07AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 29, 2000 at 11:36:07AM +0200, Maciej W. Rozycki wrote:
>  OK, the /240 is definitely tested (the uptime of my -test7 was three
> weeks before I rebooted to test NFS problems) so /260 should work for you. 
> But the latter is R4K.  As Ralf already remarked me in a separate mail,
> 64-bit registers can get corrupted for the 32-bit kernel (but 64-bit code
> is used throughout the kernel, strange), so please change the "#if
> _MIPS_ISA" at the beginning of include/asm-mips/div64.h into "#if 1" and
> tell me if it works for the /260. 

Sorry for the confusion - It seems i was inaccurate - I tried on
the /260 and it works ... See attached - Ill retry the /125 in a minute.

Loading R4000 MMU routines.
CPU revision is: 00000440
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #1 Fri Sep 29 19:45:47 GMT 2000
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS2 root=/dev/sda5
Calibrating delay loop... 59.90 BogoMIPS
Memory: 62736k/65536k available (1204k kernel code, 2800k reserved, 76k data, 56k init)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 25.0 MHz (no parity)
    slot 0: DEC      PMAF-AA  T5.2P-  
    slot 1: DEC      PMAZ-AA  V5.3d   
    slot 2: DEC      PMAZ-AA  V5.3d   
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Starting kswapd v1.7
pty: 256 Unix98 ptys configured
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
ESP: Total of 3 ESP hosts found, 3 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
scsi2 : ESP236 (NCR53C9x)
scsi : 3 hosts.
esp0: hoping for msgout
  Vendor: IBM       Model: DGHS18Z           Rev: 03B0
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: DEC       Model: RZ23L    (C) DEC  Rev: 2528
  Type:   Direct-Access                      ANSI SCSI revision: 01 CCS
Detected scsi disk sdb at scsi0, channel 0, id 3, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 35843670 [17501 MB] [17.5 GB]
Partition check:
 sda: sda1 < sda5 sda6 sda7 sda8 sda9 >
esp0: target 3 [period 252ns offset 8 3.96MHz synchronous SCSI]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 237588 [116 MB] [0.1 GB]
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8
DECstation Z8530 serial driver version 0.03
tty00 at 0xbf900001 (irq = 4) is a Z85C30 SCC
tty01 at 0xbf900009 (irq = 4) is a Z85C30 SCC
tty02 at 0xbf980001 (irq = 4) is a Z85C30 SCC
tty03 at 0xbf980009 (irq = 4) is a Z85C30 SCC
rtc: Digital DECstation epoch (2000) detected
Real Time Clock Driver v1.10d
declance.c: v0.008 by Linux Mips DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:2b:be:bc, irq = 3


-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
