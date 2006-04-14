Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 23:01:08 +0100 (BST)
Received: from mga03.intel.com ([143.182.124.21]:94 "EHLO
	azsmga101-1.ch.intel.com") by ftp.linux-mips.org with ESMTP
	id S8133482AbWDNWA7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Apr 2006 23:00:59 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101-1.ch.intel.com with ESMTP; 14 Apr 2006 15:12:58 -0700
Received: from azsmsx331.ch.intel.com (HELO azsmsx331-2.ch.intel.com) ([10.2.161.41])
  by azsmga001.ch.intel.com with ESMTP; 14 Apr 2006 15:12:58 -0700
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23376468:sNHT25077682"
Received: from orsmga001.jf.intel.com ([10.7.209.18]) by azsmsx331-2.ch.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 14 Apr 2006 15:12:56 -0700
Received: from azsmsx331.ch.intel.com (HELO azsmsx331-2.ch.intel.com) ([10.2.161.41])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2006 15:12:53 -0700
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23405727:sNHT15785287"
Received: from orsmga001.jf.intel.com ([10.7.209.18]) by azsmsx331-2.ch.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 14 Apr 2006 15:12:52 -0700
Received: from kwchen-mobl1.amr.corp.intel.com (HELO kwchenmobl1) ([10.3.52.228])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2006 15:12:51 -0700
Message-Id: <4t16i2$ma94t@orsmga001.jf.intel.com>
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23405725:sNHT17212258"
From:	"Chen, Kenneth W" <kenneth.w.chen@intel.com>
To:	"'Steven Rostedt'" <rostedt@goodmis.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"Andrew Morton" <akpm@osdl.org>
Cc:	"Linus Torvalds" <torvalds@osdl.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>, "Andi Kleen" <ak@suse.de>,
	"Martin Mares" <mj@atrey.karlin.mff.cuni.cz>, <bjornw@axis.com>,
	<schwidefsky@de.ibm.com>, <benedict.gaster@superh.com>,
	<lethal@linux-sh.org>, "Chris Zankel" <chris@zankel.net>,
	"Marc Gauthier" <marc@tensilica.com>,
	"Joe Taylor" <joe@tensilica.com>,
	"David Mosberger-Tang" <davidm@hpl.hp.com>, <rth@twiddle.net>,
	<spyro@f2s.com>, <starvik@axis.com>,
	"Luck, Tony" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	<ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
	<grundler@parisc-linux.org>, <parisc-linux@parisc-linux.org>,
	<linuxppc-dev@ozlabs.org>, <paulus@samba.org>,
	<linux390@de.ibm.com>, <lethal@linux-sh.org>,
	<davem@davemloft.net>, <chris@zankel.net>
Subject: RE: [PATCH 00/05] robust per_cpu allocation for modules
Date:	Fri, 14 Apr 2006 15:12:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZgCRaKo5LPRXFvTha4PDZxynOXogAByO9A
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 14 Apr 2006 22:12:52.0761 (UTC) FILETIME=[92F06890:01C66010]
Return-Path: <kenneth.w.chen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kenneth.w.chen@intel.com
Precedence: bulk
X-list: linux-mips

Steven Rostedt wrote on Friday, April 14, 2006 2:19 PM
> So the current solution has two flaws:
> 1. not robust. If we someday add more modules that together take up
>    more than 14K, we need to manually update the PERCPU_ENOUGH_ROOM.
> 2. waste of memory.  We have 14K of memory wasted per CPU. Remember
>    a 64 processor machine would be wasting 896K of memory!

If someone who has the money to own a 64-process machine, 896K of memory
is pocket change ;-)

- Ken
