Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2005 12:12:13 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:7697 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133471AbVJJLL5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Oct 2005 12:11:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9ABBoOk007817;
	Mon, 10 Oct 2005 12:11:50 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9ABBo8Y007816;
	Mon, 10 Oct 2005 12:11:50 +0100
Date:	Mon, 10 Oct 2005 12:11:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Carlo Perassi <carlo@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: rfc about an uncommented string
Message-ID: <20051010111149.GC2661@linux-mips.org>
References: <20051009134106.GB9091@voyager>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051009134106.GB9091@voyager>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 09, 2005 at 03:41:06PM +0200, Carlo Perassi wrote:

> Hi.
> As suggested (*) by Arthur Othieno on the kernel-janitors mailing list,
> I bounce here this email for collecting comments.
> The old email refers to 2.6.13-rc6 but the code is still the same on
> 2.6.14-rc3.
> Thank you.
> 
> Hi.
> 
> I'd like to collect some comments about the following code
> segment I found in
> linux-2.6.13-rc6/arch/mips/ite-boards/generic/it8172_setup.c
> (the "^^^" sequence is not mine, it's in the code)

I know, I put it there.  The code was obviously broken, so I place this
hard to miss not right into the middle of it.  It's there since ages and
nobody did complain.  So unless somebody complains - and that complaint
better include some patches - I will delete support for the IT8172 and
it's eval board.

  Ralf
