Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2009 17:40:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29655 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20031969AbZDQQkO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2009 17:40:14 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3HGeCK6031101;
	Fri, 17 Apr 2009 18:40:12 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3HGeB5i031099;
	Fri, 17 Apr 2009 18:40:11 +0200
Date:	Fri, 17 Apr 2009 18:40:11 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Use 32-bit compatibility wrapers for
	sys_timerfd_{g,s}ettime
Message-ID: <20090417164011.GB24640@linux-mips.org>
References: <1239898817-3443-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1239898817-3443-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 16, 2009 at 09:20:17AM -0700, David Daney wrote:

> The LTP timerfd01 test is failing (blocking forever) on the 32-bit
> ABIs. We need to use the compat_* wrappers for these system calls.

Thanks, applied to 2.6.25-stable and up.

  Ralf
