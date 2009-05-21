Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 18:20:59 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33134 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023797AbZEURUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 18:20:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4LHKUvB029450;
	Thu, 21 May 2009 18:20:30 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4LHKTgY029446;
	Thu, 21 May 2009 18:20:29 +0100
Date:	Thu, 21 May 2009 18:20:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Remove 'ehb' instructions from Cavium TLB handlers.
Message-ID: <20090521172029.GA27013@linux-mips.org>
References: <4A09D0B1.2030305@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A09D0B1.2030305@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 12, 2009 at 12:40:33PM -0700, David Daney wrote:

> The Cavium Octeon CPU never needs the ehb instruction, this patch set
> removes it resulting in shorter TLB handler hot paths.

Whole series applied for -queue and -next.

Thanks,

  Ralf
