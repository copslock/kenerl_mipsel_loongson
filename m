Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 10:17:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41426 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S28573936AbZD1JRP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 10:17:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3S9HEf4029332;
	Tue, 28 Apr 2009 11:17:14 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3S9HEws029330;
	Tue, 28 Apr 2009 11:17:14 +0200
Date:	Tue, 28 Apr 2009 11:17:14 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Resolve use of non-existent GPIO routines in msp71xx
	reset
Message-ID: <20090428091714.GC28601@linux-mips.org>
References: <E1LygEz-00068K-17@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1LygEz-00068K-17@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 27, 2009 at 11:52:25PM -0600, Shane McDonald wrote:

> There have been a number of compile problems with the msp71xx
> configuration ever since it was included in the linux-mips.org
> repository.  This patch resolves compilation problems with attempting
> to reset the board using non-existent GPIO routines.
> 
> This patch has been compile-tested against the current HEAD.

Thanks, applied to 2.6.23 and up.

  Ralf
