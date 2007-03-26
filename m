Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 15:34:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:60345 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021456AbXCZOeD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 15:34:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2QEXo0k015698;
	Mon, 26 Mar 2007 15:33:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2QEXmoj015696;
	Mon, 26 Mar 2007 15:33:48 +0100
Date:	Mon, 26 Mar 2007 15:33:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ravi Pratap <Ravi.Pratap@hillcrestlabs.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, miklos@szeredi.hu,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070326143348.GB14354@linux-mips.org>
References: <20070326.223134.79300616.anemo@mba.ocn.ne.jp> <36E4692623C5974BA6661C0B18EE8EDF6CD3FC@MAILSERV.hcrest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD3FC@MAILSERV.hcrest.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 26, 2007 at 09:36:33AM -0400, Ravi Pratap wrote:

> > I confirmed current git tree works fine for me.  Thanks.
> 
> Great! Pardon my ignorance in asking this question but when will I be
> able to grab a stable release that includes this change?

Yes, at this time either directly from the lmo git tree or the
linux-2.6.20.4 tarball also from lmo.

  Ralf
