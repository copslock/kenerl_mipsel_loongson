Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 19:52:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16292 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039425AbXB1TwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 19:52:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SJqC9q022566;
	Wed, 28 Feb 2007 19:52:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SJqBY5022565;
	Wed, 28 Feb 2007 19:52:11 GMT
Date:	Wed, 28 Feb 2007 19:52:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070228195211.GD16562@linux-mips.org>
References: <45E4A247.7050407@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45E4A247.7050407@pmc-sierra.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 27, 2007 at 01:27:35PM -0800, Marc St-Jean wrote:

> I thought without the .fill that the kernel_entry function would be at
> the start of text. Apparently not, a quick test shows a crash with both
> the jal and .fill removed.

kernel_entry is __INIT so will actually end near the end of the the
executable.  That's why the j kernel_entry is needed at all.

  Ralf
