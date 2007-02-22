Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 23:06:52 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:23531 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038765AbXBVXGp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 23:06:45 +0000
Received: (qmail 18917 invoked by uid 101); 22 Feb 2007 23:05:33 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 22 Feb 2007 23:05:33 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1MN5RKu016177
	for <linux-mips@linux-mips.org>; Thu, 22 Feb 2007 15:05:32 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPA4N0>; Thu, 22 Feb 2007 15:05:26 -0800
Message-ID: <45DE21B1.3070309@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	linux-mips@linux-mips.org
Subject: Questions on the procedure/policy for patch submission
Date:	Thu, 22 Feb 2007 15:05:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 22 Feb 2007 23:05:22.0069 (UTC) FILETIME=[EDC82C50:01C756D5]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

1a. Do patches living completely in arch/mips and include/asm-mips only have to be submitted to the l-m.o?

1b. If so, does this imply that l-m.o will push them to kernel.org?


2a. Do patches which are outside the above directories have the be submitted to the kernel.org list?

2b. If so, how are dependencies between the two sets of submission handled during the review process?

Thanks,
Marc
