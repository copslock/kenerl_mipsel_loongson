Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 13:59:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:27101 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022240AbXF0M7L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Jun 2007 13:59:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5RCw4ul004909;
	Wed, 27 Jun 2007 14:58:04 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5RCw3Mq004908;
	Wed, 27 Jun 2007 14:58:03 +0200
Date:	Wed, 27 Jun 2007 14:58:03 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Philips(NXP)/STB810 changes
Message-ID: <20070627125803.GA4571@linux-mips.org>
References: <11229250.post@talk.nabble.com> <467A67B6.6090909@ru.mvista.com> <11232209.post@talk.nabble.com> <20070621142721.GC21938@linux-mips.org> <11246928.post@talk.nabble.com> <11247006.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11247006.post@talk.nabble.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 21, 2007 at 11:41:10PM -0700, Daniel Laird wrote:

> Please find the CORRECT patch below (Doh!!)
> 
> Setup the CMEM registers for PNX8550 correctly.
> 
> Signed-off-by: Daniel Laird <daniel.j.laird@NXP.com>

Hunk #2 succeeded at 938 (offset 2 lines).
patching file arch/mips/philips/pnx8550/common/setup.c
patch: **** malformed patch at line 118: resource))

  Ralf
