Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 14:25:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60858 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021392AbXCFOZS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Mar 2007 14:25:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l26ENPiB022459;
	Tue, 6 Mar 2007 14:23:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l26ENNwS022458;
	Tue, 6 Mar 2007 14:23:23 GMT
Date:	Tue, 6 Mar 2007 14:23:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix __raw_read_trylock() to allow multiple readers
Message-ID: <20070306142323.GA20948@linux-mips.org>
References: <17900.51427.895657.607267@zeus.sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17900.51427.895657.607267@zeus.sw.starentnetworks.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 05, 2007 at 08:50:27PM -0500, Dave Johnson wrote:

> Perhaps someone can confirm this bug by a code inspection, but I
> think the below patch will fix the issue.

You're right, thanks!

Patch applied,

  Ralf
