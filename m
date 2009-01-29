Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 01:49:22 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:13467 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366465AbZA2BtU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 01:49:20 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0T1mFvC011560;
	Thu, 29 Jan 2009 01:48:16 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0T1mC0u011548;
	Thu, 29 Jan 2009 01:48:12 GMT
Date:	Thu, 29 Jan 2009 01:48:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] MIPS: Fix a typo in watchpoint register structure.
Message-ID: <20090129014811.GB8380@linux-mips.org>
References: <1230162266-4061-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1230162266-4061-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 24, 2008 at 03:44:26PM -0800, David Daney wrote:

> This fixes the ptrace ABI for watch registers, and should allow 64bit
> kernels to use the watch register support.

Thanks, applied.

  Ralf
