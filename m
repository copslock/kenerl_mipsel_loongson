Received:  by oss.sgi.com id <S42254AbQH0Mzq>;
	Sun, 27 Aug 2000 05:55:46 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:33811 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42253AbQH0MzU>;
	Sun, 27 Aug 2000 05:55:20 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5B74F826; Sun, 27 Aug 2000 14:58:34 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E21678FF5; Sun, 27 Aug 2000 14:54:13 +0200 (CEST)
Date:   Sun, 27 Aug 2000 14:54:13 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Decstation 5000/150 hangs in Delayloop (2.4.0-test6)
Message-ID: <20000827145413.A306@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
i think something broke between 2.4.0-test3-pre7 and 2.4.0-test6
for the Decstation 5000/150 - The Register DUMP is of the
Prom when i pressed reset.

The same kernel Image works fine on my Decstation 5000/260 which
is an R4400 instead of R4000.

BTW: 2.4.0-test6-pre8 oopses after SCSI 

-------------------------------------------------------------------
KN04 V2.1k    (PC: 0xbfc0075c, SP: 0x83739de8)

This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes.
Primary data cache 8kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.0-test6 (flo@slimer.rfc822.org) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #3 Sun Aug 27 10:37:34 GMT 2000
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda2 console=ttyS2
Calibrating delay loop... 
???
? PC:  0xbfc0075c <vtr=NMI/SR>
? CR:  0x00000000 <CE=0,EXC=INT>
? SR:  0x00510006 <BEV,SR,DE,IPL=8,MODE=KNL,ERL,EXL>
? CFG: 0x00410242 <SB=8W,SC=Y,IC=8K,DC=8K,IB=4W,DB=4W,K0=UNC>
? 
? MB_CS:  0x003f8000 <FW,MSK=1F,EE,ECC=0>
? MB_INT: 0x101f0000 <>
? 
? SIR:  0x00000001
? SIRM: 0x00000000
? 
? at:0002FF00 a2:000024F6 t3:A0000000 s0:00000008 s5:FFFFFFFF k1:FFFE27FD
? v0:BFDC0000 a3:0000003C t4:00000000 s1:80040584 s6:801683B0 gp:80046000
? v1:00000000 t0:A0015CC4 t5:00000000 s2:FFFFFFFF s7:80047F80 sp:80047F80
? a0:FFFFFFFF t1:A002FF00 t6:8017CDB4 s3:FFFFFFFF t8:00000016 fp:7E7D2BFF
? a1:00000021 t2:FFFFFFFF t7:10012001 s4:FFFFFFFF t9:00000F00 ra:BFC0068C
-----------------------------------------------------------------------


Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
