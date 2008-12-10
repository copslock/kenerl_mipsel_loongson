Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 16:54:38 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:40667 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24207695AbYLJQyf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2008 16:54:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBAGsW0I008256;
	Wed, 10 Dec 2008 16:54:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBAGsVfO008254;
	Wed, 10 Dec 2008 16:54:31 GMT
Date:	Wed, 10 Dec 2008 16:54:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use ei/di for mipsr2.
Message-ID: <20081210165431.GA7681@linux-mips.org>
References: <493FF045.1020803@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493FF045.1020803@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 10, 2008 at 08:37:25AM -0800, David Daney wrote:

> For mipsr2, use the ei and di instructions to enable and disable
> interrupts.

Thanks for breaking this one out; this is something that was simply
somehow missed when the inline assembler versions were changed.

Applied,

  Ralf
