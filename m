Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9Q9rRj22096
	for linux-mips-outgoing; Fri, 26 Oct 2001 02:53:27 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9Q9rG022092
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 02:53:16 -0700
Received: from 21cn.com ([61.140.60.248]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id CAA06744
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 02:53:05 -0700 (PDT)
	mail_from (ajob4me@21cn.com)
Message-Id: <200110260953.CAA06744@sgi.com>
Received: from cc([210.5.16.43]) by 21cn.com(AIMC 2.9.5.2)
	with SMTP id jm1b3bd9649b; Fri, 26 Oct 2001 17:51:07 +0800
Date: Fri, 26 Oct 2001 17:49:26 +0800
From: 8route <ajob4me@21cn.com>
To: "nemoto@toshiba-tops.co.jp" <nemoto@toshiba-tops.co.jp>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Toshiba TX3927 board boot problem.
X-mailer: FoxMail 3.0 beta 1 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="US_ASCII"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear all:
  Hi!
  I'm working on Toshiba TX3927 RISC Processor Reference board.During 
development I met a problem.Can someone give me some good suggestions?
  Let me describe the problem in details:
  TX3927 board cann't boot up via NFS.It will halt at 
  ==================================
  VFS: Mounted root (NFS filesystem).
  Freeing unused kernel memory: 44k freed 
  ========================================
and the reset switch on the TX3927 board cann't work anymore.
The kernel is linux-2.2.13-20000211.tar.bz2 with Toshiba TX3927 patch,
the NFS root file system is declinuxroot-990611.tgz.
I've checked /var/log/messages and find sentence like this:
   authenticated mount request from 192.168.255.202...
so I think NFS file system works well.Can someone give me some 
good suggestions to solve this problem?

These are serial port output: 
=============================
Toshiba Bootloader for TX RISC Reference Kit Ver 000.10
Copyright (c) 1999, 2000 TOSHIBA Corporation  
TX3927JMR/JMI TX3927 Rev ( 0) CPU Clk 133Mhz, BUS Clk  66Mhz
Slot [0] : MEM Base = 0x80040000, MEM Size = 0x00fc0000
FlashROM BFC00000 - BFFFFFFF
Find Toshiba TX3927 PCI Controller.
Find Toshiba TC35815 100Mbps Ethernet Controller.
MON> info
TX3927JMR/JMI TX3927 Rev ( 0) CPU Clk 133Mhz, BUS Clk  66Mhz
Slot [0] : MEM Base = 0x80040000, MEM Size = 0x00fc0000
Chip Config TX3927 [ccfg]  = 0004303b
Pin  Config TX3927 [pcfg]  = 0ffc7101
SDCCR0 Reg TX3927 [sdccr0] = 000300e8
SDCCR1 Reg TX3927 [sdccr1] = 00000000
SDCCR2 Reg TX3927 [sdccr2] = 00000000
SDCCR3 Reg TX3927 [sdccr3] = 00000000
SDCCR4 Reg TX3927 [sdccr4] = 00000000
SDCCR5 Reg TX3927 [sdccr5] = 00000000
SDCCR6 Reg TX3927 [sdccr6] = 00000000
SDCCR7 Reg TX3927 [sdccr7] = 00000000
SDCTR1 Reg TX3927 [sdctr1] = 08010400
SDCTR2 Reg TX3927 [sdctr2] = 000000ff
SDCTR3 Reg TX3927 [sdctr3] = 02020000
SDCCMD Reg TX3927 [sdccmd] = 20100031
RCCR 0 Reg TX3927 [rccr0]  = 1fc35208
RCCR 1 Reg TX3927 [rccr1]  = 00000000
RCCR 2 Reg TX3927 [rccr2]  = 140064c8
RCCR 3 Reg TX3927 [rccr3]  = 1003f698
RCCR 4 Reg TX3927 [rccr4]  = 00000000
RCCR 5 Reg TX3927 [rccr5]  = 00000000
RCCR 6 Reg TX3927 [rccr6]  = 00000000
RCCR 7 Reg TX3927 [rccr7]  = 00000000
Port 0. dbg 1.onbrd [serp] =        0
Baud Rate           [baud] =    38400
Init exec cmd 1 [icmd1] = 
Init exec cmd 2 [icmd2] = 
Init exec cmd 3 [icmd3] = 
Init exec cmd 4 [icmd4] = 
cmdline [cmdl] = root=/dev/nfs rw ip=::::::rarp console=ttyS0 
nfsroot=192.168.255.8:/work/nfsroot 
MON> br
initialize TC35815 [100Mbps Ethernet].
tc35815 base address (0xa4000000)
Link Speed : 100Mbps
initialize TC35815 completion.
Booting...: Using Reverse ARP.
Ethernet address 00:00:39:04:F8:14
IP address 192.168.255.202 = C0A8FFCA
Booting TFTP server from 192.168.255.8 = C0A8FF08
kernel file : C0A8FFCA ...
Downloaded 1126720 (  113140) bytes at a0080000 from TFTP server.
Default:root=/dev/nfs rw ip=::::::rarp console=ttyS0 
nfsroot=192.168.255.8:/work/nfsroot 
boot:
Loading R[23]00 MMU routines.
CPU revision is: 00002240
config reg = 001a0030
Instruction cache 8kb, linesize 16byte
Data cache 4kb, linesize 16byte
Linux version 2.2.13 (root@desktop) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 
release)) #1 Tue Oct 23 09:45:59 HKT 2001
Toshiba Reference System Setup
TX3927 133Mhz
Initialize TX3927 PCI Controller.
Calibrating delay loop... 105.68 BogoMIPS
Memory: 14476k/16380k available (980k kernel code, 408k data)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5 
setup_machine_info:Cpu typtx39_initialize: cflags set to 77
TX39 UART driver version 0.04
loop: registered device at major 7
initialize TC35815 [100Mbps Ethernet].
TC35815 : at 0xa4000000 IRQ:3
Link Speed : 100Mbps
ADDR: 00:00:39:04:f8:14 
initialize TC35815 completion.
Sending RARP requests..... OK
IP-Config: Got RARP answer from 192.168.255.8, my address is 192.168.255.202
IP-Config: Guessing netmask 255.255.255.0
Looking up port of RPC 100003/2 on 192.168.255.8
Looking up port of RPC 100005/1 on 192.168.255.8
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 44k freed
========================================

Regards,
8route
