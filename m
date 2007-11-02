Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 12:58:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9447 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030414AbXKBM6X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Nov 2007 12:58:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA2CvsEu014497;
	Fri, 2 Nov 2007 12:57:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA2Cvr69014496;
	Fri, 2 Nov 2007 12:57:53 GMT
Date:	Fri, 2 Nov 2007 12:57:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kalyan tejaswi <kalyanatejaswi@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Oops with kernel 2.6.8
Message-ID: <20071102125753.GB14106@linux-mips.org>
References: <9dd3c65d0711012245r4a1f2061r126d34a907b640cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd3c65d0711012245r4a1f2061r126d34a907b640cd@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 02, 2007 at 11:15:51AM +0530, kalyan tejaswi wrote:

> Hi all,
> I am using Malta-4Kc with kernel 2.6.8(from linux-mips.org) compiled with
> gcc 3.4.4.
> 
> I can not boot over NFS.
> 
> The console log is attached.
> 
> Any hints are greatly appreciated.

2.6.8 is really old, over 3 years now.  So forgive if memory of the bugs
in that kernel is fading.  I think the one you're seeing was was caused
by memory prefetching beyond the end of memory.  The easy fix is to disable
prefetching.  See a  modern memcpy for how to do that.  There are several
other interesting issues hidden in 2.6.8 so I think you really should
upgrade.

  Ralf
