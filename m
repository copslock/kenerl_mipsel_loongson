Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g76FIVRw027120
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 6 Aug 2002 08:18:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g76FIVsx027119
	for linux-mips-outgoing; Tue, 6 Aug 2002 08:18:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rail.cita.utoronto.ca (rail.cita.utoronto.ca [128.100.76.4])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g76FIJRw027110
	for <linux-mips@oss.sgi.com>; Tue, 6 Aug 2002 08:18:20 -0700
Received: from [128.100.76.25] (marmot.cita.utoronto.ca) by rail.cita.utoronto.ca id 784; Tue, 6 Aug 2002 11:20:11
Date: Tue, 6 Aug 2002 11:20:00 -0400
From: Robin Humble <rjh@cita.utoronto.ca>
To: linux-mips@oss.sgi.com
Subject: R4600SC Indy
Message-ID: <20020806111959.C15670@marmot.cita.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,

I have an R4600SC Indy and an R5000 Indy and the R4600SC hasn't worked
with a kernel since around 2.4.17 13feb2002. 
Are there any patches or new toolchain that I could try? Or is there
some way I can configure/boot the kernel to help sort out the problem?

The R5k with same root disk and same kernel (compiled for either R4600
or R5000) works fine on last week's 2.4.19-rc1 31july2002 OSS CVS,
as well with the old 2.4.17 kernel...

I've tried 1/2 a dozen kernels since feb on my poor little R4600SC and
they all fail to fully boot. For example, 2.4.19-rc1 gets to mounting
the disks and starting RedHat services and then locks up with no
messages at some random time after that - during sshd or eth0 startup
or similar - has to be paperclipped off - magic sysrq key doesn't work.

The 2.4.17-13feb2002 kernel on the R4600SC seems pretty stable (apart
from the ubiquitous X shared mem/bitmap corruption) so I'm quietly
confident that there are no broken hardware issues... I'm running
redhat-7.1 + much of 7.2 and some 7.3. Toolchain is:

% gcc -v ; ld -v
Reading specs from /usr/lib/gcc-lib/mips-redhat-linux-gnu/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110.1)
GNU ld version 2.12.90.0.7 20020423
% rpm -qa | grep binutil
binutils-2.12.90.0.7-1

Here's the top part from the working 2.4.17's dmesg for both machines
showing the CPU versions:
--------- R4600SC ---------
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE SCACHE 
CPU revision is: 00002010
FPU revision is: 00002000
Primary instruction cache 16kb, linesize 32 bytes.
Primary data cache 16kb, linesize 32 bytes.
Linux version 2.4.17-13feb (root@elan) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)) #1 Wed Feb 13 20:49:52 EST 2002
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 512K, linesize 32 bytes.
--------- R5000 ---------
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE 
CPU revision is: 00002310
FPU revision is: 00002310
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 32kb, linesize 32 bytes.
Linux version 2.4.17-13feb (root@elan) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)) #1 Wed Feb 13 20:49:52 EST 2002
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 512K, linesize 32 bytes.
------------------------

cheers,
robin
