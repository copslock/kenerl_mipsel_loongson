Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA75736 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 Jan 1999 21:30:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA43446
	for linux-list;
	Fri, 8 Jan 1999 21:29:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from interceptor.dallas.sgi.com (interceptor.dallas.sgi.com [169.238.83.8])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id VAA43292
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 Jan 1999 21:29:24 -0800 (PST)
	mail_from (chad@interceptor.dallas.sgi.com)
Received: (from chad@localhost) by interceptor.dallas.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id XAA07697 for linux@cthulhu.engr.sgi.com; Fri, 8 Jan 1999 23:29:22 -0600
Date: Fri, 8 Jan 1999 23:29:22 -0600
From: chad@interceptor.dallas.sgi.com (Chad Carlin)
Message-Id: <9901082329.ZM7695@interceptor.dallas.sgi.com>
X-Face: P(s*X,{I4`'Goul%w"/z0O?@)\1V_OVBwR&fS|G#K6Y0T!_p$OBn7zt]eI*qFZjoi%</xsi
                                                                                                                                                                                                                                                                                                                                                                                                                                                     )XwjZ@%pL*xmo^Xa/g{-K3%WxseH!=PFNt6`vW5vAM2f7u_dR,#KZLfc@?R>q>:f8z$'~+kK<3@uFL
                                                                                                                                                                                                                                                                                                                                                                                                                                                     n]WY@:QD7
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: boot vmlinux trouble
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Sorry this is a little long but I thought it would be best to give you as much information as I could.

Thanks in advance.
Chad

It appears that I am getting the kernel to boot OK. It seems that I am having problems with NFS. Can you tell from this info what might be wrong with my config. 


>> boot bootp():vmlinux
130768+22320+3184+341792+48560d+4604+6816 entry: 0x8bfa60d0
Obtaining vmlinux from server marvin2
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 65814528 bytes (64272K,62MB)
ARCH: SGI-IP22
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes)
Primary data cache 16kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
Linux version 2.1.100 (root@alex3.med.iacnet.com) (gcc version 2.7.2) #29 Thu Jul 9 22:19:39 EDT 1998
MC: SGI memory controller Revision 3
calculating r4koff... 000f443e(1000510)
zs0: console input
zs0: console I/O
Calibrating delay loop... 99.94 BogoMIPS
Memory: 60364k/196116k available (1216k kernel code, 2684k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Starting kswapd v 1.5 
Adv: about to run setup()
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
Ramdisk driver initialized : 16 ramdisks of 4096K size
loop: registered device at major 7
WD93: Driver version 1.25 compiled on Jul  7 1998 at 16:59:57
 debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE ST31200N  Rev: 9278
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 3, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4226725 [2063 MB] [2.1 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2077833 [1014 MB] [1.0 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:07:9b:35 
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 169.238.83.43, my address is 169.238.83.19
IP-Config: Cannot add default route (-22).
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
Looking up port of RPC 100003/2 on 169.238.83.43
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
portmap: server 169.238.83.43 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 169.238.83.43
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
portmap: server 169.238.83.43 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
RPC: sendmsg returned error 128
mount: server 169.238.83.43 not responding, timed out
Root-NFS: Server returned error -5 while mounting /tftpboot/
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00


Other config info:
I'm using another Indy (marvin2) for the bootp/tftp/NFS server. My Indy for Linux is called argo.

hosts:
169.238.83.19   argo
169.238.83.43   marvin2

/etc/exports:
/dist/linux     -rw,32bitclients

/etc/inetd.conf:
tftp    dgram   udp     wait    root    /usr/etc/tftpd  tftpd -l 
bootp   dgram   udp     wait    root    /usr/etc/bootp          bootp -d

/etc/bootptab:
marvin2         1 08:00:69:0A:D5:44     169.238.83.43   vmlinux
argo            1 08:00:69:07:9b:35     169.238.83.19   vmlinux


Server SYSLOG output:
Jan  8 21:06:34 7D:marvin2 bootp[15713]: starting at Fri Jan  8 21:06:34 1999
Jan  8 21:06:34 7D:marvin2 bootp[15713]: (re)reading /etc/bootptab
Jan  8 21:06:34 6D:marvin2 bootp[15713]: reply to argo: boot file /dist/linux/mipseb/vmlinux
Jan  8 21:06:34 7D:marvin2 bootp[15713]: reply to client (ciaddr) 169.238.83.19
Jan  8 21:06:34 6D:marvin2 tftpd[4082]: argo: read request for /dist/linux/mipseb/vmlinux: success
Jan  8 21:06:42 6D:marvin2 bootp[15713]: reply to argo: boot file /dist/linux/mipseb/vmlinux
Jan  8 21:06:42 7D:marvin2 bootp[15713]: reply that IP address (yiaddr) is 169.238.83.19


Portmap info:
marvin2:chad 118 # rpcinfo -t marvin2 100005
program 100005 version 1 ready and waiting
rpcinfo: Program/version mismatch; low version = 1, high version = 3
program 100005 version 2 is not available
program 100005 version 3 ready and waiting

marvin2:chad 120 # rpcinfo -t marvin2 100003
program 100003 version 2 ready and waiting
program 100003 version 3 ready and waiting

marvin2:chad 122 # rpcinfo -p marvin2 | grep 100005
    100005    1   tcp   1024  mountd
    100005    3   tcp   1024  mountd
    100005    1   udp   1026  mountd
    100005    3   udp   1026  mountd

marvin2:chad 115 # rpcinfo -p marvin2 | grep 100003
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100003    2   tcp   2049  nfs
    100003    3   tcp   2049  nfs


-- 
	   -----------------------------------------------------
            Chad Carlin                 	 Special Systems
            Silicon Graphics Inc.	  	    972.205.5911 
            Pager 888.754.1597 		VMail 800.414.7994 X5344
            chad@sgi.com 	     http://reality.sgi.com/chad
           ----------------------------------------------------- 
	   "His favorite Porsche was never the last. It was
		always the next" Said of Dr. Ferdinand Porsche
 
