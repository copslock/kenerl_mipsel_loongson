Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 21:37:57 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37782 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022980AbXCTVhO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 21:37:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2KLYxd1004551;
	Tue, 20 Mar 2007 21:35:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2KAwvQf024316;
	Tue, 20 Mar 2007 10:58:57 GMT
Date:	Tue, 20 Mar 2007 10:58:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Deepak Saxena <dsaxena@plexity.net>
Cc:	mingo@elte.hu, linux-mips@linux-mips.org,
	Manish Lachwani <mlachwani@mvista.com>
Subject: Re: [PATCH] Make MIPS udelay() preempt safe
Message-ID: <20070320105856.GB24181@linux-mips.org>
References: <20070319234945.GA11944@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070319234945.GA11944@plexity.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 19, 2007 at 04:49:45PM -0700, Deepak Saxena wrote:

> Fix MIPS udelay to make is preempt safe under DEBUG_PREEMPT

I don't understand why you're withdrawing this patch - it makes perfect
sense as Atsushi has also already found, so I'm going to apply it.

  Ralf
