Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 13:59:09 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:48784 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20036581AbXJOM7H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 13:59:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9FCx6IE011874;
	Mon, 15 Oct 2007 13:59:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9FCx5md011873;
	Mon, 15 Oct 2007 13:59:05 +0100
Date:	Mon, 15 Oct 2007 13:59:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Compile problems with latest GIT kernel version
Message-ID: <20071015125905.GA11725@linux-mips.org>
References: <1192349561.17182.11.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1192349561.17182.11.camel@scarafaggio>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 14, 2007 at 10:12:41AM +0200, Giuseppe Sacco wrote:

> Hi *,
> I am investigating a new problem (already reported in this list by
> Martin Michlmayr) about the serial device on the SGI O2. While
> recompiling the latest kernel I get this error:

I fixed that issue even before reading your email.  But the fix is untested
beyond mere compilation so I'd apreciate if you could test the latest
tree and report.

Thanks,

  Ralf
