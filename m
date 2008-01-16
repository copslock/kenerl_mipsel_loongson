Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 16:23:36 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13763 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574961AbYAPQXe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jan 2008 16:23:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0GGNVdB010367;
	Wed, 16 Jan 2008 16:23:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0GGNVdw010366;
	Wed, 16 Jan 2008 16:23:31 GMT
Date:	Wed, 16 Jan 2008 16:23:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Frank Rowand <frank.rowand@am.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] kernel make error - smtc_ipi.h irq flags, 2.6.24-rc7
Message-ID: <20080116162331.GA9918@linux-mips.org>
References: <1200436004.4092.26.camel@bx740>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1200436004.4092.26.camel@bx740>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 15, 2008 at 02:26:44PM -0800, Frank Rowand wrote:

> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> Fix compile warning (which becomes compile error due to -Werror).  Type of
> argument "flags" for spin_lock_irqsave() was incorrect in some functions.

Thanks, applied.

  Ralf
