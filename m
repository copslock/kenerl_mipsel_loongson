Received:  by oss.sgi.com id <S305190AbQAFJMZ>;
	Thu, 6 Jan 2000 01:12:25 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:23315 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305189AbQAFJMK>;
	Thu, 6 Jan 2000 01:12:10 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA07251; Thu, 6 Jan 2000 01:08:37 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA14763
	for linux-list;
	Thu, 6 Jan 2000 01:02:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA51227
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Jan 2000 01:01:47 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA05563
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Jan 2000 01:01:21 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA19135;
	Thu, 6 Jan 2000 01:01:10 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA03377;
	Thu, 6 Jan 2000 01:01:06 -0800 (PST)
Message-ID: <000601bf5826$273af500$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
Date:   Thu, 6 Jan 2000 10:12:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

The "setting flush to zero/Unimlemented exception"
problem is almost certainly due to the fact that the
DECstation binaries were compiled for R3000-based
platforms with R3K-style FPUs which have 32 single-precision
FP regs that can also be treated pairwise as 16
double-precision registers.  I didn't know that the 5000 line
had R4000 CPUs in them, but on the basis of your reported
CPU revision number, that's what you've got.

The default SGI/MIPS Linux kernel startup sets the
"FR" bit in the CP0.Status register, which enables
R4000-style FPU registers, which is to say a full
compliment of 32 double-precision registers.  This
has the side-effect of making the kernel incompatible
with the distributed mipsel binaries and the distributed
DECstation root file system, since those binaries which
do double-precision floating point load their initial values
from memory as two singles.  That works on an R3000
or an R4000-with-FR=0, but not on an R4000-with-FR=1.
If FR=1, the data in the registers is garbage, the FP
ops trap on unimplemented exceptions, which first
retry the instruction with flush-to-zero mode in a
desperate hope that that will solve the problem,
then call the fragmentatary SW emulator in the
kernel, which only handles a few cases, then
skip the instruction, printing the console message
that it "should" have sent a SIGFPE.   Hence the
output.  And hence the bizzare behaviour of awk,
ps, and a number of other basic programs that do
minimal FP as the system comes up (procps?).

It took me a while to figure this out when I ran into
it doing a little-endian port of Linux 2.2.12 to an R5260,
as you might imagine.   Unless things have been drastically
scrambled for 2.3.x,  the code controlling this is in
arch/mips/kernel/head.S.   What we did at MIPS was
to add a config option to determine which FPU model
is desired.   The truly elegant thing would be to examine
the a.out file and manage Status.FR dynamically, but
a quick inspection turned up no clean mechanism in
the Linux kernel for passing such architecture-dependent
information from the generic a.out file parsing to the
thread creation machinery, so that will be a later
exercise.   Thoward the end of the kernel entry point
(kernel_entry), our revised code looks a bit like this:

        /* Disable coprocessors */
        mfc0    t0, CP0_STATUS
#ifdef CONFIG_MIPS_32FR
        li      t1, ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX)
#else
        li      t1, ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX|ST0_FR)
#endif
        and     t0, t1
        or      t0, ST0_CU0
        mtc0    t0, CP0_STATUS

1:      jal     start_kernel
         nop

The "#ifdef/else/endif" sequence is our addition.  For a
quick hack, just add ST0_FR to the set of bits being
inverted in the existing code.

            Hope this helps,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68

-----Original Message-----
From: Florian Lohoff <flo@rfc822.org>
To: linux@cthulhu.engr.sgi.com <linux@cthulhu.engr.sgi.com>
Date: Wednesday, January 05, 2000 11:17 PM
Subject: Decstation 5000/150 2.3.21 Boot successs


>
>Hi,
>this is is a short output of the 2.3.21 booting on the Decstation
>5000/150 ... This is the current oss.sgi.com CVS.
>
>--------------------------------------------------------------
>This DECstation is a DS5000/1xx
>Loading R4000 MMU routines.
>CPU revision is: 00000430
>Primary instruction cache 8kb, linesize 16 bytes)
>Primary data cache 8kb, linesize 16 bytes)
>Secondary cache sized at 1024K linesize 32
>Linux version 2.3.21 (root@repeat) (gcc version egcs-2.90.27 980315 (egcs-1.0.2
release)) #1 Tue Jan 4 18:39:20 GMT 2000
>Calibrating delay loop... 49.81 BogoMIPS
>Memory: 62652k/65532k available (1068k kernel code, 1524k data)
>Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
>Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
>Checking for 'wait' instruction...  unavailable.
>POSIX conformance testing by UNIFIX
>TURBOchannel rev. 1 at 12.5 MHz (no parity)
>    slot 0: DEC      PMAZ-AA  V5.3d
>    slot 1: DEC      PMAZ-AA  V5.3b
>    slot 2: DEC      PMAF-FA  V1.1
>Linux NET4.0 for Linux 2.3
>Based upon Swansea University Computer Society NET3.039
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP
>TCP: Hash tables configured (established 4096 bind 8192)
>Starting kswapd v1.6
>DECstation Z8530 serial driver version 0.03
>tty00 at 0xbc100001 (irq = 4) is a Z85C30 SCC
>tty01 at 0xbc100009 (irq = 4) is a Z85C30 SCC
>tty02 at 0xbc180001 (irq = 4) is a Z85C30 SCC
>tty03 at 0xbc180009 (irq = 4) is a Z85C30 SCC
>SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
>SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
>SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
>ESP: Total of 3 ESP hosts found, 3 actually in use.
>scsi0 : ESP236 (NCR53C9x)
>scsi1 : ESP236 (NCR53C9x)
>scsi2 : ESP236 (NCR53C9x)
>scsi : 3 hosts.
>  Vendor: Quantum   Model: XP34300           Rev: L912
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
>  Vendor: SEAGATE   Model: ST15150N          Rev: 8902
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
>scsi : detected 2 SCSI disks total.
>esp0: target 0 [period 200ns offset 15 5.00MHz synchronous SCSI]
>SCSI device sda: hdwr sector= 512 bytes. Sectors= 8399520 [4101 MB] [4.1 GB]
>esp0: target 2 [period 200ns offset 15 5.00MHz synchronous SCSI]
>SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8388315 [4095 MB] [4.1 GB]
>declance.c: v0.008 by Linux Mips DECstation task force
>eth0: IOASIC onboard LANCE, addr = 08:00:2b:28:f0:a3, irq = 3
>Sending BOOTP requests.... OK
>IP-Config: Got BOOTP answer from 193.189.250.46, my address is 193.189.250.44
>-----------------------------------------------------
>
>I see some more ugly things:
>
>Setting flush to zero for dpkg-source.
>Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
>Should send SIGFPE to dpkg-source
>Setting flush to zero for dpkg-source.
>Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
>Should send SIGFPE to dpkg-source
>Setting flush to zero for dpkg-source.
>Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
>Should send SIGFPE to dpkg-source
>
>And this ...
>
>Bug in get_wchan
>
>This seems to be a result of buggy "procps" ...
>
>Flo
>--
>Florian Lohoff flo@rfc822.org       +49-5241-470566
>  ...  The failure can be random; however, when it does occur, it is
>  catastrophic and is repeatable  ...             Cisco Field Notice
>
