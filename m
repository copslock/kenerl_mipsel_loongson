Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Feb 2008 11:38:07 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40929 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575546AbYBULiF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Feb 2008 11:38:05 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1LBc5fa009647;
	Thu, 21 Feb 2008 11:38:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1LBc4A4009646;
	Thu, 21 Feb 2008 11:38:04 GMT
Date:	Thu, 21 Feb 2008 11:38:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shailesh Suman <sumanshailesh@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tickless feature of 2.6.24 kernel on MIPS ?
Message-ID: <20080221113804.GA8894@linux-mips.org>
References: <812554.37524.qm@web51603.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812554.37524.qm@web51603.mail.re2.yahoo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 20, 2008 at 10:11:37PM -0800, Shailesh Suman wrote:

>    The 2.6.24.x kernel has Tickless (Power Management) feature for MIPS. Has anyone tried it for MIPS boards like Malta. 
> 
>    If anyone has tried it please let me know, if Tickless (CONFIG_NO_HZ)  is working fine. How is the power saving was measured and do you have any figures in terms of savings it can give.

It works except for SMTC which does it's own rather complicated time
keeping thing and the mix of SMTC and dyntick turned out to be rather
fragile.

  Ralf
