Received:  by oss.sgi.com id <S553695AbQKNVjL>;
	Tue, 14 Nov 2000 13:39:11 -0800
Received: from mail.ivm.net ([62.204.1.4]:51241 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553677AbQKNVjA>;
	Tue, 14 Nov 2000 13:39:00 -0800
Received: from franz.no.dom (port120.duesseldorf.ivm.de [195.247.65.120])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id WAA18225;
	Tue, 14 Nov 2000 22:30:22 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001114223015.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <012301c04d5c$b4d71b60$38258286@lfm.rwthaachen.de>
Date:   Tue, 14 Nov 2000 22:30:15 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Markus Hoff-Holtmanns <markus@LFM.rwth-aachen.de>
Subject: RE: MIPS Linux and O2 and/or Octane...
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 13-Nov-00 Markus Hoff-Holtmanns wrote:
> Hi folks!

Selber hi!
 
> There probably already were numerous threads concerning this subject, but
> I'm new and I didn't find anything fitting in the archives. So here is my
> question.
> 
> Anyone who did or tried a Linux port for O2, or contributed anything
> regarding that topic, could you please give me that information again. At
> the moment I try to gather as much info as possible in this regard, as we
> have some O2s running IRIX 6.3 and gathering dust most of the time.

Well, I guess I should update the FAQ :)

Keith and I have been working on O2 support, but due to a chronical lack of
time on my side progress is slow.

The actual status is:

o kernel boots and detects the machine and memory size.
o serial console works
o periodic interrupts working (the poor man's CPO_COUNT/CP0_COMPARE version)
o PCI code detects the onboard Adaptec AIC-7880 SCSI host adapters
o The Adaptec driver itself crashes
o The existing cache management does not handle secondary caches tied to a R5000
CPU too well. Read: userland programs crash without evil hacks, actually.
o R10000s will _not_ work for quite a while.

For the records:

> boot bootp()/vmlinux
130768+22320+3184+341792+48560d+4604+6816 entry: 0x87fa60d0
Setting $netaddr to 192.168.0.7 (from server intel)
Obtaining /vmlinux from server intel
656824+81120+112564 entry: 0x80002584
ARCH: SGI-IP32
PROMLIB: ARC firmware Version 1 Revision 10
PROMLIB: Total free ram 122888K / 120MB.
Loading R4000 MMU routines.
CPU revision is: 00002321
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 32kb, linesize 32 bytes.
Secondary cache sized at 128K linesize 32 bytes.
Linux version 2.4.0-test9 (harry@intel) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 release)) #1 Die Nov 14 22:14:10 CET 2000
On node 0 totalpages: 32646
zone(0): 32646 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: 
Calibrating delay loop... 359.63 BogoMIPS
Memory: 120708k/130584k available (641k kernel code, 9876k reserved, 46k data,
32k init)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Serial driver version 5.02 (2000-08-09) with SHARE_IRQ enabled
ttyS00 at 0x0000 (irq = 14) is a 16550A
ttyS01 at 0x0000 (irq = 0) is a 16550A
Kernel panic: I have no root and I want to scream

Please note that the secondary cache size and the BogoMIPS are, well, bogus :)

-- 
Regards,
Harald
