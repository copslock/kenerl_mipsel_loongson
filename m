Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Apr 2006 03:59:06 +0100 (BST)
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:36500 "EHLO
	ms-smtp-04.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133721AbWDOC6z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Apr 2006 03:58:55 +0100
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-04.nyroc.rr.com (8.13.4/8.13.4) with ESMTP id k3F3APqT003523;
	Fri, 14 Apr 2006 23:10:26 -0400 (EDT)
Subject: [PATCH 00/08] robust per_cpu allocation for modules - V2
From:	Steven Rostedt <rostedt@goodmis.org>
To:	LKML <linux-kernel@vger.kernel.org>
Cc:	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
	schwidefsky@de.ibm.com, lethal@linux-sh.org,
	Chris Zankel <chris@zankel.net>,
	Marc Gauthier <marc@tensilica.com>,
	Joe Taylor <joe@tensilica.com>, rth@twiddle.net, spyro@f2s.com,
	starvik@axis.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
	davem@davemloft.net, SamRavnborg <sam@ravnborg.org>
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Fri, 14 Apr 2006 23:10:24 -0400
Message-Id: <1145070624.27407.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

This is version 2 of the percpu patch set.

Changes from version 1:

- Created a PERCPU_OFFSET variable to use in vmlinux.lds.h
  (suggested by Sam Ravnborg)

- Added support for x86_64 (Steven Rostedt)

The support for x86_64 goes back to the asm-generic handling when both
CONFIG_SMP and CONFIG_MODULES are set. This is due to the fact that the
__per_cpu_offset array is no longer referenced in per_cpu, but instead a
per per_cpu variable is used to find the offset.

Again, the rest of the patches are only sent to the LKML.

Still I need help to port this to the rest of the architectures.

Thanks,

-- Steve
