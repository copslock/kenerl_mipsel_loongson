Received:  by oss.sgi.com id <S305160AbQCNLSF>;
	Tue, 14 Mar 2000 03:18:05 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54059 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCNLRl>; Tue, 14 Mar 2000 03:17:41 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA02507; Tue, 14 Mar 2000 03:21:02 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA87007
	for linux-list;
	Tue, 14 Mar 2000 03:08:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA91606
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Mar 2000 03:08:32 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA02668
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 03:08:30 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A02D07F6; Tue, 14 Mar 2000 12:08:25 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D09748FC3; Tue, 14 Mar 2000 12:04:30 +0100 (CET)
Date:   Tue, 14 Mar 2000 12:04:30 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: boot success 2.3.51 Decstation 5000/150 - no login via network possible
Message-ID: <20000314120430.A4321@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i am able to report boot success for 2.3.51 on a Decstation 5000/150 (R4000)

------------------------------------------------------
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes)
Primary data cache 8kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 32
Linux version 2.3.51 (root@193.189.250.44) (gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)) #1 Tue Mar 14 09:41:19 GMT 2000
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Calibrating delay loop... 49.81 BogoMIPS
Memory: 62316k/65536k available (1256k kernel code, 3220k reserved, 77k data, 56k init)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 12.5 MHz (no parity)
    slot 0: DEC      PMAZ-AA  V5.3d   
    slot 1: DEC      PMAZ-AA  V5.3b   
    slot 2: DEC      PMAF-FA  V1.1    
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Starting kswapd v1.6
DECstation Z8530 serial driver version 0.03
tty00 at 0xbc100001 (irq = 4) is a Z85C30 SCC
tty01 at 0xbc100009 (irq = 4) is a Z85C30 SCC
tty02 at 0xbc180001 (irq = 4) is a Z85C30 SCC
tty03 at 0xbc180009 (irq = 4) is a Z85C30 SCC
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
ESP: Total of 3 ESP hosts found, 3 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
scsi2 : ESP236 (NCR53C9x)
scsi : 3 hosts.
  Vendor: Quantum   Model: XP34300           Rev: L912
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: SEAGATE   Model: ST15150N          Rev: 8902
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
scsi : detected 2 SCSI disks total.
esp0: target 0 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sda: hdwr sector= 512 bytes. Sectors= 8399520 [4101 MB] [4.1 GB]
Partition check:
 sda: sda1 < sda5 sda6 sda7 sda8 sda9 sda10 >
esp0: target 2 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8388315 [4095 MB] [4.1 GB]
 sdb: sdb1 sdb2
declance.c: v0.008 by Linux Mips DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:28:f0:a3, irq = 3
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 193.189.250.46, my address is 193.189.250.44
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused PROM memory: 124k freed
Freeing unused kernel memory: 56k freed
Adding Swap: 130748k swap-space (priority -1)
------------------------------------------------------


The same problem as 2.3.47 and up applies - I am not able to 
log in anymore over network to that machine ..

---------------------------------------------------------
(flo@ping)~# telnet repeat.rfc822.org
Trying 193.189.250.44...
Connected to repeat.rfc822.org.
Escape character is '^]'.

Red Hat Linux release 6.0 (DECStation)
Kernel 2.3.51 on a mips
Connection closed by foreign host.
(flo@ping)~# ssh -v -l root repeat.rfc822.org
SSH Version 1.2.26 [i586-unknown-linux], protocol version 1.5.
Standard version.  Does not use RSAREF.
ping: Reading configuration data /etc/ssh/ssh_config
ping: ssh_connect: getuid 1000 geteuid 0 anon 0
ping: Connecting to repeat.rfc822.org [193.189.250.44] port 22.
ping: Allocated local port 1022.
ping: Connection established.
ping: Remote protocol version 1.5, remote software version 1.2.27
ping: Waiting for server public key.
ping: Received server public key (768 bits) and host key (1024 bits).
ping: Host 'repeat.rfc822.org' is known and matches the host key.
ping: Initializing random; seed file /home/flo/.ssh/random_seed
ping: Encryption type: idea
ping: Sent encrypted session key.
ping: Installing crc compensation attack detector.
ping: Received encrypted confirmation.
ping: Trying rhosts or /etc/hosts.equiv with RSA host authentication.
ping: Server refused our rhosts authentication or host key.
ping: Connection to authentication agent opened.
ping: RSA authentication using agent refused.
ping: Trying RSA authentication with key 'flo@move'
ping: Server refused our key.
ping: Doing password authentication.
root@repeat.rfc822.org's password: 
ping: Requesting pty.
ping: Requesting X11 forwarding with authentication spoofing.
ping: Remote: Client requested X11 forwarding, but the server has no xauth program.
ping: Remote: This is usually caused by "xauth" not being in PATH during compile.
Warning: Remote host denied X11 forwarding, perhaps xauth program could not be run on the server side.
ping: Requesting authentication agent forwarding.
ping: Requesting shell.
ping: Entering interactive session.
Connection to repeat.rfc822.org closed by remote host.
Connection to repeat.rfc822.org closed.
ping: Transferred: stdin 0, stdout 0, stderr 97 bytes in 0.2 seconds
ping: Bytes per second: stdin 0.0, stdout 0.0, stderr 515.5
ping: Exit status -1
---------------------------------------------------------


Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
