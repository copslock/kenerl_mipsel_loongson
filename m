Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GGtVRw005765
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 09:55:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GGtVMJ005764
	for linux-mips-outgoing; Tue, 16 Jul 2002 09:55:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GGt4Rw005700
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 09:55:04 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.11.6) with ESMTP id g6GGxwb05310;
	Tue, 16 Jul 2002 18:59:58 +0200
Received: (from karel@localhost)
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) id SAA17040;
	Tue, 16 Jul 2002 18:59:58 +0200 (MET DST)
From: Karel van Houten <karel@kpn.com>
Message-Id: <200207161659.SAA17040@sparta.research.kpn.com>
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Tue, 16 Jul 2002 18:59:58 +0200 (MET DST)
Cc: vhouten@kpn.com ("Houten K.H.C. van (Karel)"), linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020716153355.20654M-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Jul 16, 2002 03:41:53 PM
X-Url: http://www-lsdm.research.kpn.com/~karel
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Maciej,

You wrote:
> 
> On Mon, 15 Jul 2002, Houten K.H.C. van (Karel) wrote:
> 
> > I'm currently experimenting with software raid support on my decstation,
> > and it looks fine! But I would love to use more than one SCSI chain
> > for my raid disks. My DECStation contains a Turbochannel PMAZ-AA
> > SCSI card, which WAS once supported in the driver, but isn't anymore. :-(
> 
>  That's basically the same as the /200's onboard SCSI.  If that works, why
> wouldn't an additional card (yup, I know the SCSI driver is a mess...)?
> 
>  [Looking at the sources...]  The driver seems to have all necessary bits
> to support additional HBAs.  What do you mean by "not supported anymore?" 
> What does it report for PMAZ-AA cards?

Usually I get SCSI bus problems when using the second chain.
Even with devices that don't give any problems when connected to
the on-board bus. Here is my boot log, with the scsi errors.
In this case, I could use the disk on esp1, but I don't know
if I can trust this...

KN05 V2.1k
>>cnfg
 3: KN05     DEC      V2.1k    TCF0  (256 MB)
                                     (enet: 08-00-2b-37-63-76)
                                     (SCSI = 7)
 1: PMAZ-AA  DEC      V5.3d    TCF0  (SCSI = 7)
>>cnfg 1
 1: PMAZ-AA  DEC      V5.3d    TCF0  (SCSI = 7)
    ---------------------------------------------------
    DEV   PID                VID        REV    SCSI DEV
    ===== ================== ========== ====== ========
    rz1   C2490A             COMPAQ     5193   DIR

>>cnfg 3
 3: KN05     DEC      V2.1k    TCF0  (256 MB)
                                     (enet: 08-00-2b-37-63-76)
                                     (SCSI = 7)
            ---------------------------------------------------
            DEV   PID                VID        REV    SCSI DEV
            ===== ================== ========== ====== ========
            rz0   DCHS04U            IBM        6464   DIR
            rz1   C2490A             COMPAQ     5193   DIR
            rz2   C2490A             COMPAQ     5193   DIR
            rz3   C2490A             COMPAQ     5193   DIR
            rz4   C2490A             COMPAQ     5193   DIR
            rz5   C2490A             COMPAQ     5193   DIR
            rz6   CD-ROM CDU-55S     SONY       1.0t   CD-ROM

        cache: I(16 KB), D(16 KB), S(1024 KB);  Scache line (32 bytes)
        processor revision (4.0)
        mem( 0):  a0000000:a1ffffff  ( 32 MB)
        mem( 1):  a2000000:a3ffffff  ( 32 MB)
        mem( 2):  a4000000:a5ffffff  ( 32 MB)
        mem( 3):  a6000000:a7ffffff  ( 32 MB)
        mem( 4):  a8000000:a9ffffff  ( 32 MB)
        mem( 5):  aa000000:abffffff  ( 32 MB)
        mem( 6):  ac000000:adffffff  ( 32 MB)
        mem( 7):  ae000000:afffffff  ( 32 MB)

>>boot
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok
Loading /boot/vmlinux-2.4.18 ....... ok
This DECstation is a DS5000/2x0
CPU revision is: 00000440
FPU revision is: 00000500
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.18 (root@elrond) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110.1)) #12 Mon Jul 1 18:07:40 MEST 2002
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1 console=ttyS2 ro
Calibrating delay loop... 59.86 BogoMIPS
Memory: 255572k/262144k available (1804k kernel code, 6572k reserved, 108k data, 76k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 25.0 MHz (without parity)
    slot 1: DEC      PMAZ-AA  V5.3d
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
lk201: DECstation LK keyboard driver v0.05.
pty: 256 Unix98 ptys configured
DECstation Z8530 serial driver version 0.07
ttyS00 at 0xbf900001 (irq = 14) is a Z85C30 SCC
ttyS01 at 0xbf900009 (irq = 14) is a Z85C30 SCC
ttyS02 at 0xbf980001 (irq = 15) is a Z85C30 SCC
rtc: Digital DECstation epoch (2000) detected
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
declance.c: v0.009 by Linux MIPS DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:37:63:76, irq = 16
SCSI subsystem driver Revision: 1.00
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
ESP: Total of 2 ESP hosts found, 2 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
esp0: AIEEE wide msg received
esp0: hoping for msgout
  Vendor: IBM       Model: DCHS04U           Rev: 6464
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SONY      Model: CD-ROM CDU-55S    Rev: 1.0t
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
Attached scsi disk sdg at scsi1, channel 0, id 1, lun 0
SCSI device sda: 8813870 512-byte hdwr sectors (4513 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
esp0: target 1 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdb: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1
esp0: target 2 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdc: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1
esp0: target 3 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdd: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target3/lun0: p1
esp0: target 4 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sde: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target4/lun0: p1
esp0: target 5 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdf: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target5/lun0: p1
scsi : aborting command due to timeout : pid 52, scsi1, channel 0, id 1, lun 0 Request Sense 00 00 00 40 00
esp1: Aborting command
esp1: dumping state
esp1: SW [sreg<00> sstep<04> ireg<20>]
esp1: HW reread [sreg<06> sstep<c1> ireg<00>]
esp1: current command [tgt<01> lun<00> pphase<UNISSUED> cphase<SLCTMSG>]
esp1: disconnected
SCSI host 1 abort (pid 52) timed out - resetting
SCSI bus is being reset for host 1 channel 0.
esp1: Resetting scsi bus
esp1: Gross error sreg=40
esp1: SCSI bus reset interrupt
esp1: Warning, live target 1 not responding to selection.
esp1: Warning, live target 1 not responding to selection.
SCSI device sdg: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host1/bus0/target1/lun0: p1 p2
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
esp0: target 6 [period 248ns offset 15 4.03MHz synchronous SCSI]
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused PROM memory: 124k freed
Freeing unused kernel memory: 76k freed
INIT: version 2.84 booting


Thanks for your time...
Regards,

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
