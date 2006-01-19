Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 10:26:43 +0000 (GMT)
Received: from bes.cs.utk.edu ([160.36.56.220]:11454 "EHLO bes.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S8133747AbWASK0Y (ORCPT
	<rfc822;Linux-mips@linux-mips.org>); Thu, 19 Jan 2006 10:26:24 +0000
Received: from localhost (bes [127.0.0.1])
	by bes.cs.utk.edu (Postfix) with ESMTP id 5AA87273BF;
	Thu, 19 Jan 2006 05:30:07 -0500 (EST)
Received: from bes.cs.utk.edu ([127.0.0.1])
 by localhost (bes [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08400-03; Thu, 19 Jan 2006 05:30:05 -0500 (EST)
Received: from dhcp-221-85.pdc.kth.se (dhcp-221-85.pdc.kth.se [130.237.221.85])
	by bes.cs.utk.edu (Postfix) with ESMTP id A7B63273D2;
	Thu, 19 Jan 2006 05:30:04 -0500 (EST)
Subject: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support + libpfm
	available
From:	Philip Mucci <mucci@cs.utk.edu>
To:	Linux-mips@linux-mips.org
Cc:	perfmon@napali.hpl.hp.com, Stephane Eranian <eranian@hpl.hp.com>
Content-Type: text/plain
Organization: Innovative Computing Laboratory
Date:	Thu, 19 Jan 2006 11:30:02 +0100
Message-Id: <1137666602.6648.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 9977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Hello Linux-MIPSers,

Below is an announcement of the kernel perfmon/libpfm support and user
library for hardware performance monitoring on MIPS (and other
platforms). This support mirrors that which has been available on IA64
for quite some time and is an effort by Stefane Eranian, David Gibson
myself and others to establish a fully functional kernel substrate for
hardware performance analysis. This is based on a large body of
work/experience with PM kernel support both on Linux and many other
systems.

Note that the MIPS support is based on a 2.6.13-rc2 snapshot of the LM
code base, soon to be updated to 2.6.15. If you want to patch against
the head, you'll probably have to fix up the syscall numbers.

I have tested the code on a 20K system + 64bit kernel (that has 1 entire
PMC register) and soon will be testing on a 5K system when it comes back
from being serviced. n32/n64 ABI's have not yet been tested but support
is there.

PAPI is also in the works for these systems. Feel free to give it a spin
and tell us where it breaks or otherwise offends you. 

Regards,

Philip

P.S. The code should be relatively easy to extend to other members of
the product line...currently I've only got kernel code in for
5K/20K/25K, which are nearly identical as far as the PMC goes. 

-------- Forwarded Message --------
From: Stephane Eranian <eranian@hpl.hp.com>
Reply-To: eranian@hpl.hp.com
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, perfmon@napali.hpl.hp.com,
perfctr-devel@lists.sourceforge.net
Subject: [Perfctr-devel] 2.6.16-rc1 perfmon2 new code base with
Montecito support + libpfm available
Date: Wed, 18 Jan 2006 12:56:30 -0800

Hello,

I have released a new version of the perfmon base package.
This release is relative to 2.6.16-rc1.

Due to the addition of the migrate_pages() system call, all perfmon
system calls have been shifted by one. As a consequence, you must
relink your applications using the new version of libpfm which
is also released today: libpfm-3.2-060118.

This new kernel patch includes several important changes:

	- added support for the Dual-Core Itanium 2 (Montecito) processor

	- working support for MIPS5K and MIPS20k (by Phil Mucci)

	- lots of cleanups in the PMU description modules. Some common
	  functionalities moved into core (masking of reserved fields)

	- PFM_REGFL_NEMUL64 managed from perfmon core

The new version of the library, libpfm, includes the following changes:

	- added support for MIPS5K, MIPS20K

	- added pfm_get_event_counter() interface with man page

	- added support for compiling using a 32-bit ABI on a 64-bit OS
	  (not available on all platforms, see config.mk)

	- reworked all standalone examples

	- cleanups and fixes in the generic examples

The two packages can be downloaded from the SourceForge website at:

	http://www.sf.net/projects/perfmon2

I will be posting the patches directly to LKML for
review very shortly.

Enjoy,
