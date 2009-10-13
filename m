Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 18:16:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49572 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493215AbZJMQQW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 18:16:22 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DGHXt2028053;
	Tue, 13 Oct 2009 18:17:36 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DGHMxh028050;
	Tue, 13 Oct 2009 18:17:22 +0200
Date:	Tue, 13 Oct 2009 18:17:22 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Octeon: Use
	write_lock_irqsave/write_unlock_irqrestore when setting irq
	affinity.
Message-ID: <20091013161722.GA27508@linux-mips.org>
References: <4AD4A1E9.1080309@caviumnetworks.com> <1255449149-22054-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255449149-22054-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 08:52:28AM -0700, David Daney wrote:

> Since the locks are used from interrupt context we need the
> irqsave/irqrestore versions of the locking functions.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Looks good, will apply.

  Ralf
