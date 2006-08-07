Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2006 20:31:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:24211 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20040493AbWHGTbf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2006 20:31:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k77JVZsT009081;
	Mon, 7 Aug 2006 20:31:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k77JVZvC009080;
	Mon, 7 Aug 2006 20:31:35 +0100
Date:	Mon, 7 Aug 2006 20:31:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kishore K <hellokishore@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Problem booting malta with 2.4.33-rc1
Message-ID: <20060807193134.GA10778@linux-mips.org>
References: <f07e6e0608062331p4ef621afn67764067f5b822c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07e6e0608062331p4ef621afn67764067f5b822c2@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 07, 2006 at 12:01:43PM +0530, Kishore K wrote:

> Hi,
> When trying to bring up Malta (4KC) board with 2.4.33-rc1 from linux-mips,
> the kernel crashes. Boot log is enclosed along with this mail. I am using
> the tool chain based on gcc 3.3.6, uClibc-0.9.27, binutils 2.14.90.0.8.
> When the same tool chain is used for 2.4.31 kernel, the board comes up
> without any issues.
> 
> Observed the same issue with tool chain based on gcc 3.4.4, uClibc-0.9.28,
> binutils 2.15.94. Same result is observed even with  Malta 24KEC and
> 2.4.33-rc1 kernel.
> 
> Does any one observe the same behaviour ? Am I missing something obvious
> here ?

A kernel update.  2.4.33-rc2 fix a number of Malta issues or better 2.6.

Note that fixing any issues in 2.4 has next to null priority these days.
Read somewhere below watching paint dry.

  Ralf
