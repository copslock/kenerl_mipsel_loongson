Received:  by oss.sgi.com id <S553867AbRAPRRZ>;
	Tue, 16 Jan 2001 09:17:25 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:28939 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553839AbRAPRRS>;
	Tue, 16 Jan 2001 09:17:18 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4B2A37FE; Tue, 16 Jan 2001 18:17:13 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CBB5BF597; Tue, 16 Jan 2001 18:17:52 +0100 (CET)
Date:   Tue, 16 Jan 2001 18:17:52 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: 2.4.0 on SGI I2 - obscure stuff ....
Message-ID: <20010116181752.E7327@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>> bootp():vmlinux-ip22 console=ttyS0 root=/dev/sda1 mem=0x07800000@0x08800000
Setting $netaddr to 195.71.99.220 (from server watchdog)
Obtaining vmlinux-ip22 from server watchdog
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
[...]


resume:~# uname -a
Linux resume.rfc822.org 2.4.0 #4 Tue Jan 16 17:41:04 CET 2001 mips unknown
resume:~# cat /proc/cpuinfo 
cpu			: MIPS
cpu model		: R4000SC V6.0
system type		: SGI Indigo2
BogoMIPS		: 0.00
byteorder		: big endian
unaligned accesses	: 0
wait instruction	: no
microsecond timers	: yes
extra interrupt vector	: no
hardware watchpoint	: yes
VCED exceptions		: not available
VCEI exceptions		: not available

Bogomips = 0.00
VCED/VCEI not available ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
