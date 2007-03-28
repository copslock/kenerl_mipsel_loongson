Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 21:35:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11724 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023144AbXC1UfU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 21:35:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2SKZ0DD013304;
	Wed, 28 Mar 2007 21:35:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2SKYxaY013303;
	Wed, 28 Mar 2007 21:34:59 +0100
Date:	Wed, 28 Mar 2007 21:34:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070328203459.GB12955@linux-mips.org>
References: <36E4692623C5974BA6661C0B18EE8EDF6CD5B2@MAILSERV.hcrest.com> <460AA1A0.1050508@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460AA1A0.1050508@avtrex.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 28, 2007 at 10:10:56AM -0700, David Daney wrote:

> Would you mind posting your patch to this list?
> 
> There are some of us that are using the same processor you are that 
> could find this helpful.

You only need this patch for kernels older than last week's -2.6.16-stable.
That is linux-2.6.16-stable, linux-2.6.17-stable have it applied.

  Ralf
