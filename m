Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 19:05:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:50591 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20033600AbXLLTFq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 19:05:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBCJ4ubF026639;
	Wed, 12 Dec 2007 19:04:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBCJ4tpd026638;
	Wed, 12 Dec 2007 19:04:55 GMT
Date:	Wed, 12 Dec 2007 19:04:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Chris Friesen <cfriesen@nortel.com>, linux-mips@linux-mips.org
Subject: Re: questions on struct sigcontext
Message-ID: <20071212190455.GB26190@linux-mips.org>
References: <47601DEE.4090200@nortel.com> <20071212190032.GA30506@caradoc.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071212190032.GA30506@caradoc.them.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 02:00:32PM -0500, Daniel Jacobowitz wrote:

> There used to be slots for badvaddr and cause.  You'll have to ask
> Ralf why he decided to clobber them for DSP state, I don't remember
> :-)  I suspect they may never have held useful information for you;
> we don't context switch them for userspace, so an intervening fault
> in kernel space or in another thread could change them.

Correct, we never filled badvaddr and cause, so it was easy to recycle
those fields.

  Ralf
