Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 12:01:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:1744 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044129AbXARMBd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Jan 2007 12:01:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0IC2XkK004809;
	Thu, 18 Jan 2007 12:02:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0IC2Xh2004808;
	Thu, 18 Jan 2007 12:02:33 GMT
Date:	Thu, 18 Jan 2007 12:02:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Anders Brogestam <anders.brogestam@avegasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: crt0.s for mips
Message-ID: <20070118120233.GA4440@linux-mips.org>
References: <1169094906.14832.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169094906.14832.3.camel@localhost>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 18, 2007 at 03:35:06PM +1100, Anders Brogestam wrote:

> I am looking for a crt0.s file for the MIPS architecture. Included in
> all the Linux kernels that I downloaded and looked in there are only
> source for the PPC.

crt0 is a file used ages ago for a.out.  So somehow sounds you're trying
a wrong solution - but what problem are you trying to solve anyway?

  Ralf
