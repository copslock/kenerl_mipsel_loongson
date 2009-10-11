Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 15:38:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59587 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492415AbZJKNh5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 15:37:57 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9BDdCMT019250;
	Sun, 11 Oct 2009 15:39:12 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9BDdCkg019248;
	Sun, 11 Oct 2009 15:39:12 +0200
Date:	Sun, 11 Oct 2009 15:39:12 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Dearman <chris@mips.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Avoid potential hazard on Context register
Message-ID: <20091011133912.GA15684@linux-mips.org>
References: <4AD17619.1000201@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD17619.1000201@mips.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 10, 2009 at 11:07:21PM -0700, Chris Dearman wrote:

> set_saved_sp reads Context register. Avoid reading stale value from  
> earlier incomplete write

Which is executed fairly frequently.  So it'll be cheaper to fix the issue
in the writers.  Will post patch in a few minutes.

I'm curious, did you actually manage to trigger this one?  The time between
the instructions should be fairly long but then again the 34K has been
good for a few surprises!

  Ralf
