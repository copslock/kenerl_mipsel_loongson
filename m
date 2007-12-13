Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2007 12:58:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61149 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575685AbXLMM6t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Dec 2007 12:58:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBDCwm14001441;
	Thu, 13 Dec 2007 12:58:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBDCwlx5001440;
	Thu, 13 Dec 2007 12:58:47 GMT
Date:	Thu, 13 Dec 2007 12:58:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nilanjan Roychowdhury <Nilanjan.Roychowdhury@gnss.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Inter processor synchronization
Message-ID: <20071213125847.GA1352@linux-mips.org>
References: <9D98C51005D80D43A19A3DF329A61D690106A282@INDEXCH2003.gmi.domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D690106A282@INDEXCH2003.gmi.domain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 13, 2007 at 09:07:20AM +0530, Nilanjan Roychowdhury wrote:

> I have a scenario where two images of the same Linux kernel are running
> on two MIPS cores. One is 24K and another is 4KEC. What is the best way
> to achieve inter processor synchronization between them?
> 
> I guess the locks for LL/SC are local to a particular core and can not
> be extended across a multi core system. 

4K and 24K cores don't support cache coherency.  So SMP is out of question.
This is a _total_ showstopper for SMP, don't waste your time thinking on
possible workarounds.

The you could do is some sort of clusting, running two OS images, one
on the 4K and one on the 24K which would communicate through a carefully
cache managed or even uncached shared memory region.

> Will it be easier for me if both of them becomes same core ( like both
> 24k) and I run the SMP version of Linux.


Within limits Linux supports mixing different CPU types such as R4000MC /
R4400MC and R10000 / R12000 / R14000 mixes because those processors are
similar enough

  Ralf
