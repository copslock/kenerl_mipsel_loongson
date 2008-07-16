Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 13:21:51 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:15293
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28580228AbYGPMVt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 13:21:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6GCLkun030350;
	Wed, 16 Jul 2008 13:21:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6GCLjAu030346;
	Wed, 16 Jul 2008 13:21:45 +0100
Date:	Wed, 16 Jul 2008 13:21:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix merge bug
Message-ID: <20080716122144.GA29879@linux-mips.org>
References: <20080716120615.ECBF2C2B2E@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080716120615.ECBF2C2B2E@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 02:06:15PM +0200, Thomas Bogendoerfer wrote:

> Instead of one SGI_HAS_HAL2 for IP22 and one for IP28, IP28 got two of
> them... Let's give IP22 some ALSA sound, too.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, applied.

  Ralf
