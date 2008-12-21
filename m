Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 17:08:11 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:2972 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24207671AbYLURII (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2008 17:08:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBLH887X015866;
	Sun, 21 Dec 2008 17:08:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBLH86bg015864;
	Sun, 21 Dec 2008 17:08:06 GMT
Date:	Sun, 21 Dec 2008 17:08:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/14] Alchemy: move development board code to common
	subdirectory
Message-ID: <20081221170806.GA10532@linux-mips.org>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net> <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 21, 2008 at 09:26:14AM +0100, Manuel Lauss wrote:

> Move alchemy development board code to common subdirectory. This should
> ease sharing of common devboard code.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

You're submitting this for 2.6.28 please ensure your patches apply
against the -queue tree.  There is already another patch in -queue touching
the Alchemy code so this patch rejects.  I fixed it up but it's avoidable
work ...

  Ralf
