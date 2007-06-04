Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 15:34:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:33465 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022410AbXFDOeX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 15:34:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l54EY3lB029470;
	Mon, 4 Jun 2007 15:34:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l54EY3qt029469;
	Mon, 4 Jun 2007 15:34:03 +0100
Date:	Mon, 4 Jun 2007 15:34:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Adding more MIPS configuration for PNX8550 systems
Message-ID: <20070604143403.GC24975@linux-mips.org>
References: <10946489.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10946489.post@talk.nabble.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 04, 2007 at 02:33:28AM -0700, Daniel Laird wrote:

> The following patch allows for MIPS processor setup on pnx8550 systems

This patch and the other patch you've posted add various definitions but
don't add any user for them.  Is this really the complete patch set?

Also please add a Signed-off-by: line to each patch.

Thanks,

   Ralf
