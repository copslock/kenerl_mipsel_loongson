Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2009 15:46:36 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42233 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492125AbZGQNq2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Jul 2009 15:46:28 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6HDkcnT014639;
	Fri, 17 Jul 2009 14:46:38 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6HDkbcc014637;
	Fri, 17 Jul 2009 14:46:37 +0100
Date:	Fri, 17 Jul 2009 14:46:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon PCIe: Make hardware and software bus
	numbers match.
Message-ID: <20090717134637.GC7396@linux-mips.org>
References: <1247620610-18399-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1247620610-18399-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 14, 2009 at 06:16:50PM -0700, David Daney wrote:

> Some SiliconImage PCIe SATA controlers are not detected when the bus
> numbers differ.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Applied to master.  Thanks,

  Ralf
