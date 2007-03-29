Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 22:31:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56522 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021365AbXC2VbK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Mar 2007 22:31:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2TLV1jl023319;
	Thu, 29 Mar 2007 22:31:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2TLUpw5023318;
	Thu, 29 Mar 2007 22:30:51 +0100
Date:	Thu, 29 Mar 2007 22:30:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Deepak Saxena <dsaxena@plexity.net>
Cc:	Manish Lachwani <mlachwani@mvista.com>,
	Ingo Molnar <mingo@elte.hu>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make page fault preempt-safe
Message-ID: <20070329213050.GB22703@linux-mips.org>
References: <20070328205442.GA18508@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070328205442.GA18508@plexity.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 28, 2007 at 01:54:42PM -0700, Deepak Saxena wrote:

> Like the udelay() patch, this makes vmalloc_fault() preempt-safe under 
> DEBUG_PREEMPT.

There were two more instances which also needed to be fixed, so I just did
that.

  Ralf
