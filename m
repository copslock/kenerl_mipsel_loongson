Received:  by oss.sgi.com id <S305167AbQCTUMz>;
	Mon, 20 Mar 2000 12:12:55 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29021 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCTUM1>; Mon, 20 Mar 2000 12:12:27 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA04425; Mon, 20 Mar 2000 12:15:49 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA88146; Mon, 20 Mar 2000 12:12:19 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA11501
	for linux-list;
	Mon, 20 Mar 2000 11:24:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA91016
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Mar 2000 11:24:02 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09406
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Mar 2000 11:23:32 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4BBB6820; Mon, 20 Mar 2000 20:23:21 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C65478FC3; Mon, 20 Mar 2000 20:22:08 +0100 (CET)
Date:   Mon, 20 Mar 2000 20:22:08 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: boot decstation 5000/120 stops after SCSI
Message-ID: <20000320202208.C1363@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i have a couple of problems installing on a Decstation 5000/120.
Having done this on a bunch of machines before i cant remember having
this kind of problem before 

Here is the console output ...


This DECstation is a DS5000/1xx
Loading R[23]00 MMU routines.
CPU revision is: 00000230
Instruction cache 64kb
Data cache 64kb
Linux version 2.2.10 (root@elrond) (gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)) #2 Sun Sep 19 17:51:32 MEST 1999
Calibrating delay loop... 19.79 BogoMIPS
Memory: 14460k/16380k available (1232k kernel code, 428k data)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 12.5 MHz (no parity)
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5 
DECstation Z8530 serial driver version 0.03
tty00 at 0xbc100001 (irq = 4) is a Z85C30 SCC
tty01 at 0xbc100009 (irq = 4) is a Z85C30 SCC
tty02 at 0xbc180001 (irq = 4) is a Z85C30 SCC
tty03 at 0xbc180009 (irq = 4) is a Z85C30 SCC
loop: registered device at major 7
SCSI ID 7  Clock 25 MHz CCF=0 Time-Out 167 NCR53C9x(esp236) detected
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : ESP236
scsi : 1 host.
  Vendor: QUANTUM   Model: FIREBALL_TM2110S  Rev: 300X
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: DEC       Model: RRD42   (C) DEC   Rev: 4.3d
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0


Here the output/boot stop suddenly - Nothing happens - Waited for
at least 10 Minutes - Does somebody have an idea ? 

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
