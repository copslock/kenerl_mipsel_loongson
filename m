Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 21:44:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34543 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493077AbZKEUoS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 21:44:18 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA5KjlKp012660;
	Thu, 5 Nov 2009 21:45:48 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA5KjlPW012658;
	Thu, 5 Nov 2009 21:45:47 +0100
Date:	Thu, 5 Nov 2009 21:45:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] netdev: Fix compile error in Octeon MGMT driver.
Message-ID: <20091105204547.GA10292@linux-mips.org>
References: <1257449912-27978-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257449912-27978-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 05, 2009 at 11:38:32AM -0800, David Daney wrote:

> Explicitly include linux/capability.h.  Under some configurations it
> wasn't being indirectly included.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> This fixes a minor problem for the (already approved) patches that
> Ralf has queued for 2.6.33.  It should probably be added to Ralf's
> queue.
> 
>  drivers/net/octeon/octeon_mgmt.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Folded into the existing patch.  Thanks!

  Ralf
