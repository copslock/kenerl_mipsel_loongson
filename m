Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2008 14:49:36 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:32199
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20034422AbYG3Nt3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2008 14:49:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6UDnMIp021328;
	Wed, 30 Jul 2008 14:49:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6UDnIFp021326;
	Wed, 30 Jul 2008 14:49:18 +0100
Date:	Wed, 30 Jul 2008 14:49:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mike Crowe <mac@mcrowe.com>
Cc:	linux-mips@linux-mips.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] MIPS: Convert printk statements during kernel setup to
	use severity levels
Message-ID: <20080730134918.GA20791@linux-mips.org>
References: <20080725134454.GA26225@mcrowe.com> <Pine.LNX.4.64.0807252002490.11082@anakin> <20080726125925.GB32426@mcrowe.com> <Pine.LNX.4.64.0807261517160.14397@anakin> <20080728121251.GA17679@mcrowe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080728121251.GA17679@mcrowe.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 28, 2008 at 01:12:52PM +0100, Mike Crowe wrote:
> From: Mike Crowe <mac@mcrowe.com>
> Date: Mon, 28 Jul 2008 13:12:52 +0100
> To: linux-mips@linux-mips.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: [PATCH] MIPS: Convert printk statements during kernel setup to use
> 	severity levels
> Content-Type: text/plain; charset=us-ascii
> 
> Signed-off-by: Mike Crowe <mac@mcrowe.com>

Thanks, applied.

  Ralf
