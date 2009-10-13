Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 21:40:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46222 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493610AbZJMTko (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 21:40:44 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DJfvN1000804;
	Tue, 13 Oct 2009 21:41:58 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DJftcT000802;
	Tue, 13 Oct 2009 21:41:55 +0200
Date:	Tue, 13 Oct 2009 21:41:55 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Use lockless interrupt controller
	operations when possible.
Message-ID: <20091013194155.GA727@linux-mips.org>
References: <20091013162018.GB27508@linux-mips.org> <1255458363-8987-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255458363-8987-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 11:26:03AM -0700, David Daney wrote:

> Some newer Octeon chips have registers that allow lockless operation
> of the interrupt controller.  Take advantage of them.

Thanks, applied.

  Ralf
